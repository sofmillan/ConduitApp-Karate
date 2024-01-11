function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://api.realworld.io/api/'
  }
  if (env == 'dev') {
    config.userEmail = 'sugarcoat@gmail.com'
    config.userPassword = 'natty'
  } else if (env == 'qa') {
    config.userEmail = 'sugarcoat123@gmail.com'
    config.userPassword = 'natty'
  }

  var accessToken = karate.callSingle('classpath:helpers/GenerateToken.feature', config).authToken
  karate.configure('headers', {Authorization:'Token '+accessToken} )
  return config;
}