function bSched = schedulability_test(param)
    
    rta = analysis.RTA;
    bSched = rta.schedulabilityTest(param);

end