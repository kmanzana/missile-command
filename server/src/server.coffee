
express = require("express")
http = require("http")
path = require("path")
board = require './board'

app = express()

# all environments
app.set "port", process.env.PORT or 3000
app.set "views", __dirname + "/../../../views"
app.set "view engine", "jade"
app.use express.favicon()
app.use express.logger("dev")
app.use express.bodyParser()
app.use express.methodOverride()
app.use app.router
app.use express.static(path.join(__dirname, "public"))

# development only
app.use express.errorHandler()  if "development" is app.get("env")

app.get "/", (req, res) ->
    res.render 'index'

app.get "/board", (req, res) ->
    board.on 'ready', -> this.motorize(5000)

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
