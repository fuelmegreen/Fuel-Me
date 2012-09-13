// JavaScript Document
function round(myvariable, decplaces){
	var str = ""+ Math.round(eval(myvariable)*Math.pow(10,decplaces))
	while (str.length<= decplaces) {
		str = "0" + str
	}
	var decpoint = str.length - decplaces
	return str.substring(0, decpoint);
}

function toggleMpgType(){
    clearTotals()
	var combRow=document.getElementById("combMpgRow")
	var cityRow=document.getElementById("cityMpgRow")
	var hwyRow=document.getElementById("hwyMpgRow")
	var cityMiRow=document.getElementById("cityPercentRow")

    //Note: I test for the 'wrong' radio button here since the check changes after the function is run
	if (document.calculator.RadioGroup1[1].checked == true) {
        combRow.style.display="none"
        cityRow.style.display=""
        hwyRow.style.display=""
        cityMiRow.style.display=""
        mpgToggleValue="detailed"
        } else {
        combRow.style.display=""
        cityRow.style.display="none"
        hwyRow.style.display="none"
        cityMiRow.style.display="none"
        mpgToggleValue="combined"
	}
}

function calculateMpg(){
	if (document.calculator.RadioGroup1[0].checked == true){
	    calculate()
	  } else {
	    calculatedetail()
	}
      calcAnnDiff()
      calcLifeDiff()
}

function calcAnnDiff (){
    //If annual costs for both cars are not null, perform calculation
    var annualDiffRow=document.getElementById("annDiffRow")
    if (document.calculator.anncost1.value!="" && document.calculator.anncost2.value!=""){
        annualDiffRow.style.display=""
        var annCostCompare1 = (+document.calculator.anncost1.value.substr(2))
        var annCostCompare2 = (+document.calculator.anncost2.value.substr(2))
        //If annual costs for both cars are equal, savings is zero
        if (annCostCompare1==annCostCompare2){
            document.calculator.anncostdiff.value="Annual fuel costs for these cars are the same."
            } else {
            //If annual costs are not equal, show savings for better car
            var savings = Math.abs(annCostCompare1-annCostCompare2)
            if (annCostCompare1 < annCostCompare2){
                document.calculator.anncostdiff.value="Car 1 saves you $"+savings+" each year."
                } else {
                document.calculator.anncostdiff.value="Car 2 saves you $"+savings+" each year."
            }
          }
        } else {
        annualDiffRow.style.display="none"
    }
}

function calcLifeDiff (){
    var lifetimeDiffRow = document.getElementById("lifeDiffRow")
    if (document.calculator.lifecost1.value!="" && document.calculator.lifecost2.value!=""){
        lifetimeDiffRow.style.display=""
        var years=(+document.calculator.years1.value)
        var lifeCostCompare1 = (+document.calculator.lifecost1.value.substr(2))
        var lifeCostCompare2 = (+document.calculator.lifecost2.value.substr(2))
        if (lifeCostCompare1==lifeCostCompare2){
            document.calculator.lifecostdiff.value="Fuel costs are the same over"+years+" years."
          } else {
            var savings = Math.abs(lifeCostCompare1-lifeCostCompare2)
            if (lifeCostCompare1 < lifeCostCompare2){
                document.calculator.lifecostdiff.value="Car 1 saves you $"+savings+" over "+years+" years."
              } else {
                document.calculator.lifecostdiff.value="Car 2 saves you $"+savings+" over "+years+" years."
            }
        }
      } else {
        lifetimeDiffRow.style.display="none"
    }
}

