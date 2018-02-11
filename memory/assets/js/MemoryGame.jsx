import React from 'react';
import ReactDOM from 'react-dom';

export default function game_init(root, channel) {
  ReactDOM.render(<MemoryGame channel={channel} />, root);
}

class MemoryGame extends React.Component {
	constructor(props) {
  	super(props);
        this.channel = props.channel;
  	this.state = {
      tiles: [],
      clicks: 0
    }
    this.channel.join
        .receive("ok", this.gotView.bind(this))
        .receive("error", resp => { console.log("Unable to join", resp) });
  }

  gotViewDelay(view) {
    setTimeout(function() { this.setState({
        tiles: view.game.tiles,
        clicks: view.game.clicks
       });
     }.bind(this), 1000);
  }

  gotView(view) {
   this.setState({
        tiles: view.game.tiles,
        clicks: view.game.clicks
       });
  }

  reset() {

  }

  getActiveTile() {
    return _.find(this.state.tiles, (tile) => {
      return tile.hidden == false;
    });
  }

  gotViewMatch(view, guess_id, active) {
    this.gotView(view);
    if (active) {
      this.channel.push("guess", { id: guess_id })
        .receive("ok", this.gotViewDelay.bind(this));
    }
  }

  sendGuess(id) {
    this.toggleVisibility(id);
  }

  toggleVisibility(id) {
    let active = this.getActiveTile(id);
    this.channel.push("flip", { id: id })
      .receive("ok", res => {
      this.gotViewMatch(res, id, active);
    });
  }

  render() {
    let tile_list = _.map(this.state.tiles, (tile, ii) => {
      return <Tile tile={tile} sendGuess={this.sendGuess.bind(this)} key={ii} />;
	});

  return (
	    <div className="row game-row">
	      { tile_list }
        <ClickCount clicks={this.state.clicks} />
        <Reset reset={this.reset.bind(this)} />
	    </div>
   )
  }
}

function ClickCount(params) {
   return (
    <div className="col-6">
      <p><b>No. of clicks: </b>{params.clicks}</p>
    </div>
  )
}

function Reset(params) {
  return (
    <div className="col-6">
      <button id="reset" onClick={params.reset}>Restart</button>
    </div>
  )
}

function Tile(params) {
  let item = params.tile;
  if (item.matched) {
    return (
	  <div className="col-3 game-col-matched">
	    <p id = {item.id}></p>
    </div>
	)
  } else if (item.hidden) {
    return (
	  // <div className="col-3 game-col" onClick={() => params.matchTile(item.id, item.letter)}>
    <div className="col-3 game-col" onClick={() => params.sendGuess(item.id)}>
	    <p id = {item.id}></p>
    </div>
    )
  } else {
    return (
  	  <div className="col-3 game-col">
  	    <p id = {item.id}>{item.letter}</p>
      </div>
    )
  }
}
