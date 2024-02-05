setInterval(function(){
  $.getJSON('/top/random_board', function(data) {
    // dataにはランダムに選ばれた掲示板の詳細が含まれています。
    // 必要に応じてページの要素を更新します。
    $('#board_title').text(data.title);
    $('#board_content').text(data.content);
  });
}, 30000);
