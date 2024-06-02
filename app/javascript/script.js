document.addEventListener("DOMContentLoaded", function() {
    // すべての.sentiment-score要素を取得
    let sentimentElements = document.querySelectorAll(".sentiment-score");

    sentimentElements.forEach(function(element) {
        // スコアを取得して、数字として解析する
        let scoreText = element.textContent;
        let score = parseFloat(scoreText.replace('[', '').replace(']', ''));

        // スコアに基づいてクラスを追加
        if (score >= 0) {
            element.classList.add("positive");
        } else {
            element.classList.add("negative");
        }
    });
});