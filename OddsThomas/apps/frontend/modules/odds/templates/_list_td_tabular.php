<td class="sf_admin_text sf_admin_list_td_odds_id">
  <?php echo link_to($odds->getOddsId(), 'odds_edit', $odds) ?>
</td>
<td class="sf_admin_foreignkey sf_admin_list_td_game_id">
  <?php echo $odds->getGameId() ?>
</td>
<td class="sf_admin_text sf_admin_list_td_team1">
  <?php echo $odds->getTeam1() ?>
</td>
<td class="sf_admin_text sf_admin_list_td_draw">
  <?php echo $odds->getDraw() ?>
</td>
<td class="sf_admin_text sf_admin_list_td_team2">
  <?php echo $odds->getTeam2() ?>
</td>
<td class="sf_admin_boolean sf_admin_list_td_active">
  <?php echo get_partial('odds/list_field_boolean', array('value' => $odds->getActive())) ?>
</td>
<td class="sf_admin_date sf_admin_list_td_created_at">
  <?php echo false !== strtotime($odds->getCreatedAt()) ? format_date($odds->getCreatedAt(), "f") : '&nbsp;' ?>
</td>
<td class="sf_admin_date sf_admin_list_td_updated_at">
  <?php echo false !== strtotime($odds->getUpdatedAt()) ? format_date($odds->getUpdatedAt(), "f") : '&nbsp;' ?>
</td>
