<%-- 
    Document   : index
    Created on : 19 Jun, 2019, 7:00:44 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <style type="text/css">  
        body {  
            margin: 0;    
        }  
        .showSlide {  
            display: none  
        }  
            .showSlide img {  
                width: 100%;  
            }  
        .slidercontainer {  
            max-width: 1000px;  
            position: relative;  
            margin: auto;  
        }  
        .left, .right {  
            cursor: pointer;  
            position: absolute;  
            top: 50%;  
            width: auto;  
            padding: 16px;  
            margin-top: -22px;  
            color: white;  
            font-weight: bold;  
            font-size: 18px;  
            transition: 0.6s ease;  
            border-radius: 0 3px 3px 0;  
        }  
        .right {  
            right: 0;  
            border-radius: 3px 0 0 3px;  
        }  
            .left:hover, .right:hover {  
                background-color: rgba(115, 115, 115, 0.8);  
            }  
        .content {  
            color: #eff5d4;  
            font-size: 30px;  
            padding: 8px 12px;  
            position: absolute;  
            top: 10px;  
            width: 100%;  
            text-align: center;  
        }  
        .active {  
            background-color: #717171;  
        }  
        /* Fading animation */  
        .fade {  
            -webkit-animation-name: fade;  
            -webkit-animation-duration: 1.5s;  
            animation-name: fade;  
            animation-duration: 1.5s;  
        }  
        @-webkit-keyframes fade {  
            from {  
                opacity: .4  
            }  
            to {  
                opacity: 1  
            }  
        }  
  
        @keyframes fade {  
            from {  
                opacity: .4  
            }  
            to {  
                opacity: 1  
            }  
        }  
        .column {
  float: left;
  width: 20%;
  height: auto;
  padding: 25px;
}

/* Clear floats after image containers */
.row::after {
  content: "";
  clear: both;
  display: table;
}
.row {
  display: flex;
}

.column {
  flex: 20%;
  padding: 25px;
}
    </style>  
            
    </head>
    <link rel="stylesheet" type="text/css" href="css/home.css"/>
    <body>
        <div>
        <%@include file="top_header.jsp" %>
        </div>
        <br/>
        <br/>
        <br/>
            <div class="slidercontainer">  
        <div class="showSlide fade">  
            <img src="pictures/slider.jpg" />  
        </div>  
        <div class="showSlide fade">  
            <img src="pictures/s.jpg" />  
        </div>  
  
        <div class="showSlide fade">  
            <img src="pictures/slider5.jpg" />  
        </div>  
        <div class="showSlide fade">  
            <img src="pictures/slider (4).jpg" />  
        </div>  
        <!-- Navigation arrows -->  
        <a class="left" onclick="nextSlide(-1)">❮</a>  
        <a class="right" onclick="nextSlide(1)">❯</a>  
    </div>  
  
    <script type="text/javascript">  
        var slide_index = 1;  
        displaySlides(slide_index);  
  
        function nextSlide(n) {  
            displaySlides(slide_index += n);  
        }  
  
        function currentSlide(n) {  
            displaySlides(slide_index = n);  
        }  
  
        function displaySlides(n) {  
            var i;  
            var slides = document.getElementsByClassName("showSlide");  
            if (n > slides.length) { slide_index = 1; }  
            if (n < 1) { slide_index = slides.length; }  
            for (i = 0; i < slides.length; i++) {  
                slides[i].style.display = "none";  
            }  
            slides[slide_index - 1].style.display = "block";  
        }  
    </script>
    <br/>
    <br/>
    <br/>
  
    
    <div class="row">
  <div class="column">
    <img src="pictures/cl.jpg" alt="Snow" style="width:100%">
  </div>
  <div class="column">
    <img src="pictures/cl42.jpg" alt="Forest" style="width:100%">
  </div>
  <div class="column">
    <img src="pictures/cl3.jpg" alt="Mountains" style="width:100%">
  </div>
<div class="column">
    <img src="pictures/cl4.jpg" alt="Snow" style="width:100%">
  </div>
        <div class="column">
    <img src="pictures/cl5.jpg" alt="Snow" style="width:100%">
  </div>
</div>
   
    
    <br/>
    <br/>
    <%@include file="footer.jsp" %>
    </body>
    
</html>
