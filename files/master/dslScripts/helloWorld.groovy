job('demo-project') {

  label('agent-1')

  scm {
        github('mai13drd/demo-project')
    }

  triggers {
             hudsonStartupTrigger {
               quietPeriod('3')
               runOnChoice('ON_CONNECT')
               label('agent-1')
               nodeParameterName('')
             }
  }

}
