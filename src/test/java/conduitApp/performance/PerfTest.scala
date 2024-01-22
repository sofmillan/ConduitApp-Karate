package performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class PerfTest extends Simulation {

  val protocol = karateProtocol(//Karate is handling the HTTP request for us 
    "/api/articles/{articleId}" -> Nil  //multiple requests of the same endpoint will be reported together

  ) 
  val createArticle = scenario("Create and delete article").exec(karateFeature("classpath:conduitApp/performance/CreateArticle.feature"))
  

  setUp(
    createArticle.inject(atOnceUsers(2)
    ).protocols(protocol)  
    )

}