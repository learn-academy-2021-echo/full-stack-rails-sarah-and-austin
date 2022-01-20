class HerbController < ApplicationController

  def index
    # instance variable that holds an active record query to get all the herbs
    @herbs = Herb.all
  end

  def show
    @herb = Herb.find(params[:id])
  end

  def new
    @herb = Herb.new
  end

  def create
    @herb = Herb.create(herb_params)
    if @herb.valid?
      redirect_to herbs_path
    else
      redirect_to new_herb_path
    end
  end

  def edit
    @herb = Herb.find(params[:id])
  end

  def update
    @herb = Herb.find(params[:id])
    @herb.update(herb_params)
    if @herb.valid?
      redirect_to herb_path(@herb)
    else
      redirect_to edit_herb_path(@herb)
    end
  end

  private
  def herb_params
    params.require(:herb).permit(:name, :watered)
  end

end
