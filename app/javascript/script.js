document.addEventListener("DOMContentLoaded", function() {
    let sentimentElements = document.querySelectorAll(".sentiment-score");

    sentimentElements.forEach(function(element) {
        let scoreText = element.textContent;
        let score = parseFloat(scoreText.replace('[', '').replace(']', ''));

        if (score >= 0) {
            element.classList.add("positive");
        } else {
            element.classList.add("negative");
        }
    });
});

document.addEventListener("turbolinks:load", function() {
    let sentimentElements = document.querySelectorAll(".sentiment-score");

    sentimentElements.forEach(function(element) {
        let scoreText = element.textContent;
        let score = parseFloat(scoreText.replace('[', '').replace(']', ''));

        if (score >= 0) {
            element.classList.add("positive");
        } else {
            element.classList.add("negative");
        }
    });
});

document.addEventListener('DOMContentLoaded', function() {
  const firstMaterialField = document.getElementById('first-material-field');
  if (firstMaterialField) {
    const deleteButton = firstMaterialField.querySelector('.btn_delete');
    if (deleteButton) {
      deleteButton.disabled = true;
      deleteButton.classList.add('disabled');
    }
  }
});
