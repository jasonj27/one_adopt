window.addEventListener("trix-file-accept", function(event) {
  const acceptedTypes = ['image/jpeg', 'image/png', 'application/pdf']
  if (!acceptedTypes.includes(event.file.type)) {
    event.preventDefault()
    alert("只能附加PDF文件或JPEG和PNG圖片！")
  }
  const maxFileSize = 2 * 1024 * 1024 //2MB
  if (event.file.size > maxFileSize) {
    event.preventDefault()
    alert("單一檔案最大檔案大小為2MB!")
  }
})