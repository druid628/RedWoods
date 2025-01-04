<?php

/**
 * Game form base class.
 *
 * @method Game getObject() Returns the current form's model object
 *
 * @package    OddsThomas
 * @subpackage form
 * @author     druid628
 * @version    SVN: $Id: sfDoctrineFormGeneratedTemplate.php 29553 2010-05-20 14:33:00Z Kris.Wallsmith $
 */
abstract class BaseGameForm extends BaseFormDoctrine
{
  public function setup()
  {
    $this->setWidgets(array(
      'game_id'    => new sfWidgetFormInputHidden(),
      'team1'      => new sfWidgetFormInputText(),
      'team2'      => new sfWidgetFormInputText(),
      'result'     => new sfWidgetFormInputText(),
      'active'     => new sfWidgetFormInputCheckbox(),
      'created_at' => new sfWidgetFormDateTime(),
      'updated_at' => new sfWidgetFormDateTime(),
    ));

    $this->setValidators(array(
      'game_id'    => new sfValidatorChoice(array('choices' => array($this->getObject()->get('game_id')), 'empty_value' => $this->getObject()->get('game_id'), 'required' => false)),
      'team1'      => new sfValidatorString(array('max_length' => 100)),
      'team2'      => new sfValidatorString(array('max_length' => 100)),
      'result'     => new sfValidatorString(array('max_length' => 10, 'required' => false)),
      'active'     => new sfValidatorBoolean(array('required' => false)),
      'created_at' => new sfValidatorDateTime(),
      'updated_at' => new sfValidatorDateTime(),
    ));

    $this->widgetSchema->setNameFormat('game[%s]');

    $this->errorSchema = new sfValidatorErrorSchema($this->validatorSchema);

    $this->setupInheritance();

    parent::setup();
  }

  public function getModelName()
  {
    return 'Game';
  }

}
