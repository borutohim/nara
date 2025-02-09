<!DOCTYPE html>
<html lang="ar">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>لعبة عبور الشارع</title>
    <style>
        * {
            margin: 0;
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
