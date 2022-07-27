$(function(){
    $(".btn1").click(function() {
      $(".ele").css("display", "none");
    });
    $(".btn2").click(function() {
      $(".ele").css("display", "block");
    });
  });
  // テスト

  document.addEventListener('turbolinks:load', () => {
    alert("test")
  })
  function tester(){alert("BEEEEEEEEEEEEEP")}