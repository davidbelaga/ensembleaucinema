
$(document).ready(function() {
  $(window).scroll(function () {
      if ($(window).scrollTop() >= 50){
      $('.navbar-custom').addClass('bg-dark');

      }
      else {
      $('.navbar-custom').removeClass('bg-dark');
    }
  });
});
