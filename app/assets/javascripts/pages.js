$(document).ready(function()
{ //var n_quiz;
/*if ($('h1#home').length){
	alert("HOME");
	$("#disappear").bind('submit', function() {
	 alert("SUBMITTED");
         n_quiz= $("input[type='radio'][name='num']:checked").val();
	alert(n_quiz);

   });
}*/




if ($('h1#game').length){
var animal_names = new Array();
var alternative_names = new Array();
var animal_image_urls = new Array();
var alternative_image_urls = new Array();
var sounds = new Array();
var answers = new Array();
var user_answers = new Array();
var choice;
console.log("fuck javascript!");
        var items = [];
        $('#disappear').fadeOut();
                //var num= <%= @num_quiz %>;
		//<% if !@num_quiz.nil? %>
		//var n_quiz= <%= @num_quiz %>;
		//<% end %>
		//var num= 2;
		n_quiz= location.search.substr(1).split("&")[1].split("=")[1];
                //alert(n_quiz);
$.getJSON( "quizzes/prepare_game?num="+n_quiz, function( data )
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

//answers.push(choice);

});
var i;
var score=0;
i=0;
$('#animal').append('<img src="'+animal_image_urls[i]+'" style="max-height: 300px;" >');
$('#alternative').append('<img src="'+alternative_image_urls[i]+'" style="max-height: 300px;" >');
$('#sound').append('<audio autoplay controls'+">"+'<source src="'+sounds[i]+'"/></audio>');
//alert(i);
//alert("length vale" + animal_names.length);


if(answers[0] === '#animal')
	other = '#alternative';
else
	other = '#animal';

$(answers[0]).click( function() {
	score++;
	user_answers[0] = true;
	//scatenare evento click su next
	//i++;
	$( '#next' ).click();
});
$(other).click( function() {
	//scatenare evento click su next
	user_answers[0] = false;
	//i++;
	$( '#next' ).click();
});


$( "#next" ).click( function() {
	i++;
	$('#animal').unbind();
	$('#alternative').unbind();
	$('#animal').empty();
	$('#alternative').empty();
	$('#sound').empty();
	//alert(i);
	if(i<animal_names.length)
	{
  		//alert("SONO IN CICLO CASO i < length");
		$('#animal').append('<img src="'+animal_image_urls[i]+'" style="max-height: 300px;" >');
		$('#alternative').append('<img src="'+alternative_image_urls[i]+'" style="max-height: 300px;" >');
		//alert(sounds[i]);
		$('#sound').append('<audio autoplay controls'+">"+'<source src="'+sounds[i]+'"/></audio>');
		
		if(answers[i] === '#animal')
			other = '#alternative';
		else
			other = '#animal';

		$(answers[i]).click( function() {
			score++;
			user_answers[i] = true;
			//scatenare evento click su next
			//i++;
			$( '#next' ).click();
		});
		$(other).click( function() {
			//scatenare evento click su next
			user_answers[i] = false;
			//i++;
			$( '#next' ).click();
		});
	}
	else
	{
		//game ended
		$('#next').fadeOut();
		//alert(other);
		$('#animal').append('<p>'+score+'</p>');
	}
});

/*
for(i=0; i<animal_names.length; i++)
{
	$('#animal').append('<img src="'+animal_image_urls[0]+'" style="max-height: 300px;" >');
	$('#alternative').append('<img src="'+alternative_image_urls[0]+'" style="max-height: 300px;" >');
	huhuhu
}*/
//items.push( "<li id='" + i + "'>" + animal_names[i] + "</li>" );


//$( "<ul/>", {"class": "my-new-list", html: items.join( "" )}).appendTo( "body" );

});

          
          return false;
}
});
