<td colspan="8">
  <?php echo __('%%odds_id%% - %%game_id%% - %%team1%% - %%draw%% - %%team2%% - %%active%% - %%created_at%% - %%updated_at%%', array('%%odds_id%%' => link_to($odds->getOddsId(), 'odds_edit', $odds), '%%game_id%%' => $odds->getGameId(), '%%team1%%' => $odds->getTeam1(), '%%draw%%' => $odds->getDraw(), '%%team2%%' => $odds->getTeam2(), '%%active%%' => get_partial('odds/list_field_boolean', array('value' => $odds->getActive())), '%%created_at%%' => false !== strtotime($odds->getCreatedAt()) ? format_date($odds->getCreatedAt(), "f") : '&nbsp;', '%%updated_at%%' => false !== strtotime($odds->getUpdatedAt()) ? format_date($odds->getUpdatedAt(), "f") : '&nbsp;'), 'messages') ?>
</td>
