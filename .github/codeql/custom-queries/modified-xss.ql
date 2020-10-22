/**
 * @name Modified XSS
 * @description Reinterpreting text from the DOM as HTML
 *              can lead to a cross-site scripting vulnerability.
 * @kind path-problem
 * @problem.severity warning
 */

import javascript
import semmle.javascript.frameworks.jQuery::JQuery
import semmle.javascript.security.dataflow.DomBasedXss::DomBasedXss
import DataFlow::PathGraph

class AjaxSource extends Source {
    AjaxSource() {  
        exists(
            MethodCall m | 
            m.getMethodName() = "ajax" and 
            this.(DataFlow::ParameterNode).getParameter() = 
            m.getAnArgument().asExpr().(ObjectExpr).getAProperty().getInit().(FunctionExpr).getAParameter()
          )
    }

}

class AjaxSink extends Sink {
    AjaxSink() { 
        exists(
        PropAccess p | 
        p.getPropertyName() = "innerHTML" and
        this.asExpr() = p.getParentExpr().(Assignment).getRhs()
      )
    }
}

class AjaxConfiguration extends TaintTracking::Configuration {
  AjaxConfiguration() { this = "AjaxConfiguration" }

  //predicate for source
  override predicate isSource(DataFlow::Node source) {
    //specify source
    exists(AjaxSource ajaxSource | source = ajaxSource)
  }

  //predicate for sink
  override predicate isSink(DataFlow::Node sink) {
    //specify sink
    exists(AjaxSink ajaxSink | sink = ajaxSink)
  }
  
  //predicate for realizing the flow from the ajax node to a tainted parameter
  override predicate isAdditionalTaintStep(DataFlow::Node nodeFrom, DataFlow::Node nodeTo) {
    exists(
        AjaxSource ajaxSource, Function f | 
        nodeFrom = ajaxSource and
        nodeTo.asExpr() = f.getAParameter()
    )
  }
}

from AjaxConfiguration config, DataFlow::PathNode source, DataFlow::PathNode sink
where config.hasFlowPath(source, sink)
select sink, source, sink, "There's something vulnerable about this."
