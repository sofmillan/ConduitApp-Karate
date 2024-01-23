package performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

import conduitApp.performance.createToken.CreateTokens


class PerfTest extends Simulation {

   CreateTokens.createAccessTokens()

  val protocol = karateProtocol(//Karate is handling the HTTP request for us 
    "/api/articles/{articleId}" -> Nil  //multiple requests of the same endpoint will be reported together
  ) 
   protocol.nameResolver = (req, ctx) => req.getHeader("karateName")

  val csvFeeder = csv("articles.csv").circular()
  val tokenFeeder = Iterator.continually {
     Map("token" -> CreateTokens.getNextToken() )}

  val createArticle = scenario("Create and delete article")
  .feed(csvFeeder)
  .feed(tokenFeeder)
  .exec(karateFeature("classpath:conduitApp/performance/CreateArticle.feature"))
  
  //Inject a user is a session starting our scenario
  setUp(
    createArticle.inject(
      atOnceUsers(1),
      nothingFor(4 seconds),
      constantUsersPerSec(1) during (2 seconds)
      constantUsersPerSec(2) during (10 seconds),
      rampUsersPerSec(2) to 10 during (20 seconds),
      nothingFor(5 seconds),
      constantUsersPerSec(1) during (5 seconds)
    ).protocols(protocol)  
    )

}