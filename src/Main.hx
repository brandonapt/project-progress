class Main {
	// beginning inputs
	static var beginning_units:Int = 6000;
	static var beginning_dmc:Float = 10000.00;
	static var beginning_cc:Float = 4000.00;

	// monthly costs
	static var monthly_dmc:Float = 36000.00;
	static var monthly_cc:Float = 18000.00;

	// other
	static var monthly_completed:Int = 6000;
	static var ending_inventory:Int = 1500;

	// vars to be changed
	static var mat_cpu:Float;
	static var con_cpu:Float;

	static function calculate_eup():Float {
		var eup_for_materials:Float = monthly_completed + ending_inventory;
		var eup_for_conversion:Float = monthly_completed + (ending_inventory * .4);
		trace('eup for materials: $eup_for_materials');
		trace('eup for conversion : $eup_for_conversion');

		return eup_for_conversion;
	}

	static function calculate_cpeu(eup_conversion: Float):Void {
		var total_materials_cost:Float = beginning_dmc + monthly_dmc;
		var cost_per_eup_m:Float = total_materials_cost / (beginning_units + ending_inventory);
		
		var total_conversion_cost:Float = beginning_cc + monthly_cc; 
		var cost_per_eup_c:Float = total_conversion_cost / eup_conversion;

		trace('total material cost: $total_materials_cost');
		trace('cost per eup for materials $cost_per_eup_m');
		trace('total conversion cost: $total_conversion_cost');
		trace('cost per eup for conversion: $cost_per_eup_c');

		con_cpu = cost_per_eup_c;
		mat_cpu = cost_per_eup_m;
	}

	static function cut():Void {
		var total_cpu_tout:Float = mat_cpu + con_cpu;
		var total_cost_units_tout:Float = monthly_completed * total_cpu_tout;
		var mat_ending:Float = ending_inventory * mat_cpu;
		var con_ending:Float = ending_inventory * .4 * con_cpu;
		var total_cost_ending:Float = mat_ending + con_ending;

		trace('total cost per unit transferred out: $total_cpu_tout');
		trace('total cost of units transferred out: $total_cost_units_tout');
		trace('materials in ending wip: $mat_ending');
		trace('conversion in ending wip: $con_ending');
		trace('total cost of ending wip: $total_cost_ending');
	}
	
	static function main():Void {
		var eup_cons:Float = calculate_eup();
		calculate_cpeu(eup_cons);
		cut();
	}
}
