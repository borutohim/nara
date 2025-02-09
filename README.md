# <!DOCTYPE html>
<html lang="ar">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>اعرف الأنمي</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background: url('your-image-url-here.jpg') no-repeat center center fixed;
            background-size: cover;
            color: white;
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }
        .container {
            background: rgba(0, 0, 0, 0.7);
            padding: 20px;
            border-radius: 10px;
            display: inline-block;
            margin-top: 50px;
        }
        .btn {
            padding: 10px 20px;
            margin: 10px;
            background: #ff4757;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn:hover { background: #e84118; }
        input {
            padding: 8px;
            margin-top: 10px;
        }
        #gameArea { display: none; }
        audio {
            display: none;
        }
        #timer {
            font-size: 20px;
            margin-top: 10px;
            color: #ff4757;
        }
        #answerOptions {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 10px;
        }
        .answerButton {
            width: 45%;
            margin: 10px 0;
            font-size: 18px;
            padding: 10px;
            background-color: #ff6348;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .answerButton:hover {
            background-color: #e74c3c;
        }
        #exitButton {
            position: absolute;
            top: 20px;
            left: 20px;
            padding: 10px;
            background-color: #ff4757;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        #exitButton:hover {
            background-color: #e74c3c;
        }
        #chatContainer {
            position: fixed;
            right: 20px;
            bottom: 20px;
            width: 300px;
            background-color: rgba(0, 0, 0, 0.7);
            padding: 10px;
            border-radius: 10px;
            max-height: 400px;
            overflow-y: auto;
        }
        #chatMessages {
            max-height: 350px;
            overflow-y: auto;
            margin-bottom: 10px;
        }
        #chatInput {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: none;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <audio autoplay loop>
        <source src="https://www.mp3anime.net/songs/fetcher.php?song=443&v=1" type="audio/mp3">
        متصفحك لا يدعم تشغيل الصوت.
    </audio>
    <div class="container">
        <h1>لعبة اعرف الأنمي</h1>
        <button class="btn" onclick="startSinglePlayer()">لعب فردي</button>
        <button class="btn" onclick="joinOnlineGame()">لعب أونلاين</button>
        <button class="btn" onclick="createGame()">إنشاء غرفة</button>

        <div id="joinArea" style="display:none;">
            <input type="text" id="roomCode" placeholder="أدخل كود الغرفة">
            <button class="btn" onclick="joinGame()">انضم للغرفة</button>
        </div>

        <div id="createRoomArea" style="display:none;">
            <p>تم إنشاء غرفة! الكود هو: <span id="roomCodeDisplay"></span></p>
            <button class="btn" onclick="startGameOnline()">ابدأ اللعبة</button>
        </div>

        <div id="gameArea" style="display:none;">
            <button id="exitButton" onclick="exitGame()">خروج</button>
            <h2 id="quote"></h2>
            <div id="answerOptions"></div>
            <button class="btn" onclick="checkAnswer()">تحقق</button>
            <p id="message"></p>
            <p id="timer"></p>
            <p id="score">النقاط: 0</p>
        </div>
    </div>

    <!-- شات -->
    <div id="chatContainer">
        <div id="chatMessages"></div>
        <input type="text" id="chatInput" placeholder="اكتب رسالتك هنا..." onkeydown="sendMessage(event)">
    </div>

    <script>
        let quotes = [
            { quote: "أنا لا أبحث عن القوة، القوة هي التي تبحث عني.", options: ["Hunter x Hunter", "Naruto", "One Piece", "Bleach"], answer: "Naruto" },
            { quote: "في النهاية، القوة هي التي تحدد كل شيء.", options: ["Attack on Titan", "Naruto", "Dragon Ball", "One Piece"], answer: "Dragon Ball" },
            { quote: "هل تظن أنني سأتوقف هنا؟", options: ["Dragon Ball", "Naruto", "One Punch Man", "Attack on Titan"], answer: "Dragon Ball" },
            // ... (أضف المزيد من الأسئلة هنا)
        ];

        let currentQuote;
        let timerInterval;
        let timeLeft = 7;
        let score = 0;
        let answered = false;
        let askedQuestions = [];

        function startSinglePlayer() {
            hideMainMenu();
            document.getElementById("gameArea").style.display = "block";
            askQuestion();
        }

        function askQuestion() {
            let randomIndex;
            do {
                randomIndex = Math.floor(Math.random() * quotes.length);
            } while (askedQuestions.includes(randomIndex)); 

            askedQuestions.push(randomIndex);

            if (askedQuestions.length === quotes.length) {
                alert("لقد أتممت جميع الأسئلة!");
                return;
            }

            currentQuote = quotes[randomIndex];
            document.getElementById("quote").textContent = currentQuote.quote;
            document.getElementById("timer").textContent = "الوقت المتبقي: " + timeLeft + " ثوانٍ";
            document.getElementById("score").textContent = "النقاط: " + score;
            displayAnswerOptions();
            answered = false;
            startTimer();
        }

        function startTimer() {
            if (timerInterval) {
                clearInterval(timerInterval);
            }
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

            setTimeout(function() {
                timeLeft = 7;
                askQuestion();
            }, 2000);
        }

        function showHint() {
            document.getElementById("message").textContent = "⏰ انتهى الوقت! إليك hint: " + currentQuote.answer.slice(0, 2) + "...";
            setTimeout(function() {
                timeLeft = 7;
                askQuestion();
            }, 2000);
        }

        function hideMainMenu() {
            document.querySelector("h1").style.display = "none";
            document.querySelectorAll("button").forEach(button => button.style.display = "none");
        }

        function exitGame() {
            document.getElementById("gameArea").style.display = "none";
            document.querySelector("h1").style.display = "block";
            document.querySelectorAll("button").forEach(button => button.style.display = "inline-block");
        }

        function joinOnlineGame() {
            document.getElementById("joinArea").style.display = "block";
        }

        function joinGame() {
            let roomCode = document.getElementById("roomCode").value;
            socket = new WebSocket("ws://localhost:8081");
            socket.onopen = function () {
                socket.send(JSON.stringify({ action: "join", roomCode: roomCode }));
            };
            socket.onmessage = function (event) {
                let data = JSON.parse(event.data);
                if (data.action === "startGame") {
                    // ابدأ اللعبة على الإنترنت
                }
            };
        }

        function createGame() {
            let roomCode = Math.random().toString(36).substr(2, 6).toUpperCase();
            document.getElementById("roomCodeDisplay").textContent = roomCode;
            document.getElementById("createRoomArea").style.display = "block";
        }

        function startGameOnline() {
            // البدء في اللعبة عبر الإنترنت
        }

        function sendMessage(event) {
            if (event.key === 'Enter') {
                let message = document.getElementById("chatInput").value;
                let chatMessages = document.getElementById("chatMessages");
                chatMessages.innerHTML += `<p>${message}</p>`;
                document.getElementById("chatInput").value = "";
                chatMessages.scrollTop = chatMessages.scrollHeight;
            }
        }
    </script>
</body>
</html>

