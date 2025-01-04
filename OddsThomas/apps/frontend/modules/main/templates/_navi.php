<div class="oddNavigation">
	<div class="oddMenuItem"><?PHP echo link_to('Home', 'main/index'); ?></div>
	<div class="oddMenuItem"><?PHP echo link_to('Games', 'game/index'); ?></div>
	<div class="oddMenuItem"><?PHP echo link_to('Bets', 'bet/index'); ?></div>
	<?PHP  if($sf_user->hasPermission('AddOdds')): ?>
		<div class="oddMenuItem"><?PHP echo link_to('Odds', 'odds/index'); ?></div>
	<?PHP endif; ?>
	<?PHP  if($sf_user->hasGroup('admin')): ?>
		<div class="oddMenuItem"><?PHP echo link_to('Users', 'sfGuardUser/index'); ?></div>
	<?PHP endif; ?>
	<div class="oddMenuItem"><?PHP #echo link_to('Search', 'bondee/index'); ?></div>
	<div class="logout"><?PHP echo link_to('Logout', '@sf_guard_signout'); ?></div>
</div>