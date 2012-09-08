class BlogController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :load_post, :only => [:show, :edit, :update]

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  protected

  def load_post
  end
end
