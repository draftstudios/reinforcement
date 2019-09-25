
$(document).ready(function () {
    //global variable
    const num = 5;
    let adHeight = 400;
    const adContainer = document.querySelector('.ad-container');

    //TEST
    for (let index = 1; index <= num; index++) {
        adContainer.innerHTML += `<div class="ad ad${index}"></div>`;
    }
    setInterval(()=>{
        console.log("AD1: "+$('.ad1').visible());
        console.log("AD2: "+$('.ad2').visible());
        console.log("AD3: "+$('.ad3').visible());
        console.log("AD4: "+$('.ad4').visible());
        console.log("***************************")
    }, 2000);

    
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
