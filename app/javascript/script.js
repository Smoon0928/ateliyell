

// Swiperのオプションを定数化
const opt = {
  loop: true, 
  speed: 3000,
  autoplay:{
    delay: 3000,
  },
  pagination: { 
    el: '.swiper-pagination', 
  },
  navigation: { 
    nextEl: '.swiper-button-next',
    prevEl: '.swiper-button-prev',
  }
}

// Swiperを実行(初期化)
$(document).on('turbolinks:load', function() {
    let swiper = new Swiper('.swiper',opt);
});