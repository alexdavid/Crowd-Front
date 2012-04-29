

# Forgive us for doing this, but it's a hackfest, we were in a rush...

exports.submitRating = """
<head>
  <script src="http://code.jquery.com/jquery-1.7.2.min.js"></script>
</head>
<body>
  <input id="url" value="/test/rate"><br>
  <textarea id="attr" style="width:500px;height:200px">{
  "userID": 1,
  "thingID": 1,
  "attr": {
  }
}
  </textarea>
  <input id="submit" type="submit">
  <pre></pre>
  <script>
    function submit(){
      console.log(JSON.parse($('#attr').val()))
    $.post($('#url').val(), JSON.parse($('#attr').val()), function(data){
      $('pre').html(data)
    });
    $('#attr').val("")
    }
    $('#submit').click(submit)
  </script>
</body>
"""
