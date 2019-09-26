$(document).ready(function() {
  //global variable
  // const num = 5;
  // let adHeight = 400;
  // const adContainer = document.querySelector('.ad-container');
  let rewardPoints = {
    A1: { f: 1, m: -1 },
    A2: { f: 1, m: 0 },
    A3: { f: -1, m: -1 },
    A4: { f: 1, m: 2 },
    A5: { f: 1, m: 4 },
    A6: { f: 2, m: 1 },
    A7: { f: 1, m: 4 },
    A8: { f: 2, m: 4 },
    A9: { f: -2, m: -5 },
    B1: { f: -3, m: -4 },
    B2: { f: -1, m: -2 },
    B3: { f: 5, m: -1 },
    B4: { f: 3, m: 2 },
    C1: { f: 3, m: 2 },
    C2: { f: 3, m: 1 },
    C3: { f: 2, m: 1 },
    C4: { f: 3, m: 1 },
    D1: { f: 1, m: 4 },
    D2: { f: 0, m: 0 },
    D3: { f: 3, m: 1 },
    D4: { f: 4, m: 5 },
    E1: { f: 3, m: 5 },
    E2: { f: 1, m: 2 },
    F1: { f: 2, m: 6 },
    G1: { f: 2, m: 3 },
    H1: { f: 2, m: 3 }
  };

  // console.log(rewardPoints.G1.m);

  // //TEST
  // for (let index = 1; index <= num; index++) {
  //     adContainer.innerHTML += `<div class="ad ad${index}"></div>`;
  // }
  // setInterval(()=>{
  //     console.log("AD1: "+$('.ad1').visible());
  //     console.log("AD2: "+$('.ad2').visible());
  //     console.log("AD3: "+$('.ad3').visible());
  //     console.log("AD4: "+$('.ad4').visible());
  //     console.log("***************************")
  // }, 2000);

  let arr = [
    "A1",
    "A2",
    "A3",
    "A4",
    "A5",
    "A6",
    "A7",
    "A8",
    "A9",
    "B1",
    "B2",
    "B3",
    "B4",
    "C1",
    "C2",
    "C3",
    "C4",
    "D1",
    "D2",
    "D3",
    "D4",
    "E1",
    "E2",
    "F1",
    "G1",
    "H1"
  ];
  let copyArr = ["B1", "A5"];
  let gender = 2;
  // console.log(rewardPoints);

  // for(let i = 0; i < arr.length;i++){
  //     if($('.'+arr[i]).visible()){
  //         copyArr.push(arr[i]);
  //     }
  // }

  // function addRewardPoint(copy){
  //    for (let i = 0; i < copy.length; i++) {
  //        if(copy[i]){
  //            console.log(copy.length);
  //         //    if(copy[i]==rewardPoints.copy[i]){
  //         //        return rewardPoints.copy[i].m;
  //         //    }
  //        }
  //        break;
  //    }
  // }
  femalePoints =[];
  malePoints =[];

  setInterval(() => {
    // let tempArr=[];
    // for (let i = 0; i < copyArr.length; i++) {
    //     if(copyArr[i]){
    //     }

    // }
    // for (let i = 0; i < copyArr.length; i++) {
    //     let copy = copyArr[i].toString();
    // for (var key in rewardPoints) {
    //     if (rewardPoints.hasOwnProperty(key)) {
    //         for (let i = 0; i < copyArr.length; i++) {
    //             if(copyArr[i]===key){
    //                 for(let keyy in rewardPoints[copyArr[i]]){
    //                     if(rewardPoints[copyArr[i]].hasOwnProperty(keyy)){
    //                         console.log(key +' --> ' +keyy + ' = '+rewardPoints[copyArr[i]][keyy]);
    //                         if(gender==2){
    //                             console.log('Reward: '+rewardPoints[copyArr[i]]['f']);
    //                         }
    //                     }
    //                 }
    //             }
    //         }
    //         }
    //     }
    // let copyArr = [];
    // for (let i = 0; i < arr.length; i++) {
    //   if ($("." + arr[i]).visible()) {
    //     copyArr.push(arr[i]);
    //   }
    // }
    // console.log(copyArr);
    /*
    // for (var key in rewardPoints) {
    //   if (rewardPoints.hasOwnProperty(key)) {
    //     for (let i = 0; i < copyArr.length; i++) {
    //       if (copyArr[i] === key) {
    //         for (let keyy in rewardPoints[copyArr[i]]) {
    //           if (rewardPoints[copyArr[i]].hasOwnProperty(keyy)) {
    //             // forcereward(rewardPoints[copyArr[i]][keyy]);
    //             // console.log(
    //             //   key + " --> " + keyy + "= " + rewardPoints[copyArr[i]][keyy]
    //             // );
    //             if(gender ==2){
    //               keyy = 'f';

    //               console.log('Female Point: '+ rewardPoints[copyArr[i]][keyy]);
    //               femalePoints.push(rewardPoints[copyArr[i]][keyy]);
    //             }else{
    //               keyy = 'm';
    //               console.log('Male Point: '+ rewardPoints[copyArr[i]][keyy]);
    //               malePoints.push(rewardPoints[copyArr[i]][keyy]);
    //             }
    //           }
    //         }
    //       }
    //     }
    //   }
    // }
    */
   for (var key in rewardPoints) {if (rewardPoints.hasOwnProperty(key)) {for (let i = 0; i < copyArr.length; i++) {if (copyArr[i] === key) {for (let keyy in rewardPoints[copyArr[i]]) {if (rewardPoints[copyArr[i]].hasOwnProperty(keyy)) {if(gender ==2){keyy = 'f';console.log('Female Point: '+ rewardPoints[copyArr[i]][keyy]);femalePoints.push(rewardPoints[copyArr[i]][keyy]);}else{keyy = 'm';console.log('Male Point: '+ rewardPoints[copyArr[i]][keyy]);malePoints.push(rewardPoints[copyArr[i]][keyy]);}}}}}}}

    // for (var key in rewardPoints) {if (rewardPoints.hasOwnProperty(key)) {for (let i = 0; i < copyArr.length; i++) {if (copyArr[i] === key) {for (let keyy in rewardPoints[copyArr[i]]) {if (rewardPoints[copyArr[i]].hasOwnProperty(keyy)) {  console.log(key + " --> " + keyy + "= " + rewardPoints[copyArr[i]][keyy]);}}}}}}
//forcereward(rewardPoints[copyArr[i]][keyy]);
    // }
    // console.log(tempArr)

    // console.log(copyArr);
    // console.log('******************');
  }, 2000);

  // another function
  setInterval(()=>{
    let totalFemalePoints;
    let totalMalePoints;
    //add points
  if(femalePoints !=[] || femalePoints ==0 || femalePoints ==undefined){
    totalFemalePoints = femalePoints.reduce((a,b)=>a+b, 0);
    // forcereward(totalFemalePoints);
  }
  else if(malePoints !=[] || malePoints ==0 || malePoints == undefined){
    totalMalePoints = malePoints.reduce((a,b)=> a+b, 0);
    // forcereward(totalMalePoints);
  }
    console.log('Female Points:'+totalFemalePoints);
    console.log('Maile Points: '+ totalMalePoints);
    femalePoints =[];
    malePoints =[];

  },5000);

  // setInterval(()=>{let totalFemalePoints;let totalMalePoints;if(femalePoints !=[] || femalePoints ==0 || femalePoints ==undefined){totalFemalePoints = femalePoints.reduce((a,b)=>a+b, 0);forcereward(totalFemalePoints);}if(malePoints !=[] || malePoints ==0 || malePoints == undefined){totalMalePoints = malePoints.reduce((a,b)=> a+b, 0);forcereward(totalMalePoints);}console.log('Female Points:'+totalFemalePoints);console.log('Maile Points: '+ totalMalePoints);femalePoints =[];malePoints =[];},5000);



  //END TEST

  // setInterval(()=>{
  //     //viewport Height
  //     let inHeight = window.innerHeight;
  //     console.log('Inner Height: '+inHeight);

  //     //scrollheight of container
  //     // let scrollHeight = document.querySelector('.ad-container').scrollHeight;

  //     // //clienHeight
  //     // console.log('client height: ' + document.querySelector('.ad-container').clientHeight);

  //     // //scrollHeight of each ad box
  //     // console.log('Scroll Height of Each box: '+ document.querySelector('.ad').scrollHeight);

  //     // //get scroll top
  //     // let p = $( ".ad-container" ).scrollTop();
  //     // console.log('Scroll Top position: '+p);

  //     //window scrollTop
  //     let scrollTopHeight = $(window).scrollTop();
  //     console.log('ScrollTopPositionHeight: '+ scrollTopHeight);
  //     let totalHeight = scrollTopHeight + inHeight;
  //     console.log('Total Height: '+totalHeight);

  //         if(scrollTopHeight === 0 && totalHeight <= 400){
  //             console.log("DEFINITELY RETURN 'AD1'");
  //         }
  //         if(scrollTopHeight === 0 && totalHeight >400 && totalHeight <= 800){
  //             console.log("RETURN 'AD1 and AD2'");
  //         }
  //         if(scrollTopHeight === 0 && totalHeight>800 && totalHeight <= 1200){
  //             console.log("RETURN 'AD1, AD2 and AD3'");
  //         }
  //         if(scrollTopHeight === 0 && totalHeight > 1200){
  //             console.log("RETURN AD1 Ad2 Ad3 Ad4")
  //         }
  //         if(scrollTopHeight >0 && totalHeight <= 400){
  //             console.log("RETURN 'AD1'");
  //         }
  //         if(scrollTopHeight > 0 && scrollTopHeight <= 400&&totalHeight > 400 && totalHeight<=800){
  //             console.log("RETURN 'AD1'andd AD2")
  //         }
  //         if(scrollTopHeight > 0 && scrollTopHeight <= 400&&totalHeight > 400 && totalHeight<=800){
  //             console.log("RETURN 'AD1'andd AD2")
  //         }
  //         if(scrollTopHeight > 400 && totalHeight > 800 && totalHeight <=1200){
  //             console.log("RETURN 'AD2 AD3");
  //         }

  // inHeight = 0;
  // scrollTopHeight = 0;
  // totalHeight = 0;

  //TODO
  //Each DIV is 400 so, 800 means looking at 1 and second ad, 1200 means looking at 3rd one, 1600 means looking at 4th one.

  // let scrollTopPosition = $(window).scrollTop();
  // if(scrollTopPosition > 0 && scrollTopPosition <280){
  //     console.log('Scrolled ONEEE HEIGHT: '+ scrollTopPosition + scrollHeight);
  // }
  // if(scrollTopPosition >= 280){
  //     console.log('Scrolled TWO HEIGHT');
  // }

  // }, 5000);
});
