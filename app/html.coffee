

# Forgive us for doing this, but it's a hackfest, we were in a rush...

exports.submitRating = """
<head>
  <script src="http://code.jquery.com/jquery-1.7.2.min.js"></script>
</head>
<body>
  <input id="url" value="/test/rate"><br>
  <textarea id="attr" style="width:500px;height:200px;font-size:20px">{
  "userID": 1,
  "thingID": 1,
  "attr": {
  }
}
  </textarea>
  <input id="submit" type="submit">
  <pre style="font-size:20px"></pre>
  <script>
  $.fn.extend({
    insertTab: function() {
      var startPos = this[0].selectionStart;
      var endPos = this.selectionEnd;
      var val = this.val();
      this.val(val.substr(0, startPos)+'  '+val.substr(startPos));
      this.focus();
      this[0].selectionStart = startPos + 2;
      this[0].selectionEnd = startPos + 2;
    }
})
    function submit(){
    $.post($('#url').val(), JSON.parse($('#attr').val()), function(data){
      $('pre').html(data)
    });
    }
    $('#submit').click(submit)
    $('#attr').keydown(function(e){
      if(e.which!=9) return;
      e.preventDefault();
      $(this).insertTab();
    });
  </script>
</body>
"""
