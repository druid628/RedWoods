<?php

require_once dirname(__FILE__).'/../lib/oddsGeneratorConfiguration.class.php';
require_once dirname(__FILE__).'/../lib/oddsGeneratorHelper.class.php';

/**
 * odds actions.
 *
 * @package    OddsThomas
 * @subpackage odds
 * @author     druid628
 * @version    SVN: $Id: actions.class.php 23810 2009-11-12 11:07:44Z Kris.Wallsmith $
 */
class oddsActions extends autoOddsActions
{
	public function executeNew(sfWebRequest $request)
	{
		$game = $request->getParameter('game_id');
		$this->form = new OddsForm();
		$this->odds = $this->form->getObject();
		if(isset($game))
			$this->form->setGame($game);
	}
}
