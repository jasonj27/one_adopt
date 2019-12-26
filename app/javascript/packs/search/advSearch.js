$(document).ready(() => {
  $('#advSearchButton').on('click', () => {
    console.log('123123');
    $('.advSearchCondition').show();
    $('#advSearchButton').hide();
    $('.formSearch').prop('action', '/searches/advance');
  })
})