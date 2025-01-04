<?php
  class mainComponents extends sfComponents
  {
    public function executeMenuBar(sfWebRequest $request)
    {
    	$response = $this->getResponse();
    	$response->addJavascript('jq-menubar.js');
    	$response->addStylesheet('navigation.css');
    }

    public function executeNavi(sfWebRequest $request)
    {

    }

    public function executeFooter(sfWebRequest $request)
    {

    }
  }