<?php

/**
 * main actions.
 *
 * @package    OddsThomas
 * @subpackage main
 * @author     druid628
 * @version    SVN: $Id: actions.class.php 23810 2009-11-12 11:07:44Z Kris.Wallsmith $
 */
class mainActions extends sfActions
{
 /**
  * Executes index action
  *
  * @param sfRequest $request A request object
  */
  public function executeIndex(sfWebRequest $request)
  {
	  $this->bets = Doctrine_Query::create()
	  	->from('Bet b')
	      	->innerJoin('b.Game g')
	        ->where('b.user_id = ' . $this->getUser()->getGuardUser()->getId())
		->fetchArray();
	  
  }
}
