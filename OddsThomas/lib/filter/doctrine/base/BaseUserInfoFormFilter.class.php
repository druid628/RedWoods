<?php

/**
 * UserInfo filter form base class.
 *
 * @package    OddsThomas
 * @subpackage filter
 * @author     druid628
 * @version    SVN: $Id: sfDoctrineFormFilterGeneratedTemplate.php 29570 2010-05-21 14:49:47Z Kris.Wallsmith $
 */
abstract class BaseUserInfoFormFilter extends BaseFormFilterDoctrine
{
  public function setup()
  {
    $this->setWidgets(array(
      'balance'     => new sfWidgetFormFilterInput(),
      'last_payday' => new sfWidgetFormFilterDate(array('from_date' => new sfWidgetFormDate(), 'to_date' => new sfWidgetFormDate())),
    ));

    $this->setValidators(array(
      'balance'     => new sfValidatorSchemaFilter('text', new sfValidatorNumber(array('required' => false))),
      'last_payday' => new sfValidatorDateRange(array('required' => false, 'from_date' => new sfValidatorDateTime(array('required' => false, 'datetime_output' => 'Y-m-d 00:00:00')), 'to_date' => new sfValidatorDateTime(array('required' => false, 'datetime_output' => 'Y-m-d 23:59:59')))),
    ));

    $this->widgetSchema->setNameFormat('user_info_filters[%s]');

    $this->errorSchema = new sfValidatorErrorSchema($this->validatorSchema);

    $this->setupInheritance();

    parent::setup();
  }

  public function getModelName()
  {
    return 'UserInfo';
  }

  public function getFields()
  {
    return array(
      'user_id'     => 'Number',
      'balance'     => 'Number',
      'last_payday' => 'Date',
    );
  }
}
