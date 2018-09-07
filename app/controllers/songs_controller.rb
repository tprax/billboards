class SongsController < ApplicationController
  
  before_action :ask_action 
  before_action :set_song, except: [:index, :new, :create]
  
  # params.key?("artist_id")
  
  def index
    @songs = @artist.songs
    
  end

  def show

  end

  def new
    if @billboard
      @var = set_billboard
    else
      @var = set_artist
    end
    @song = @var.songs.new
    
    
    render partial: 'form'
  end

  def create

    if @billboard
      @var = set_billboard
    else
      @var = set_artist
    end

    @song = @var.songs.new(song_params)

    if @song.save
     
      params.key?("artist_id") ? (redirect_to artist_path(@var)) : (redirect_to billboard_path(@var))
      # redirect_to artist_path(@var)
    else
      
      render :new
    end

  end

  def edit
    render partial: "form"
  end

  def update
    if @song.update(song_params)
      params.key?("artist_id") ? (redirect_to artist_song_path(@var, @song)) : (redirect_to billboard_songs_path(@var))
      # redirect_to artist_song_path(@var, @song)
    else
      render partial: 'edit'
    end

  end

  def destroy

    if @billboard
      @var = set_billboard
    else
      @var = set_artist
    end

    @song.destroy
    params.key?("artist_id") ? (redirect_to artist_songs_path(@var)) : (redirect_to billboard_songs_path(@var))
  end

  private

    def ask_action
      if params.key?("artist_id")
        set_artist
      elsif params.key?("billboard_id")
        set_billboard
      end
    end

    def set_artist
      @artist = Artist.find(params[:artist_id])
    end

    def set_billboard
      @billboard = Billboard.find(params[:billboard_id])
    end

    def set_song
      @song = Song.find(params[:id])
    end

    def song_params
      params.require(:song).permit(:name, :artist_id, :billboard_id)
    end

    # def var_song_path(id1, id2)
    #   if var==artist
    #     artist_song_path
    #   elsif var == billboard_id
    #     billboard_song_path
    #   end
    # end

end
