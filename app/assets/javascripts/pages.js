$(document).ready(function(){ 

  // we want this code to run only on the game page
  if ($('h1#game').length > 0){

    // read game parameters from querystring
    n_quiz= location.search.substr(1).split("&")[0].split("=")[1];
    diff= location.search.substr(1).split("&")[1].split("=")[1];

    // AJAX call to fetch quizzes data
    // this loads data for all the quizzes of this game session (n_quiz quizzes)
    // and "runs the game", i.e. presents the quizzes one after one, manipulating the DOM;
    // for each quiz in the set the answer is randomly chosen and the corresponding file is played
    // the user answer is evaluated according to this choice
    $.getJSON("quizzes/prepare_game?num="+n_quiz+"&diff="+diff, run_game);
    
    return false;
  }
});


function run_game(data){
    var animal_names = new Array();
    var alternative_names = new Array();
    var animal_image_urls = new Array();
    var alternative_image_urls = new Array();
    var sounds = new Array();
    var answers = new Array();  				// contains right answer to each quiz
    var user_answers = new Array();                             // validity of each user answer
    var choice;     						// used for random choice of the answer to each quiz

    var i;
    var score;
    var seconds;
    
    // timeout is shown bigger when only 3 seconds remain to answer the current quiz
    // when time's up, we trigger a "skip quiz"
    function mytimer(){
	if(seconds === -1){
	    user_answers[i]= false;
	    $('#next').click();
	}
	if(seconds === 3){
	    $('#div_timer').addClass('hover');
	    $('#div_timer').removeClass('div_timer');
	}
	$('#div_timer').html(seconds);
	seconds--;
    }
    
    // populate var's with JSON data
    $.each(data, function(key, val){
	animal_names.push(val.animal.name);
	alternative_names.push(val.alternative.name);
	animal_image_urls.push(val.animal.avatar);
	alternative_image_urls.push(val.alternative.avatar);

	// random choice of the answer to the i-th quiz
	choice = Math.floor(Math.random()*2) +1;

	if(choice == 1){
	    sounds.push(val.animal.sound);
	    answers.push('#animal');
	}
	else{
	    sounds.push(val.alternative.sound);
	    answers.push('#alternative');
	}
    });
    
    // first quiz is presented
    score=0;
    i=0;
    seconds = 10;
    $('#animal').append('<img src="'+animal_image_urls[i]+'" style="max-height: 300px;" >');
    $('#alternative').append('<img src="'+alternative_image_urls[i]+'" style="max-height: 300px;" >');
    $('#sound').append('<audio autoplay controls'+">"+'<source src="'+sounds[i]+'"/></audio>');

    var timer = setInterval(mytimer,1000);

    if(answers[0] === '#animal')
	other = '#alternative';
    else
	other = '#animal';

    // answer is skipped (next quiz, if any, is shown, as this one was)
    $("#next").click(show_next_quiz);

    // matching picture is clicked
    $(answers[0]).click(function(){
	score++;
	user_answers[0] = true;
	// we can proceed to next quiz
	$('#next').click();
    });
    
    // wrong picture is clicked
    $(other).click(function(){
	user_answers[0] = false;
	// we can proceed to next quiz
	$('#next').click();
    });

    
    
    function show_next_quiz(){
	i++;
	seconds= 10;                 // timeout is reset 
	
	// timer is set back to its original state
	$('#div_timer').removeClass('hover');                     
	$('#div_timer').addClass('div_timer');
	clearInterval(timer);
	
	$('#animal').unbind();
	$('#alternative').unbind();
	$('#animal').empty();
	$('#alternative').empty();
	$('#sound').empty();
	
	// if there are still quizzes to show...
	if(i<animal_names.length){
	    timer = setInterval(mytimer,1000);
	    $('#div_timer').html(seconds);
	    
	    // i-th quiz is presented
	    $('#animal').append('<img src="'+animal_image_urls[i]+'" style="max-height: 300px;" >');
	    $('#alternative').append('<img src="'+alternative_image_urls[i]+'" style="max-height: 300px;" >');
	    $('#sound').append('<audio autoplay controls'+">"+'<source src="'+sounds[i]+'"/></audio>');
	    

	    if(answers[i] === '#animal')
		    other = '#alternative';
	    else
		    other = '#animal';

	    // matching picture clicked
	    $(answers[i]).click(function(){
		    score++;
		    user_answers[i] = true;
		    // on to the next quiz (if any)
		    $('#next').click();
	    });

	    // wrong picture clicked
	    $(other).click(function(){
		    // on to the next quiz (if any)
		    user_answers[i] = false;
		    $('#next').click();
	    });
	}
	else{
	    //game ended
	    $('#next').fadeOut();
	    $('#div_timer').fadeOut();
	    $('#table_quiz').fadeOut();
	    $('#game').fadeOut();
	  
	    score= parseInt(score/n_quiz * 100);
	    $('#score').text("You scored "+score+" points!!!");
	    $('#score').append("<br/><br/>");
	    

	    var quiz_id= "#quiz" + i;

	    $('#container').addClass("transparent-result");
	    
	    // a recap is shown
	    for(i=0; i<animal_names.length; i++){
		$('#container').append('<div id="quiz'+i+'"></div>');
		var quiz_id= "#quiz" + i;

		var answer_validity_url;
		if(user_answers[i] === true)
		    answer_validity_url= "/assets/tick.png";
		else
		    answer_validity_url= "/assets/cross.png";
	
		$(quiz_id).append('<span><img src="'+answer_validity_url+'" style="max-width: 40px; max-height: 40px;" ></span>');
		$(quiz_id).append('<span class="img-quiz"><img src="'+animal_image_urls[i]+'" style="max-width: 100px; max-height: 100px;" ></span>');
		$(quiz_id).append('<span class="img-quiz"><img src="'+alternative_image_urls[i]+'" style="max-width: 100px; max-height: 100px;" ></span>');
		$(quiz_id).append('<audio controls'+">"+'<source src="'+sounds[i]+'"/></audio>');
		$(quiz_id).append('<div></div><br/><br/><br/>');
	    }

	    $('#button-game').append('<br/><br/><br/>');
	    $('#button-game').append('<form method="get" action="ranking">'+'<input type="hidden" name="score" value="'+score+'"><input type="hidden" name="diff" value="'+diff+'">'+'<input type="submit" id="ranking-button" value="Submit score and view ranking">'+'</form>');
             
	}
    }


}