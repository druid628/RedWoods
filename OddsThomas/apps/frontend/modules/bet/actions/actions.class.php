<?php

require_once dirname(__FILE__).'/../lib/betGeneratorConfiguration.class.php';
require_once dirname(__FILE__).'/../lib/betGeneratorHelper.class.php';

/**
 * bet actions.
 *
 * @package    OddsThomas
 * @subpackage bet
 * @author     druid628
 * @version    SVN: $Id: actions.class.php 23810 2009-11-12 11:07:44Z Kris.Wallsmith $
 */
class betActions extends autoBetActions
{
	public function executeNew(sfWebRequest $request)
	{
		$this->form = $this->configuration->getForm();
		$this->bet = $this->form->getObject();
		if($request->hasParameter('game_id'))
		{
			$ws = $this->form->getWidgetSchema();
			$ws['game_id'] = new sfWidgetFormInputHidden(array(), array('value'=> $request->getParameter('game_id')));
			$ws['user_id'] = new sfWidgetFormInputHidden(array(), array('value'=> $this->getUser()->getGuardUser()->getId()));

			$dc = Doctrine_Query::create()
			    ->from('Odds o')
			    ->where('o.game_id = ' . $request->getParameter('game_id'))
			    ->andWhere('o.active = 1')
			    ->execute();

			$blah = Doctrine_Query::create()
			    ->select('g.team1, g.team2')
			    ->from('Game g')
			    ->where('g.game_id = '. $request->getParameter('game_id'))
			    ->fetchArray();

			unset($blah[0]['game_id']);
			$choices = array_merge($blah[0], array('draw' => 'Draw'));


			$ws['amount']->setLabel('Amount<br/><font size=\'1\' color=\'#880000\'>(Min. 500)</font>');
			$ws['pick'] = new sfWidgetFormChoice(array('label' => 'Pick', 'choices' => $choices));
		}
	}
}
