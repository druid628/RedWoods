<BR/>
<h3>Welcome to the betting pool!</h3>
<h4>Your Bets</h4>
<table id="yourBets" >
	<thead>
	<th>Game</th>
	<th>Team</th>
	<th>Amount Bet</th>
	<th>Odds</th>
	</thead>
	<tbody>
<?PHP $row = 0; ?>
<?PHP foreach($bets as $key => $bet): ?>
		<?PHP $altRow = ($row % 2) ? "altRow" : ""; $row++; ?>
		<tr class="<?PHP echo $altRow ?>" >
			<td><?PHP echo $bet['Game']['team1'] . " vs. " . $bet['Game']['team2']?></td>
			<td><?PHP echo ($bet['pick'] != 'draw') ? $bet['Game'][$bet['pick']] : 'Draw' ?></td>
			<td><?PHP echo $bet['amount'] ?></td>
			<td><?PHP echo $bet['odds'] ?></td>
		</tr>
<?PHP endforeach; ?>
	</tbody>
</table>

<br/>
.::. <a href="http://www.druid628.com/">DruiD</a> .::.