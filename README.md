#<!DOCTYPE html>

});
// Google Inc.
<html lang="ar">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>لعبة عبور الشارع</title>
    <style>
        * {
            margin: 0 
          padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
        }

        #gameArea {
            width: 100%;
            height: 400px;
            background-color: #e0e0e0;
            position: relative;
            overflow: hidden;
        }

        #player {
            width: 40px;
            height: 40px;
            background-color: #ff6347; /* لون القط */
            position: absolute;
            bottom: 10px;
            left: 50%;
            transform: translateX(-50%);
        }

        .car {
            width: 60px;
            height: 40px;
            background-color: #000; /* لون السيارات */
            position: absolute;
            bottom: 0;
            animation: moveCar 4s linear infinite;
        }

        #car1 {
            left: 30%;
        }

        #car2 {
            left: 60%;
            animation-duration: 5s;
        }

        #car3 {
            left: 20%;
            animation-duration: 6s;
        }

        @keyframes moveCar {
            0% { bottom: -50px; }
            100% { bottom: 400px; }
        }
    </style>
</head>
<body>
    <div id="gameArea">
        <div id="player"></div>
        <div id="car1" class="car"></div>
        <div id="car2" class="car"></div>
        <div id="car3" class="car"></div>
    </div>

    <script>
        let player = document.getElementById('player');
        let gameArea = document.getElementById('gameArea');
        let cars = document.querySelectorAll('.car');

        let playerPos = { x: 50, y: 10 }; // موقع اللاعب
        let playerSpeed = 10; // سرعة الحركة

        // تحريك اللاعب
        document.addEventListener('keydown', (e) => {
            if (e.key === 'ArrowLeft' && playerPos.x > 0) {
                playerPos.x -= playerSpeed;
            } else if (e.key === 'ArrowRight' && playerPos.x < 90) {
                playerPos.x += playerSpeed;
            }
            player.style.left = playerPos.x + '%';
        });

        // التحقق من التصادم مع السيارات
        function checkCollision() {
            cars.forEach(car => {
                let carPos = car.getBoundingClientRect();
                let playerPosRect = player.getBoundingClientRect();

                if (
                    playerPosRect.right > carPos.left &&
                    playerPosRect.left < carPos.right &&
                    playerPosRect.bottom > carPos.top &&
                    playerPosRect.top < carPos.bottom
                ) {
                    alert('لقد اصطدمت بسيارة! اللعبة انتهت.');
                    resetGame();
                }
            });
        }

        // إعادة تعيين اللعبة بعد التصادم
        function resetGame() {
            playerPos = { x: 50, y: 10 };
            player.style.left = playerPos.x + '%';
        }

        // تحديث اللعبة بشكل مستمر
        function gameLoop() {
            checkCollision();
            requestAnimationFrame(gameLoop);
        }

        gameLoop();
    </script>
</body>
</html>

