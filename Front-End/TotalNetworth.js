function Calculate_Networth()
{

	var table = 
		$.get('edit.html', 'stats_table');
	var row_counter;
	var total_Networth;
	for (row_counter = 1; row_counter < table.rows.length; row_counter++)
	{
		total_Networth += parseFloat(table.rows[row_counter].cells[1].innerHTML);
	}
	return total_Networth;
}