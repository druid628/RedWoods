<?php use_helper('I18N', 'Date') ?>
<?php include_partial('odds/assets') ?>

<div id="sf_admin_container" class="sf_admin_edit ui-widget ui-widget-content ui-corner-all">
  <div class="fg-toolbar ui-widget-header ui-corner-all">
    <h1><?php echo __('New Odds', array(), 'messages') ?></h1>
  </div>

  <?php include_partial('odds/flashes') ?>

  <div id="sf_admin_header">
    <?php include_partial('odds/form_header', array('odds' => $odds, 'form' => $form, 'configuration' => $configuration)) ?>
  </div>

  <div id="sf_admin_content">
    <?php include_partial('odds/form', array('odds' => $odds, 'form' => $form, 'configuration' => $configuration, 'helper' => $helper)) ?>
  </div>

  <div id="sf_admin_footer">
    <?php include_partial('odds/form_footer', array('odds' => $odds, 'form' => $form, 'configuration' => $configuration)) ?>
  </div>

  <?php include_partial('odds/themeswitcher') ?>
</div>
