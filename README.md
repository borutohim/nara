<!DOCTYPE html>
<html lang="ar">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="popads-verification-3549867" value="66912831ec97e5e2739f94afbc43d947" />
    <title>موقع الألعاب</title>
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
</body>
</html>
<!DOCTYPE html>
<html lang="ar">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>لعبة عبور الشارع</title>
    <style>
        body { font-family: Arial, sans-serif; }
        #gameArea { width: 100%; height: 400px; background-color: #e0e0e0; position: relative; overflow: hidden; }
        #player { width: 40px; height: 40px; background-color: #ff6347; position: absolute; bottom: 10px; left: 50%; transform: translateX(-50%); }
        .car { width: 60px; height: 40px; background-color: #000; position: absolute; bottom: 0; animation: moveCar 4s linear infinite; }
        #car1 { left: 30%; }
        #car2 { left: 60%; animation-duration: 5s; }
        #car3 { left: 20%; animation-duration: 6s; }
        @keyframes moveCar { 0% { bottom: -50px; } 100% { bottom: 400px; } }
    </style>
</head>
<body>
    <h1>لعبة عبور الشارع</h1>
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

        let playerPos = { x: 50, y: 10 };
        let playerSpeed = 10;
        let carSpeed = 4;

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
                if (playerPosRect.right > carPos.left &&
                    playerPosRect.left < carPos.right &&
                    playerPosRect.bottom > carPos.top &&
                    playerPosRect.top < carPos.bottom) {
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

        // زيادة سرعة السيارات تدريجيًا
        function increaseCarSpeed() {
            carSpeed += 0.5;
            cars.forEach(car => {
                car.style.animationDuration = `${(4 / carSpeed)}s`;
            });
        }

        // تحديث اللعبة بشكل مستمر
        function gameLoop() {
            checkCollision();
            increaseCarSpeed();
            requestAnimationFrame(gameLoop);
        }

        gameLoop();
    </script>
</body>
</html>
<!DOCTYPE html>
<html lang="ar">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>لعبة الأسئلة</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; }
        .question { font-size: 24px; margin: 20px 0; }
        .answerButton { padding: 10px 20px; margin: 5px; background-color: #ffcc00; border: none; cursor: pointer; }
        .answerButton:hover { background-color: #e6b800; }
    </style>
</head>
<body>
    <h1>لعبة الأسئلة</h1>
    <div class="question" id="question"></div>
    <div id="answerOptions"></div>
    <p id="message"></p>
    <p id="score">النقاط: 0</p>

    <script>
        let questions = [
            { question: "من هو بطل مسلسل ناروتو؟", options: ["ناروتو", "ساسكي", "كاكاشي", "ساكورا"], answer: "ناروتو" },
            { question: "ما هي قوة دراجون بول؟", options: ["الدراغون بول", "القتال", "القدرة على الطيران", "التحول"], answer: "القتال" },
            { question: "أي شخصية في ون بيس تمتلك قوة اللاموت؟", options: ["لوفي", "زورو", "سانجي", "أوسوب"], answer: "لوفي" },
            { question: "ما هو اسم السيف الذي يستخدمه زورو؟", options: ["سانتوري", "ماسا", "كودا", "أونيكا"], answer: "سانتوري" },
            { question: "ما هو اسم الشخصية الرئيسية في مسلسل الهجوم على العمالقة؟", options: ["إرين ييغر", "ميكاسا", "أرمين", "زكريا"], answer: "إرين ييغر" },
            { question: "ما هي اللغة الرسمية في اليابان؟", options: ["اليابانية", "الإنجليزية", "الصينية", "الكورية"], answer: "اليابانية" },
            { question: "ما هي عاصمة فرنسا؟", options: ["باريس", "برلين", "لندن", "روما"], answer: "باريس" },
            { question: "من هو مخترع المصباح الكهربائي؟", options: ["توماس إديسون", "ألكسندر غراهام بل", "نيكولا تسلا", "ماركوني"], answer: "توماس إديسون" },
            { question: "ما هي أكبر قارة في العالم؟", options: ["آسيا", "أفريقيا", "أوروبا", "أمريكا الشمالية"], answer: "آسيا" },
            { question: "ما هو أقرب كوكب إلى الشمس؟", options: ["عطارد", "Venus", "الأرض", "المريخ"], answer: "عطارد" },
            { question: "ما هي وحدة قياس الحرارة؟", options: ["درجة مئوية", "كلفن", "فهرنهايت", "جميع ما سبق"], answer: "جميع ما سبق" },
            { question: "من هو مؤلف رواية '1984'؟", options: ["جورج أورويل", "تشارلز ديكنز", "مارك توين", "إرنست همنغواي"], answer: "جورج أورويل" },
            { question: "من هو أقوى شخصية في عالم مارفل؟", options: ["ثانوس", "هولك", "توني ستارك", "كابتن مارفل"], answer: "ثانوس" },
            { question: "ما هو أكبر محيط في العالم؟", options: ["المحيط الهادئ", "المحيط الأطلسي", "المحيط الهندي", "المحيط المتجمد الجنوبي"], answer: "المحيط الهادئ" },
            { question: "ما هو أطول نهر في العالم؟", options: ["نهر النيل", "أمازون", "الغانج", "الميزوري"], answer: "نهر النيل" },
            { question: "ما هو أسرع حيوان بري؟", options: ["الفهد", "الأسد", "النمر", "الذئب"], answer: "الفهد" },
            { question: "أي من هذه النباتات يحتوي على مادة الكافيين؟", options: ["الشاي", "القهوة", "الكاكاو", "جميع ما سبق"], answer: "جميع ما سبق" },
            { question: "ما هو اسم أول مركبة فضائية وصلت إلى القمر؟", options: ["أبولو 11", "سويوز 1", "تيتان 3", "كوزموس 4"], answer: "أبولو 11" },
            { question: "ما هو العنصر الكيميائي الذي يرمز له بـ 'O'؟", options: ["الأوكسجين", "الذهب", "الفضة", "النحاس"], answer: "الأوكسجين" },
            { question: "ما هو أول فيلم في سلسلة أفلام 'Star Wars'؟", options: ["A New Hope", "The Empire Strikes Back", "Return of the Jedi", "The Phantom Menace"], answer: "A New Hope" },
            { question: "من هو مؤسس شركة مايكروسوفت؟", options: ["بيل غيتس", "ستيف جوبز", "مارك زوكربيرغ", "لاري بيدج"], answer: "بيل غيتس" },
            { question: "أي من هذه الألعاب تعتبر لعبة فيديو مشهورة؟", options: ["Minecraft", "Monopoly", "Poker", "Chess"], answer: "Minecraft" },
            { question: "ما هي أقدم لغة حية في العالم؟", options: ["السنسكريتية", "العربية", "اللاتينية", "العبرية"], answer: "العربية" },
            { question: "ما هو أكبر كوكب في النظام الشمسي؟", options: ["المشتري", "زحل", "أورانوس", "نبتون"], answer: "المشتري" },
            { question: "ما هو اسم آخر فيلم في سلسلة أفلام 'Harry Potter'؟", options: ["Deathly Hallows", "Goblet of Fire", "Prisoner of Azkaban", "Chamber of Secrets"], answer: "Deathly Hallows" },
            { question: "أي من هذه الألعاب تعتبر من الألعاب الرياضية؟", options: ["التنس", "الطائرة الورقية", "الرقص", "اليوغا"], answer: "التنس" }
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

