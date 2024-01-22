package performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class PerfTest extends Simulation {

  val protocol = karateProtocol() //Karate is handling the HTTP request for us 

  val createArticle = scenario("Create and delete article").exec(karateFeature("classpath:conduitApp/performance/CreateArticle.feature"))
  

  setUp(
    createArticle.inject(atOnceUsers(1)
    ).protocols(protocol)  
    )

}