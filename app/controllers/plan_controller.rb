#encoding: utf-8

class PlanController < ApplicationController
  def index
    if signed_in?
     redirect_to cabinet_path
    else
    @user=User.new
    end
  end
  
  def createuser  #создание пользователя
    @user = User.new(params[:user])
    if @user.save
      render 'index'
    else
      render 'index'
    end

  end
  
    
  def createsession #создание сессии при входе пользователя
    user = User.authenticate(params[:session][:nik],
                           params[:session][:pas])
      if user.nil?
    flash.now[:error] = "Invalid email/password combination."
      render 'new'
      else
      sign_in user
      render 'index'
      end
  end

  def cabinet
    @user=User.find(current_user.id)
    @cabinet_plans=@user.kplans.find(:all)
  end
  
 # def createtitle
 #  
 #     @ktitle = @kplan.ktitls.new(params[:ktitle])
 #     if @ktitle.save
 #       kp_body(@ktitle.id)
 #     else
 #       @error = "Что-то пошло не так, и сохранить не удалось."
 #       render kp_titl
 #     end  
 # end
  
  def create?(model)
    model.save
  end

  def kp_titl
    @step = 1
    @user=User.find_by_id(current_user.id)
    @kplan = @user.kplans.new(:predmet_comissia => @user.predmet_comissia)
    
    @ktitle= @kplan.ktitls.new
    @ktitle['user']= @user.name 
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

  def prasing_lib
  end

  def test_db
    b=1
    a=Ktitl.new
      a.kplan_id=1
      a.pregmet="Очень длинное нзвание предмета, которое не уместилось в одну строку"
      a.spec="230105"
      a.group="244, 245"
      a.kurs="III"
      a.semestr="3"
      a.god="2012"
      a.uchregd="Методическим советом СПКВТК"
      a.ch_ned=17
      a.ch_zan=40
      a.ch_labrab=20
      a.ch_kprtk=12
      a.ch_smr=20
    a.save
    (1..20).each do |i|
      if i.odd?
        a=Klit.new
        a.kplan_id=1
        a.nomer_srt=i
        a.literatura="Описание источника из которого был взят для материала лекций"
        a.save
      else
        a=Klit.new
        a.kplan_id=1
        a.nomer_srt=i
        a.literatura="продолжение описание литературы, которое не уместилось в первую строку"
        a.save
      end
    end
    Kbody.all.each do |a|
      if a.nomer_str.odd?
        a.nomer_uroka=b+(a.nomer_str/2)+a.nomer_page-1
        a.tema_zaniatia="#{a.nomer_page} - #{a.nomer_str} - #{a.nomer_uroka} Здесь написана тема занятия - первая строка"
        a.nomer_nedeli=a.nomer_uroka/2+1
        a.kolvo_chasov=rand((3)+1)*2
        a.vid_zaniatia="Вид занятия #{a.nomer_page}#{a.nomer_str}"
        a.nagl_posobie="Наглядное посо-"
        a.zadano="Задано студен-"
        c=rand(2)*2
        if c>0
          a.samrab_casov=c.to_s
          a.samrab_zadanie="Задание для са-"
        else
          a.samrab_casov=""
          a.samrab_zadanie=""
        end
      else
        a.nomer_uroka=""
        a.tema_zaniatia="а дальше идет вторая строка текста, продолжение #{a.nomer_page} - #{a.nomer_str}"
        a.nomer_nedeli=""
        a.kolvo_chasov=""
        a.vid_zaniatia=""
        a.nagl_posobie="бие для #{a.nomer_page} - #{a.nomer_str}"
        a.zadano="там надом #{a.nomer_page} - #{a.nomer_str}"
        a.samrab_casov=""
        c=Kbody.where("nomer_page =?", a.nomer_page).find_by_nomer_str(a.nomer_str-1).samrab_casov
        if c.empty?
          a.samrab_zadanie=""
        else
          a.samrab_zadanie="мостоятельной#{a.nomer_str}"
        end
      end
      a.save
    end
  end

  
end



