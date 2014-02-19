$(document).ready(function()
{ 



if ($('h1#game').length){
var animal_names = new Array();
var alternative_names = new Array();
var animal_image_urls = new Array();
var alternative_image_urls = new Array();
var sounds = new Array();
var answers = new Array();
var user_answers = new Array();
var choice;

        var items = [];
        $('#disappear').fadeOut();

		//diff= "easy";
		n_quiz= location.search.substr(1).split("&")[0].split("=")[1];
		diff= location.search.substr(1).split("&")[1].split("=")[1];

$.getJSON( "quizzes/prepare_game?num="+n_quiz+"&diff="+diff, function( data )
{

$.each( data, function( key, val)
{
animal_names.push(val.animal.name);
alternative_names.push(val.alternative.name);
animal_image_urls.push(val.animal.avatar);
alternative_image_urls.push(val.alternative.avatar);

choice = Math.floor(Math.random()*2) +1;

if(choice == 1)
{
	sounds.push(val.animal.sound);
	answers.push('#animal');
}
else
{
	sounds.push(val.alternative.sound);
	answers.push('#alternative');
}



});
var i;
var score=0;
i=0;
$('#animal').append('<img src="'+animal_image_urls[i]+'" style="max-height: 300px;" >');
$('#alternative').append('<img src="'+alternative_image_urls[i]+'" style="max-height: 300px;" >');
$('#sound').append('<audio autoplay controls'+">"+'<source src="'+sounds[i]+'"/></audio>');

var seconds = 10;
function mytimer()
{
	if(seconds === -1)
	{

		user_answers[i]= false;
		$('#next').click();
	}
	document.getElementById("div_timer").innerHTML = seconds;

	seconds--;


} 
var timer = setInterval(function(){mytimer()},1000);





if(answers[0] === '#animal')
	other = '#alternative';
else
	other = '#animal';

$(answers[0]).click( function() {
	score++;
	user_answers[0] = true;

	//scatenare evento click su next

	$( '#next' ).click();
});
$(other).click( function() {
	//scatenare evento click su next
	user_answers[0] = false;

	$( '#next' ).click();
});


$( "#next" ).click( function() {
	i++;
	seconds= 10;
	clearInterval(timer);
	$('#animal').unbind();
	$('#alternative').unbind();
	$('#animal').empty();
	$('#alternative').empty();
	$('#sound').empty();
	

	if(i<animal_names.length)
	{
		
		
		document.getElementById("div_timer").innerHTML = seconds;

		timer = setInterval(function(){mytimer()},1000);
		$('#animal').append('<img src="'+animal_image_urls[i]+'" style="max-height: 300px;" >');
		$('#alternative').append('<img src="'+alternative_image_urls[i]+'" style="max-height: 300px;" >');

		$('#sound').append('<audio autoplay controls'+">"+'<source src="'+sounds[i]+'"/></audio>');
		

		if(answers[i] === '#animal')
			other = '#alternative';
		else
			other = '#animal';

		$(answers[i]).click( function() {
			score++;
			user_answers[i] = true;

			//scatenare evento click su next

			$( '#next' ).click();
		});
		$(other).click( function() {
			//scatenare evento click su next
			user_answers[i] = false;

			$( '#next' ).click();
		});
	}
	else
	{
		//game ended
		$('#next').fadeOut();
		$('#div_timer').fadeOut();
                $('#table_quiz').fadeOut();
		$('#game').fadeOut();
              
		$('#score').text("You scored "+score+" points!!!");

		
            
			var quiz_id= "#quiz" + i;
               
		for(i=0; i<animal_names.length; i++)
		{
			$('#container').append('<div id="quiz'+i+'"></div>');
			var quiz_id= "#quiz" + i;

                    
                       
			
			var answer_validity_url;
			if(user_answers[i] === true)
				answer_validity_url= "/assets/tick.png";
			else
				answer_validity_url= "/assets/cross.png";
		
			$(quiz_id).append('<span><img src="'+answer_validity_url+'" style="max-width: 40px; max-height: 40px;" ></span>');
                        $(quiz_id).append('<span><img class="img-quiz" src="'+animal_image_urls[i]+'" style="max-width: 100px; max-height: 100px;" ></span>');
			$(quiz_id).append('<span><img class="img-quiz" src="'+alternative_image_urls[i]+'" style="max-width: 100px; max-height: 100px;" ></span>');
                        $(quiz_id).append('<audio controls'+">"+'<source src="'+sounds[i]+'"/></audio>');
                        $(quiz_id).append('<div></div>');
		}
        
		$(document.body).append('<form method="get" action="ranking">'+'<input type="hidden" name="score" value="'+score+'"><input type="hidden" name="diff" value="'+diff+'">'+'<input type="submit" value="Submit score and view ranking">'+'</form>');

	}
});


});

          
          return false;
}
});
