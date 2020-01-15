document.addEventListener("DOMContentLoaded", function() {
  $('document').ready(function(){
    let animalID = document.querySelector('.hidden-id').textContent

    $.get(`http://127.0.0.1:3000/searches/${animalID}.json`, function(data){  
      let dataAnimalID = data.id
      const shareBtn = document.querySelector('.share-button');
      const shareResult = document.querySelector('.share-result');
      const shareClose = document.querySelector(".share-close");
      const shareData = {
        url: `http://127.0.0.1:3000/searches/${dataAnimalID}`,
        title: '趕快來看看吧!',
        text: '毛孩需要讓更多人看見',
      };

      shareBtn.addEventListener('click', () => {
        if (navigator.share) {
          handleNavigatorShare();
        } else {
          handleNotSupportNavigatorShare();
        }
      });
    
      async function handleNavigatorShare() {
        try {
          await navigator.share(shareData);
          shareResult.classList.add("alert", "alert-warning", "alert-dismissible", "fade", "show");
          shareResult.setAttribute("role", "alert");
          shareResult.append('感謝您的分享!');
          shareClose.classList.remove("d-none");
        } catch (err) {
          const { name } = err;
          if (name === 'AbortError') {
            shareResult.classList.add("alert", "alert-warning", "alert-dismissible", "fade", "show");
            shareResult.setAttribute("role", "alert");
            shareResult.append('您已取消分享此訊息!');
            shareClose.classList.remove("d-none");
          } else {
            shareResult.textContent = err;
            alert('發生錯誤', err);
          }
        }
      }
    
      function handleNotSupportNavigatorShare() {
        const contentToCopy = document.querySelector('#content-to-copy');
        contentToCopy.value = shareData.url;
        contentToCopy.setAttribute('type', 'text');
        contentToCopy.select();
    
        try {
          const successful = document.execCommand('copy');
          const msg = successful ? '成功' : '失敗';
          alert(`連結複製${msg}，快去分享吧！`);
        } catch (err) {
          alert('發生錯誤，無法複製連結');
        }
    
        contentToCopy.setAttribute('type', 'hidden');
        window.getSelection().removeAllRanges();
      }
    })
  })
})
  

  



// const shareButton = document.querySelector('.share-button');
// const shareDialog = document.querySelector('.share-dialog');
// const closeButton = document.querySelector('.close-button');

// shareButton.addEventListener('click', event => {
//   if (navigator.share) { 
//    navigator.share({
//       title: 'WebShare API Demo',
//       url: 'https://codepen.io/ayoisaiah/pen/YbNazJ'
//     }).then(() => {
//       console.log('Thanks for sharing!');
//     })
//     .catch(console.error);
//     } else {
//         shareDialog.classList.add('is-open');
//     }
// });

// closeButton.addEventListener('click', event => {
//   shareDialog.classList.remove('is-open');
// });














// const shareBtn = document.querySelector('.share-button');
//   const shareResult = document.querySelector('.share-result');

//   const shareData = {
//     url: 'https://google.com',
//     title: '標題標題標題', 
//     text: '內容內容內容',
//   };

// // STEP 3：當使用者點擊按鈕時

//   shareBtn.addEventListener("click", function(){
//     if(navigator.share){
//       navigator.share({
//         title: "123123",
//         url: 'https://codepen.io/ayoisaiah/pen/YbNazJ',
//       }).then(() => {
//         console.log('Thanks for sharing!');
//       })
//       .catch(console.error);
//     } else {
//       // fallback
//       console.log("123123123123");
      
//     }
//   })  