function checkForNulls(checkType){
    if (document.calculator.price1.value==""){
        window.alert("Fuel price must be entered to calculate fuel costs.")
    }
    if (document.calculator.annmiles1.value==""){
        window.alert("Miles driven each year must be entered to calculate fuel costs.")
    }
    if (document.calculator.years1.value==""){
        window.alert("Time period must be entered to calculate fuel costs.")
    }
    if (checkType=="combined"){
        if (document.calculator.MPG1.value==""){
            window.alert("MPG must be entered to calculate fuel costs.")
        }
    }
    if (checkType=="detailed"){
        if (document.calculator.mpgcity1.value=="" && document.calculator.mpghwy1.value==""){
            window.alert("City & highway MPG must be entered to calculate fuel costs.")
        } else {
            if (document.calculator.mpgcity1.value==""){
                window.alert("City MPG must be entered to calculate fuel costs.")
            }
            if (document.calculator.mpghwy1.value==""){
                window.alert("Highway MPG must be entered to calculate fuel costs.")
            }
        }
    }
}
function calculate() {
    var car1CombinedNulls=false
    var car2CombinedNulls=false
	if (document.calculator.MPG1.value!="" && document.calculator.price1.value!="" && document.calculator.annmiles1.value!="" && document.calculator.years1.value!=""){
        var miles1 =parseInt(document.calculator.annmiles1.value)
	  var MPG1 =parseFloat(document.calculator.MPG1.value)
	  var price1 =parseFloat(document.calculator.price1.value)
        var anncost1 = (price1*(miles1/MPG1))
        document.calculator.anncost1.value=("$ "+round(anncost1,0))
        var lifecost1 = document.calculator.years1.value*anncost1
        document.calculator.lifecost1.value=("$ "+round(lifecost1,0))
	} else {
        car1CombinedNulls=true
    }
	if (document.calculator.MPG2.value!="" && document.calculator.price2.value!="" && document.calculator.annmiles1.value!="" && document.calculator.years1.value!=""){
        var miles2 =parseInt(document.calculator.annmiles1.value)
	  var MPG2 =parseFloat(document.calculator.MPG2.value)
	  var price2 =parseFloat(document.calculator.price2.value)
        var anncost2 = (price2*(miles2/MPG2))
        document.calculator.anncost2.value=("$ "+round(anncost2,0))
        var lifecost2 = document.calculator.years1.value*anncost2
        document.calculator.lifecost2.value=("$ "+round(lifecost2,0))
	} else {
        car2CombinedNulls=true
    }
    if (car1CombinedNulls && car2CombinedNulls){
        checkForNulls("combined")
    }
}
function calculatedetail(){
    var car1DetailedNulls=false
    var car2DetailedNulls=false
	if ((document.calculator.mpgcity1.value!="" || document.calculator.pcity1.value=="0") && (document.calculator.mpghwy1.value!="" || document.calculator.phwy1.value=="0") && document.calculator.price1.value!="" && document.calculator.annmiles1.value!="" && document.calculator.years1.value!=""){
	    var annmiles1 = parseInt(document.calculator.annmiles1.value)
	    var pcity1 = parseFloat(document.calculator.pcity1.value)
	    var phwy1 = parseFloat(document.calculator.phwy1.value)
	    var mpgcity1 = parseFloat(document.calculator.mpgcity1.value)
	    var mpghwy1 = parseFloat(document.calculator.mpghwy1.value)
	    var price1 = parseFloat(document.calculator.price1.value)
        if (pcity1!="0" && phwy1!="0"){ 
	        var anncost1 = (((annmiles1 / mpgcity1) * price1) * (pcity1 / 100))+ (((annmiles1 / mpghwy1) * price1) * (phwy1 / 100))
            } else {
            if (pcity1=="0"){
                var anncost1 = (annmiles1/mpghwy1) * price1
                } else {
                var anncost1 = (annmiles1/mpgcity1) * price1
            }
        }
	    document.calculator.anncost1.value=("$ " + round(anncost1,0))
	    var lifecost1 = anncost1 * document.calculator.years1.value
	    document.calculator.lifecost1.value=("$ " + round(lifecost1,0))	
	} else {
        car1DetailedNulls=true
    }
	if ((document.calculator.mpgcity2.value!="" || document.calculator.pcity1.value=="0") && (document.calculator.mpghwy2.value!="" || document.calculator.phwy1.value=="0") && document.calculator.price2.value!="" && document.calculator.annmiles1.value!="" && document.calculator.years1.value!=""){
	    var annmiles1 = parseInt(document.calculator.annmiles1.value)
	    var pcity1 = parseFloat(document.calculator.pcity1.value)
	    var phwy1 = parseFloat(document.calculator.phwy1.value)
	    var mpgcity2 = parseFloat(document.calculator.mpgcity2.value)
	    var mpghwy2 = parseFloat(document.calculator.mpghwy2.value)
	    var price2 = parseFloat(document.calculator.price2.value)
          if (pcity1!="0" && phwy1!="0"){ 
	        var anncost2 = (((annmiles1 / mpgcity2) * price2) * (pcity1 / 100))+ (((annmiles1 / mpghwy2) * price2) * (phwy1 / 100))
              } else {
              if (pcity1=="0"){
                  var anncost2 = (annmiles1/mpghwy2) * price2
                  } else {
                  var anncost2 = (annmiles1/mpgcity2) * price2
              }
          }
	    document.calculator.anncost2.value=("$ " + round(anncost2,0))
	    var lifecost2 = anncost2 * document.calculator.years1.value
	    document.calculator.lifecost2.value=("$ " + round(lifecost2,0))
	    } else {
        car2DetailedNulls=true
    }
    if (car1DetailedNulls && car2DetailedNulls){
        checkForNulls("detailed")
    }
}
function adjustpercentcity(){
	var phwy = parseFloat(document.detail.phwy.value)
	if (phwy>0){
	var pcity = 100 - phwy
	} else {
	var pcity = 100
	} 
	document.detail.pcity.value=("" + pcity)
}
function adjustpercenthwy(){
	var pcity = parseFloat(document.detail.pcity.value)
	if (pcity>0){
	var phwy = 100 - pcity
	} else {
	var phwy = 100
	}
	document.detail.phwy.value=("" + phwy)
}

function cityHwySplit(pct){
	if (pct == "pcity1"){
	    document.calculator.phwy1.value = 100 - parseFloat(document.calculator.pcity1.value)
	    } else {
        if (pct == "phwy1"){
		    document.calculator.pcity1.value = 100 - parseFloat(document.calculator.phwy1.value)
		    } else {
			if (pct == "pcity1"){
			    document.calculator.phwy1.value = 100 - parseFloat(document.calculator.pcity1.value)
				} else {
				if (pct == "phwy1"){
					document.calculator.pcity1.value = 100 - parseFloat(document.calculator.phwy1.value)
				}
			}
		}
	}
    clearTotals()
}
function clearTotals(){
    document.calculator.anncost1.value=""
    document.calculator.anncost2.value=""
    document.calculator.lifecost1.value=""
    document.calculator.lifecost2.value=""
    document.calculator.anncostdiff.value=""
    document.calculator.lifecostdiff.value=""
}
