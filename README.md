<!DOCTYPE html>
<html lang="ar">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="popads-verification-3549867" value="66912831ec97e5e2739f94afbc43d947" />
    <title>موقع الألعاب</title>
    <style>
        body {
            font-family: 'Tajawal', sans-serif;
            text-align: center;
            margin: 0;
            padding: 0;
            background: #f4f4f4;
            color: #333;
        }
        header {
            background: #222;
            color: white;
            padding: 20px;
            font-size: 24px;
        }
        nav {
            background: #444;
            padding: 15px;
            display: flex;
            justify-content: center;
        }
        nav a {
            color: white;
            text-decoration: none;
            margin: 15px;
            font-size: 18px;
            transition: 0.3s;
        }
        nav a:hover {
            color: #ffcc00;
        }
        .section {
            padding: 50px;
            background: white;
            margin: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        footer {
            background: #222;
            color: white;
            padding: 20px;
            font-size: 14px;
            margin-top: 20px;
        }
        .btn {
            background: #ffcc00;
            padding: 10px 20px;
            text-decoration: none;
            color: #222;
            border-radius: 5px;
            transition: 0.3s;
        }
        .btn:hover {
            background: #e6b800;
        }
        .game-container {
            text-align: center;
            margin-top: 20px;
        }
        .car {
            width: 60px;
            height: 40px;
            background-color: #000;
            position: absolute;
            bottom: 0;
            animation: moveCar 4s linear infinite;
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
            background-color: #ff6347;
            position: absolute;
            bottom: 10px;
            left: 50%;
            transform: translateX(-50%);
        }
        @keyframes moveCar {
            0% { bottom: -50px; }
            100% { bottom: 400px; }
        }
    </style>
</head>
<body>

<header>
    <h1>مرحبًا بك في موقع الألعاب</h1>
</header>

<nav>
    <a href="game1.html">لعبة عبور الشارع</a>
    <a href="game2.html">لعبة الأسئلة</a>
    <a href="#about">حول</a>
    <a href="#contact">تواصل</a>
</nav>

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

<!-- لعبة عبور الشارع -->
<div class="game-container" id="game1">
    <h2>لعبة عبور الشارع</h2>
    <div id="gameArea">
        <div id="player"></div>
        <div id="car1" class="car"></div>
        <div id="car2" class="car"></div>
        <div id="car3" class="car"></div>
    </div>
</div>

<!-- لعبة الأسئلة -->
<div class="game-container" id="game2">
    <h2>لعبة الأسئلة</h2>
    <div class="question" id="question"></div>
    <div id="answerOptions"></div>
    <p id="message"></p>
    <p id="score">النقاط: 0</p>
</div>

<script>
    // لعبة عبور الشارع
    let player = document.getElementById('player');
    let gameArea = document.getElementById('gameArea');
    let cars = document.querySelectorAll('.car');
    let playerPos = { x: 50, y: 10 };
    let playerSpeed = 10;

    document.addEventListener('keydown', (e) => {
        if (e.key === 'ArrowLeft' && playerPos.x > 0) {
            playerPos.x -= playerSpeed;
        } else if (e.key === 'ArrowRight' && playerPos.x < 90) {
            playerPos.x += playerSpeed;
        }
        player.style.left = playerPos.x + '%';
    });

    function checkCollision() {
        cars.forEach(car => {
            let carPos = car.getBoundingClientRect();
            let playerPosRect = player.getBoundingClientRect();
            if (playerPosRect.right > carPos.left &&
                playerPosRect.left < carPos.right &&
                playerPosRect.bottom > carPos.top &&
                playerPosRect.top < carPos.bottom) {
                alert('لقد اصطدمت بسيارة! اللعبة انتهت.');
                resetGame();
            }
        });
    }

    function resetGame() {
        playerPos = { x: 50, y: 10 };
        player.style.left = playerPos.x + '%';
    }

    function increaseCarSpeed() {
        let carSpeed = 4;
        carSpeed += 0.5;
        cars.forEach(car => {
            car.style.animationDuration = `${(4 / carSpeed)}s`;
        });
    }

    function gameLoop() {
        checkCollision();
        increaseCarSpeed();
        requestAnimationFrame(gameLoop);
    }

    gameLoop();

    // لعبة الأسئلة
    let questions = [
        { question: "من هو بطل مسلسل ناروتو؟", options: ["ناروتو", "ساسكي", "كاكاشي", "ساكورا"], answer: "ناروتو" },
        // أضف المزيد من الأسئلة هنا...
    ];

    let score = 0;

    function displayQuestion() {
        let randomIndex = Math.floor(Math.random() * questions.length);
        let question = questions[randomIndex];
        document.getElementById("question").innerText = question.question;
        let optionsHTML = "";
        question.options.forEach(option => {
            optionsHTML += `<button class="answerButton" onclick="checkAnswer('${option}', '${question.answer}')">${option}</button>`;
        });
        document.getElementById("answerOptions").innerHTML = optionsHTML;
    }

    function checkAnswer(selectedAnswer, correctAnswer) {
        if (selectedAnswer === correctAnswer) {
            score++;
            document.getElementById("message").innerText = "إجابة صحيحة!";
        } else {
            document.getElementById("message").innerText = "إجابة خاطئة!";
        }
        document.getElementById("score").innerText = "النقاط: " + score;
        setTimeout(displayQuestion, 2000);
    }

    displayQuestion();
</script>
</body>
</html>

