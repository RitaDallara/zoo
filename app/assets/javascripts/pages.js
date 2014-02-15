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
                alert(n_quiz);
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
sounds.push(val.animal.sound);
else
sounds.push(val.alternative.sound);

answers.push(choice);

});


var i;
for(i=0; i < animal_names.length; i++)
{
items.push( "<li id='" + i + "'>" + animal_names[i] + "</li>" );
}

$( "<ul/>", {"class": "my-new-list", html: items.join( "" )}).appendTo( "body" );

});

          
          return false;
}
});
