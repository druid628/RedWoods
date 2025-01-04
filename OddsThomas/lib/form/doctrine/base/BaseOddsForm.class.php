<?php

/**
 * Odds form base class.
 *
 * @method Odds getObject() Returns the current form's model object
 *
 * @package    OddsThomas
 * @subpackage form
 * @author     druid628
 * @version    SVN: $Id: sfDoctrineFormGeneratedTemplate.php 29553 2010-05-20 14:33:00Z Kris.Wallsmith $
 */
abstract class BaseOddsForm extends BaseFormDoctrine
{
  public function setup()
  {
    $this->setWidgets(array(
      'odds_id'    => new sfWidgetFormInputHidden(),
      'game_id'    => new sfWidgetFormDoctrineChoice(array('model' => $this->getRelatedModelName('Game'), 'add_empty' => false)),
      'team1'      => new sfWidgetFormInputText(),
      'draw'       => new sfWidgetFormInputText(),
      'team2'      => new sfWidgetFormInputText(),
      'active'     => new sfWidgetFormInputCheckbox(),
      'created_at' => new sfWidgetFormDateTime(),
      'updated_at' => new sfWidgetFormDateTime(),
    ));

    $this->setValidators(array(
      'odds_id'    => new sfValidatorChoice(array('choices' => array($this->getObject()->get('odds_id')), 'empty_value' => $this->getObject()->get('odds_id'), 'required' => false)),
      'game_id'    => new sfValidatorDoctrineChoice(array('model' => $this->getRelatedModelName('Game'))),
      'team1'      => new sfValidatorString(array('max_length' => 10, 'required' => false)),
      'draw'       => new sfValidatorString(array('max_length' => 10, 'required' => false)),
      'team2'      => new sfValidatorString(array('max_length' => 10, 'required' => false)),
      'active'     => new sfValidatorBoolean(array('required' => false)),
      'created_at' => new sfValidatorDateTime(),
      'updated_at' => new sfValidatorDateTime(),
    ));

    $this->widgetSchema->setNameFormat('odds[%s]');

    $this->errorSchema = new sfValidatorErrorSchema($this->validatorSchema);

    $this->setupInheritance();

    parent::setup();
  }

  public function getModelName()
  {
    return 'Odds';
  }

}
