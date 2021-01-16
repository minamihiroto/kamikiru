class CardController < ApplicationController

  require "payjp"

  def new
    card = Card.where(user: current_user.id)
    redirect_to action: "show" if card.exists?
  end

  def pay
    Payjp.api_key = Rails.application.credentials.payjp[:private_key]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      description: '登録テスト',
      email: current_user.email,
      card: params['payjp-token'],
      metadata: {user: current_user.id}
      ) #念の為metadataにuserを入れましたがなくてもOK
      @card = Card.new(user: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "show"
      else
        redirect_to action: "pay"
      end
    end
  end

  def delete #PayjpとCardデータベースを削除します
    card = Card.where(user: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = Rails.application.credentials.payjp[:private_key]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to action: "new"
  end

  def show #Cardのデータpayjpに送り情報を取り出します
    card = Card.where(user: current_user.id).first
    if card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = Rails.application.credentials.payjp[:private_key]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end
end
