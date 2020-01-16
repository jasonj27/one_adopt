document.addEventListener("DOMContentLoaded", function(evt) {
    document.querySelectorAll('.share-button').forEach(item => {
      item.addEventListener('click', event => {
        let shareAnimalID = item.dataset.share
          
        const shareBtn = document.querySelector('.share-button');
        const shareResult = document.querySelector('.share-result');
        const shareClose = document.querySelector(".share-close");
        const shareData = {
          url: `https://oneadopt.today/searches/${shareAnimalID}`,
          title: '趕快來看看吧!',
          text: '毛孩需要讓更多人看見',
        };
          
        if (navigator.share) {
          handleNavigatorShare();
        } else {
          handleNotSupportNavigatorShare();
        }
      
        function handleNavigatorShare() {
          try {
            navigator.share(shareData);
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
            alert(`連結複製${msg}`);
          } catch (err) {
            alert('發生錯誤，無法複製連結');
          }
      
          contentToCopy.setAttribute('type', 'hidden');
          window.getSelection().removeAllRanges();
        }
    })
  })
})