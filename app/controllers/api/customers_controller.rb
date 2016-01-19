class Api::CustomersController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                    :if => Proc.new { |c| c.request.format == 'application/json' }

  respond_to :json

  def first_step
    customer = Customer.new(permitted_params_for_first_step[:customer])
    if @customer.valid?
      customer.save!
      render :status => 200,
             :json => { success: true, customer: customer }
    else
      render :status => 200,
             :json => { success: false , message: customer.errors.full_messages }
    end
  end

  def second_step
    customer = Customer.find_by_id(params[:id])
    if permitted_params_for_second_step[:customer][:email] && permitted_params_for_second_step[:customer][:dni]
      if customer.update_attributes!(permitted_params_for_second_step[:customer])
        render :status => 200,
               :json => { success: true, customer: customer }
      else
        render :status => 200,
               :json => { success: false, message: customer.errors.full_messages }
      end
    else
      render :status => 200,
             :json => { success: false, message: "Email and DNI should not be empty" }
    end
  end

  def final_step
    customer = Customer.find_by_id(params[:id])
    if customer.update_attributes(permitted_params_for_final_step[:customer])
      render :status => 200,
             :json => { success: true, customer: customer }
    else
      render :status => 200,
             :json => { success: false, message: customer.errors.full_messages }
    end
  end

  private

  def permitted_params_for_first_step
    { customer:
        params.fetch(:customer, {}).permit(:sum, :days)}
  end

  def permitted_params_for_second_step
    { customer:
        params.fetch(:customer, {}).permit(:email, :dni)}
  end

  def permitted_params_for_final_step
    { customer:
        params.fetch(:customer, {}).permit(:phone_number)}
  end
    #curl -v -H 'Content-Type: application/json' -H 'Accept: application/json' -X POST http://localhost:3000/api/first_step -d "{\"customer\":{\"sum\":\"222\", \"days\":\"111\"}}"
    #curl -v -H 'Content-Type: application/json' -H 'Accept: application/json' -X PATCH http://localhost:3000/api/second_step -d "{\"id\":\"2\",\"customer\":{\"email\":\"some@email.com\", \"dni\":\"111\"}}"
    #curl -v -H 'Content-Type: application/json' -H 'Accept: application/json' -X PATCH http://localhost:3000/api/final_step -d "{\"id\":\"2\",\"customer\":{\"phone_number\":\"213413234\"}}"
end
