var fs = require('fs');
var d3 = require('d3');

// ============================================================
// COMPARISON TRIALS
// ============================================================

var a=0;
var generators = {
  UNI: Math.random,
  NORM: d3.random.normal(2,0.45),
  LOG: d3.random.logNormal(0,1.2)
};

// Data size
[75, 150, 300].forEach(function(dataSize){
  var layouts = (dataSize==75)?[3, 6, 12]:[3]; // 3 options only when data size is 75
  // For each layout option
  layouts.forEach(function(layout){
    ["UNI","LOG","NORM"].forEach(function(distr){
      ["UNI","LOG","NORM"].forEach(function(question){
        [1,2,3,4,5,6,7,8,9,10].forEach(function(rep){
          var experiment = {
            data: [],
            dataSize: dataSize,
            layout: layout,
            distr: distr,
            question: question,
            rep: rep
          };
          // Generate pseudo-random data
          for(var i=0; i<dataSize; i++){
            var v=generators[distr]();
            experiment.data.push({ Value: Math.abs(v) });
          }
            // Export experiment data
          fs.writeFile("trial_datasets/VIEW_"+dataSize+"DS_"+layout+"L_"+distr+"_"+question+"_"+rep+".json", JSON.stringify(experiment));
        });
      });
    });
  });
});

/*
["UNI","LOG","NORM"].forEach(function(distr){
  var dataSize = 75;
  a=0;
  var experiment = {
    data: [],
    dataSize: dataSize,
    layout: 3,
    distr: distr,
    rep: 1,
    training: true
  };
  // Generate pseudo-random data
  for(var i=0; i<dataSize; i++){
    var v=generators[distr]();
    if(distr==="NORM"){
      if(v>2) v+=(v-2);
      else    v-=(2-v)/2;
    }
    experiment.data.push({ Value: Math.abs(v) });
  }
    // Export experiment data
  fs.writeFile("trial_datasets/VIEW_TRAIN_"+distr+".json", JSON.stringify(experiment));
});
*/
