class CountersController < ApplicationController
  before_action :set_counter, only: %i[ increment decrement edit update destroy ]

  # GET /counters or /counters.json
  def index
    @user = Current.user
    @counters = @user.counters.all
  end

  # GET /counters/new
  def new
    @counter = Counter.new
  end

  # GET /counters/1/edit
  def edit
  end

  def increment
    respond_to do |format|
      if @counter.update(amount: @counter.amount + 1)
        format.html { redirect_to counters_path }
      end
    end
  end

  def decrement
    respond_to do |format|
      if @counter.update(amount: @counter.amount - 1)
        format.html { redirect_to counters_path }
      else
        format.html { redirect_to counters_path, alert: "Cant go minus! Let´s go for a new try!" }
      end
    end
  end
  # POST /counters or /counters.json
  def create
    @user = Current.user
    @counter = @user.counters.build(counter_params)

    respond_to do |format|
      if @counter.save
        format.html { redirect_to counters_path, notice: "Counter was successfully created." }
        format.json { render :show, status: :created, location: @counter }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @counter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /counters/1 or /counters/1.json
  def update
    respond_to do |format|
      if @counter.update(counter_params)
        format.html { redirect_to counters_path, notice: "Counter was successfully updated." }
        format.json { render :show, status: :ok, location: @counter }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @counter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /counters/1 or /counters/1.json
  def destroy
    @counter.destroy!

    respond_to do |format|
      format.html { redirect_to counters_path, status: :see_other, notice: "Counter was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_counter
      @counter = Counter.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def counter_params
      params.expect(counter: [ :user_id, :title, :emoji, :amount, :color, :goal ])
    end
end
