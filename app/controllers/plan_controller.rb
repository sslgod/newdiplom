#encoding: utf-8

class PlanController < ApplicationController
  def index
    
    if signed_in?
     redirect_to cabinet_path
    else
    @user=User.new
    respond_to do |format|
      format.html 
      format.js 
    end
    end
  end
  
  def createuser  #создание пользователя
    
    @user = User.new(params[:user])
    if @user.save
      render 'index'
    else
      @title = "Sign up"
      render 'index'
    end

  end
  
    
  def createsession #создание сессии при входе пользователя
    user = User.authenticate(params[:session][:nik],
                           params[:session][:pas])
      if user.nil?
    flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render 'new'
      else
      sign_in user
      render 'index'
      end
end

  def cabinet
    @user=User.find_by_id(current_user.id) # это заглушка, сдесь данные текущего пользователя
    @cabinet_plans=@user.kplans.find(:all)
  end
  
  def createtitle
   
      @ktitle = @kplan.ktitls.new(params[:ktitle])
      if @ktitle.save
        kp_body(@ktitle.id)
      else
        @error = "Что-то пошло не так, и сохранить не удалось."
        render kp_titl
      end
    
    
  end
  def create?(model)
    model.save
  end

  def kp_titl
    @step = 1
    @user=User.find_by_id(current_user.id)
    @kplan = @user.kplans.new(:predmet_comissia => @user.predmet_comissia)
    
    @ktitle= @kplan.ktitls.new
    @ktitle['user']= @user.name   #это заглушки, сдесь данные текущего пользователя
    @ktitle["ch_all"]=@ktitle.ch_zan.to_i + @ktitle.ch_labrab.to_i + @ktitle.ch_kprtk.to_i
    
  
  end

  def kp_lit
    @klib=Klit.where("kplan_id=?", params[:id])
    @klib_new=Array.new(24) { Klit.new }
  end

  def kp_body(id)
    @kbody=Kbody.where("kplan_id=?", 1)
    @kbody_new=Array.new(26) { Kbody.new }
    @page_count= @kbody.empty? ? 0 : @page_count=@kbody.maximum("nomer_page")
  end

  def kp_print
    kplan_toprint=Kplan.find(params[:id])
      @ktitle=kplan_toprint.ktitl
        @ktitle["user"]=kplan_toprint.user.name
        @ktitle["ch_all"]=@ktitle.ch_zan.to_i + @ktitle.ch_labrab.to_i + @ktitle.ch_kprtk.to_i
      @klib=kplan_toprint.klit
      @kbody=kplan_toprint.kbody
      @kbody_0=Kbody.new
    pages_real=Kbody.where("kplan_id=?", params[:id]).maximum("nomer_page")
    pages_need= pages_real + (pages_real.even? ? 0 : 1 )
    @print_first=[]
    @print_second=[]
    range=pages_need/2-1
    range.times do |numb_srt|
      @print_first<<[((pages_need-numb_srt)>pages_real ? 0 : pages_need-numb_srt), numb_srt+2]
    end
    range=pages_need/2
    range.times do |numb_srt|
      @print_second<<[numb_srt+2, ((pages_need-numb_srt)>pages_real ? 0 :  pages_need-numb_srt)]
    end
  end

  
end



