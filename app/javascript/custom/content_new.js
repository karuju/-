document.getElementsByName('content-type').forEach((elem) => {
  elem.addEventListener('change', (event) => {
    console.log(event.target.value); // This will log 'comic', 'novel', or 'movie'
  });
});

function showForm() {
  var comicForm = document.getElementById('comic-form');
  var novelForm = document.getElementById('novel-form');
  var movieForm = document.getElementById('movie-form');

  comicForm.style.display = document.getElementById('comic-radio').checked ? 'block' : 'none';
  novelForm.style.display = document.getElementById('novel-radio').checked ? 'block' : 'none';
  movieForm.style.display = document.getElementById('movie-radio').checked ? 'block' : 'none';
}

// ラジオボタンのリストを取得
var radios = document.getElementsByName('content-type');

// 各ラジオボタンに対してイベントリスナーを設定
for (var i = 0; i < radios.length; i++) {
  radios[i].addEventListener('change', showForm);
}