window.addEventListener("trix-file-accept", function(event) {
  const acceptedTypes = ['image/jpeg', 'image/png']
  if (!acceptedTypes.includes(event.file.type)) {
    event.preventDefault()
    alert("只能附加JPEG或PNG圖片！")
  }
  const maxFileSize = 2048 * 1024 //2MB
  if (event.file.size > maxFileSize) {
    event.preventDefault()
    alert("單張圖片最大檔案大小為2MB!")
  }
})