def gitUrl = "https://github.com/onaiv22/aws-serverless.git"

job("MyProject-Build") {
  description "Build MyProject from master branch."
  parameters {
    stringParam('Branch', 'master', 'Commit to build')
  }
  scm {
    git {
      remote {
        url gitUrl
        branch "origin/master"
      }
    }
  }
}