<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>موقعي للألعاب</title>  
    <style>
        body { font-family: 'Tajawal', sans-serif; text-align: center; margin: 0; padding: 0; background: #f4f4f4; color: #333; }
        header { background: #222; color: white; padding: 20px; font-size: 24px; }
        nav { background: #444; padding: 15px; display: flex; justify-content: center; }
        nav a { color: white; text-decoration: none; margin: 15px; font-size: 18px; transition: 0.3s; }
        nav a:hover { color: #ffcc00; }
        .section { padding: 50px; background: white; margin: 20px; border-radius: 10px; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); }
        footer { background: #222; color: white; padding: 20px; font-size: 14px; margin-top: 20px; }
        .btn { background: #ffcc00; padding: 10px 20px; text-decoration: none; color: #222; border-radius: 5px; transition: 0.3s; }
        .btn:hover { background: #e6b800; }
    </style>
</head>
<body>
    <header>
        <h1>مرحبًا بك في موقع الألعاب</h1>
    </header>
    <nav>
        <a href="#home">الرئيسية</a>
        <a href="#games">الألعاب</a>
        <a href="#about">حول</a>
        <a href="#contact">تواصل</a>
    </nav>
    <div id="home" class="section">
        <h2>مرحبًا بك في موقع الألعاب</h2>
        <p>استمتع بأفضل الألعاب المتاحة لدينا!</p>
        <a href="#games" class="btn">ابدأ اللعب</a>
    </div>
    <div id="games" class="section">
        <h2>الألعاب</h2>
        <div id="gameArea">
            <button id="exitButton" onclick="exitGame()">خروج</button>
            <h2 id="quote"></h2>
            <div id="answerOptions"></div>
            <button class="btn" onclick="checkAnswer()">تحقق</button>
            <p id="message"></p>
            <p id="timer"></p>
            <p id="score">النقاط: 0</p>
        </div>
    </div>
    <div id="about" class="section">
        <h2>حول الموقع</h2>
        <p>نحن نقدم ألعاب ممتعة ومثيرة لجميع الفئات.</p>
    </div>
    <div id="contact" class="section">
        <h2>اتصل بنا</h2>
        <p>للتواصل معنا، يرجى إرسال بريد إلكتروني إلى contact@gamesite.com</p>
    </div>
    <footer>
        &copy; 2025 جميع الحقوق محفوظة لموقع الألعاب.
    </footer>
    <script>
        let quotes = [
            { quote: "أنا لا أبحث عن القوة، القوة هي التي تبحث عني.", options: ["Hunter x Hunter", "Naruto", "One Piece", "Bleach"], answer: "Naruto" },
            { quote: "في النهاية، القوة هي التي تحدد كل شيء.", options: ["Attack on Titan", "Naruto", "Dragon Ball", "One Piece"], answer: "Dragon Ball" },
            { quote: "هل تظن أنني سأتوقف هنا؟", options: ["Dragon Ball", "Naruto", "One Punch Man", "Attack on Titan"], answer: "Dragon Ball" }
        ];
        let currentQuote, timerInterval, timeLeft = 7, score = 0, answered = false, askedQuestions = [];
        function askQuestion() {
            let randomIndex;
            do { randomIndex = Math.floor(Math.random() * quotes.length); } while (askedQuestions.includes(randomIndex));
            askedQuestions.push(randomIndex);
            if (askedQuestions.length === quotes.length) { alert("لقد أتممت جميع الأسئلة!"); return; }
            currentQuote = quotes[randomIndex];
            document.getElementById("quote").textContent = currentQuote.quote;
            document.getElementById("timer").textContent = "الوقت المتبقي: " + timeLeft + " ثوانٍ";
            document.getElementById("score").textContent = "النقاط: " + score;
            displayAnswerOptions();
            answered = false;
            startTimer();
        }
        function startTimer() {
            if (timerInterval) clearInterval(timerInterval);
            timerInterval = setInterval(function() {
                if (answered) return;
                timeLeft--;
                document.getElementById("timer").textContent = "الوقت المتبقي: " + timeLeft + " ثوانٍ";
                if (timeLeft <= 0) {
                    clearInterval(timerInterval);
                    showHint();
                }
            }, 1000);
        }
        function displayAnswerOptions() {
            let optionsHTML = "";
            currentQuote.options.forEach(function(option) {
                optionsHTML += `<button class="answerButton" onclick="selectAnswer('${option}')">${option}</button>`;
            });
            document.getElementById("answerOptions").innerHTML = optionsHTML;
        }
        function selectAnswer(answer) {
            if (answered) return;
            answered = true;
            if (answer === currentQuote.answer) {
                document.getElementById("message").textContent = "🎉 إجابة صحيحة!";
                score++;
            } else {
                document.getElementById("message").textContent = "❌ إجابة خاطئة!";
            }
            document.querySelectorAll(".answerButton").forEach(button => button.disabled = true);
            setTimeout(function() { timeLeft = 7; askQuestion(); }, 2000);
        }
        function showHint() {
            document.getElementById("message").textContent = "⏰ انتهى الوقت! إليك hint: " + currentQuote.answer.slice(0, 2) + "...";
            setTimeout(function() { timeLeft = 7; askQuestion(); }, 2000);
        }
        function exitGame() {
            document.getElementById("gameArea").style.display = "none";
        }
   ![logo_sites_2020q4_color_2x_web_48dp](https://github.com/user-attachments/assets/aa668382-36ab-4fab-a90f-4fea859d7a43)
     askQuestion();
    </script>
</body>
</html>
