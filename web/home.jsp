<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

    <title>Poultry Derby - Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;700&display=swap" rel="stylesheet">

    <style>
        *{
            font-family: 'Poppins', sans-serif;
        }
        body{
            margin:0;
            min-height:100vh;

            background: linear-gradient(
                135deg,
                #0f0f0f,
                #1a1a1a,
                #111111
            );
            overflow-x:hidden;
        }
        .navbar-custom{background: rgba(0,0,0,0.7); backdrop-filter: blur(10px); border-bottom: 1px solid rgba(255,255,255,0.08);}

        .navbar-brand{color: #ffffff !important; font-size: 30px; font-weight: 700;}

        .main-card{
            background: rgba(255,255,255,0.05);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(255,255,255,0.08);
            border-radius: 28px;
            transition: 0.3s;
            box-shadow:
            0 0 25px rgba(0,0,0,0.4);
        }
        .main-card:hover{transform: translateY(-5px); box-shadow: 0 0 35px rgba(0,0,0,0.6);}

        .chicken-icon{width: 120px; margin-bottom: 25px; filter: drop-shadow(0 0 15px rgba(255,255,255,0.2));}

        .welcome-title{color: white; font-size: 58px; font-weight: 700;}

        .welcome-title span{color: #00ffb3;}

        .sub-text{color: #bdbdbd; font-size: 20px; font-weight: 300;}

        .start-btn{background: #00ffb3; color: black; border:none; padding: 15px 45px; border-radius: 50px; font-size: 22px; font-weight: 600; transition: 0.3s; box-shadow: 0 0 20px rgba(0,255,179,0.3);}

        .start-btn:hover{transform: scale(1.05); background: #5fffd1; color:black;}

        @media screen and (max-width:768px){
            .welcome-title{font-size: 38px; }
            .sub-text{font-size:16px;}
            .start-btn{ width:100%; font-size:18px;}
        }

    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom px-4">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">🐔 Poultry Derby </a>
        </div>
    </nav>
    <div class="container py-5">
        <div class="row justify-content-center align-items-center" style="min-height:80vh;">
            <div class="col-12 col-md-10 col-lg-7">
                <div class="main-card text-center p-4 p-md-5">
                    <img src="https://cdn-icons-png.flaticon.com/512/3069/3069172.png"class="chicken-icon">
                    <h1 class="welcome-title"> Welcome, <span>${user.username}</span>!</h1>
                    <p class="sub-text mt-4"> Train your poultry to become the ultimate champion.</p>
                    <div class="mt-5">
                        <a href="career?action=select" class="btn start-btn">Start New Career</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
