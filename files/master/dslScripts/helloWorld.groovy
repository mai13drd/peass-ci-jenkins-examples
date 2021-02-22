job('example') {

  scm {
        github('dagere/peass', 'master')
    }

  label('agent-1')

  triggers {
             hudsonStartupTrigger {
               quietPeriod('3')
               runOnChoice('ON_CONNECT')
               label('agent-1')
               nodeParameterName('')
             }
  }

  steps {
    maven('clean install -DskipTests')
  }

}
