// $(document).ready(function(){
//   $("#new_bid").submit(function(event){
//       event.preventDefault();
//       var amount = $("#bid_amount").val();
//       $.ajax({
//         url: $(".new_bid").attr("action") + ".json",
//         method: "POST",
//         contentType: "application/json; charset=utf-8",
//         dataType: "json",
//         data: {bid: { amount: amount} },
//         errors: function(){
//           alert("something went awry");
//         },
//         success: function(data){
//
//           $("#bid_amount").val("0");
//           // console.log(data);
//           // $(".bids").prepend("")
//         }
//       });
//   });
// });
