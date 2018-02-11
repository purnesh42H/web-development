defmodule Memory.Game do
  def new do
    %{
      tiles: [],
      clicks: 0
    }
  end
  
  def client_view(game) do
    %{
      tiles: [%{
  			id: "t1", letter: "D", hidden: true, matched: false
  		}, %{
  			id: "t2", letter: "H", hidden: true, matched: false
 	  	}, %{
  			id: "t3", letter: "B", hidden: true, matched: false
  		}, %{
  			id: "t4", letter: "E", hidden: true, matched: false
  		}, %{
  			id: "t5", letter: "C", hidden: true, matched: false
  		}, %{
  			id: "t6", letter: "C", hidden: true, matched: false
  		}, %{
  			id: "t7", letter: "E", hidden: true, matched: false
  	  }, %{
  			id: "t8", letter: "G", hidden: true, matched: false
  	  }, %{
			  id: "t9", letter: "F", hidden: true, matched: false
  	  }, %{
  		  id: "t10", letter: "G", hidden: true, matched: false
  	  }, %{
	  		id: "t11", letter: "H", hidden: true, matched: false
  	  }, %{
  		  id: "t12", letter: "F", hidden: true, matched: false
  	  }, %{
  			id: "t13", letter: "D", hidden: true, matched: false
 	   	}, %{
  		  id: "t14", letter: "A", hidden: true, matched: false
  	  }, %{
  		  id: "t15", letter: "B", hidden: true, matched: false
  	  }, %{
  			id: "t16", letter: "A", hidden: true, matched: false
  	  }],
      clicks: 0,
    }
  end
end
