<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MascaraChatBot.aspx.cs" Inherits="VisualChatBot.MascaraChatBot" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Chatbot</title>

    <!-- Site Icons -->
    <link rel="shortcut icon" href="img/Luno.jpg" type="image/x-icon" />

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .chat-container {
            width: 520px;
            height: 800px;
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            overflow: hidden;
        }

        .chat-header {
            background-color: #f0f8ff;
            padding: 15px;
            display: flex;
            align-items: center;
            border-bottom: 1px solid #ccc;
        }

            .chat-header .logo {
                width: 30px;
                height: 30px;
                margin-right: 10px;
            }

        h2 {
            margin: 0;
            font-size: 18px;
        }

        .chat-box {
            height: 400px;
            height: 600px;
            padding: 10px;
            overflow-y: auto;
            background-color: #fafafa;
        }

        .message {
            padding: 10px;
            border-radius: 10px;
            margin-bottom: 10px;
            width: fit-content;
            max-width: 80%;
        }

            .message.bot {
                background-color: #e1f5fe;
                align-self: flex-start;
            }

            .message.user {
                background-color: #faecc5;
                align-self: flex-end;
                margin-left: auto;
            }

        .button-group {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

            .button-group button {
                padding: 10px;
                background-color: #2196f3;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

                .button-group button:hover {
                    background-color: #1976d2;
                }

        .input-area {
            display: flex;
            padding: 10px;
            background-color: #fafafa;
            border-top: 1px solid #ccc;
        }

        input[type="text"] {
            flex-grow: 1;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 20px;
            margin-right: 5px;
            outline: none;
        }

        button {
            padding: 10px;
            background-color: #4caf50;
            color: white;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

            button:hover {
                background-color: #45a049;
            }
    </style>
</head>
<body>

    <div class="chat-container">
        <div class="chat-header">
            <img src="img/Luno.jpg" alt="Luno Logo" class="logo" />
            <h2>Luno</h2>
        </div>
        <div class="chat-box" id="chatBox">
            <div class="message bot">
                <p>Hola!. No tienes un pedacito de queso?</p>
            </div>
            <div class="button-group">
                <button onclick="sendMessage('hola')">Hola!</button>
                <button onclick="sendMessage('como estas?')">¿Como Estas?</button>
                <button onclick="sendMessage('que puedes hacer?')">¿Que Puedes Hacer?</button>
            </div>
        </div>
        <div class="input-area">
            <input type="text" id="userInput" placeholder="Enter your message..." />
            <button onclick="sendUserMessage()">➤</button>
        </div>
    </div>

    <script>
        const chatBox = document.getElementById('chatBox');
        const userInput = document.getElementById('userInput');

        async function sendMessage(mensaje) {
            try {
                console.log('Intentando enviar el mensaje...');

                const response = await fetch('https://localhost:44351/api/chatbot', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    },
                    body: JSON.stringify({ mensaje }) // Aquí se ajusta el campo
                });

                console.log('Respuesta recibida:', response);

                if (!response.ok) {
                    throw new Error(`Error: ${response.status}`);
                }

                const data = await response.json();
                console.log('Respuesta JSON:', data);
                displayMessage(data.respuesta, 'bot');
            } catch (error) {
                console.error('Error en la solicitud:', error);
                displayMessage('Error al conectar con el servidor.', 'bot');
            }
        }


        function sendUserMessage() {
            const message = userInput.value.trim();
            displayMessage(message, 'user')
            if (message) {
                sendMessage(message);
                userInput.value = '';
            }
        }

        function displayMessage(text, sender) {
            const messageElement = document.createElement('div');
            messageElement.classList.add('message', sender);
            messageElement.innerHTML = `<p>${text}</p>`;
            chatBox.appendChild(messageElement);

            // Desplazar automáticamente hacia abajo cuando llegue un mensaje nuevo
            chatBox.scrollTop = chatBox.scrollHeight;
        }
</script>

</body>
</html>
