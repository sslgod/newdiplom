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
            user = User.authenticate(params[:session][:nik], params[:session][:pas])
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
            @cabinet_plans=@user.kplans.all
          end

          def create?(model)
            model.save
          end
    
  def kp_titl
    id=params[:id]
    user=User.find(current_user.id)
    @ktitle=Ktitl.find_by_kplan_id(id)
#    kplan = user.kplans.new
#      kplan.predmet_comissia=user.predmet_comissia
#      kplan.save
#    if id.to_i==0
#      @ktitle=Ktitl.new
#      @ktitle.kplan_id=kplan.id
#    else
#      @ktitle=Ktitl.find_by_kplan_id(id)
#      ktitle_new=Ktitl.new
#      ktitle_old=Ktitl.find_by_kplan_id(id) #фиг знает, как это сделать по-другому
#          ktitle_new.kplan_id=kplan.id
#          ktitle_new.pregmet=ktitle_old.pregmet 
#          ktitle_new.spec=ktitle_old.spec 
#          ktitle_new.group=ktitle_old.group 
#          ktitle_new.kurs=ktitle_old.kurs 
#          ktitle_new.semestr=ktitle_old.semestr 
#          ktitle_new.god=ktitle_old.god 
#          ktitle_new.uchregd=ktitle_old.uchregd 
#          ktitle_new.ch_ned=ktitle_old.ch_ned 
#          ktitle_new.ch_zan=ktitle_old.ch_zan 
#          ktitle_new.ch_labrab=ktitle_old.ch_labrab 
#          ktitle_new.ch_kprtk=ktitle_old.ch_kprtk 
#          ktitle_new.ch_smr=ktitle_old.ch_smr
#        ktitle_new.save
 #     Klit.where("kplan_id=?", id).each do |klit_old|
 #       klit_new=Klit.new
#        klit_new=klit_old
#        klit_new.kplan_id=kplan.id
#        klit_new.nomer_srt=klit_old.nomer_srt
#        klit_new.literatura=klit_old.literatura
#        klit_new.save
#      end
#      Kbody.where("kplan_id=?", id).each do |kbody_old|
#        kbody_new=Kbody.new
#        kbody_new.kplan_id=kplan.id
#        kbody_new.nomer_page=kbody_old.nomer_page
#        kbody_new.nomer_str=kbody_old.nomer_str
#        kbody_new.nomer_uroka=kbody_old.nomer_uroka
#        kbody_new.tema_zaniatia=kbody_old.tema_zaniatia
#        kbody_new.nomer_nedeli=kbody_old.nomer_nedeli
#        kbody_new.kolvo_chasov=kbody_old.kolvo_chasov
#        kbody_new.vid_zaniatia=kbody_old.vid_zaniatia
#        kbody_new.nagl_posobie=kbody_old.nagl_posobie
#        kbody_new.zadano=kbody_old.zadano
#        kbody_new.samrab_casov=kbody_old.samrab_casov
#        kbody_new.samrab_zadanie=kbody_old.samrab_zadanie
#        kbody_new.save
#      end    
#    end
    @ktitle["ch_all"]=@ktitle.ch_zan.to_i + @ktitle.ch_labrab.to_i + @ktitle.ch_kprtk.to_i
  end

      def save_title
        plan_title=Ktitl.find_by_kplan_id(params[:ktitle][:kplan_id])
        plan_title.pregmet=params[:ktitle][:pregmet]
        plan_title.spec=params[:ktitle][:spec]
        plan_title.group=params[:ktitle][:group]
        plan_title.kurs=params[:ktitle][:kurs]
        plan_title.semestr=params[:ktitle][:semestr]
        plan_title.god=params[:ktitle][:god]
        plan_title.uchregd=params[:ktitle][:uchregd]
        plan_title.ch_ned=params[:ktitle][:ch_ned].to_i
        plan_title.ch_zan=params[:ktitle][:ch_zan].to_i
        plan_title.ch_labrab=params[:ktitle][:ch_labrab].to_i
        plan_title.ch_kprtk=params[:ktitle][:ch_kprtk].to_i
        plan_title.ch_smr=params[:ktitle][:ch_smr].to_i
        plan_title.save
        redirect_to lib_path(:id=>(params[:ktitle][:kplan_id]).to_i)
      end

  def kp_lit
    @id=params[:id]
    klib=Klit.where("kplan_id=?", @id)
    @klib_mas=Array.new
    (1..24).each do |nomer_str|
      str=klib.where("nomer_srt=?", nomer_str).first
      @klib_mas<<(str.nil? ? Klit.new : str )
    end
    @error_messages=""
  end

      def save_lib
        plan_id=params[:id].to_i
        (1..24).each do |lib|
          one_lib=Klit.new
          one_lib=Klit.find_by_nomer_srt_and_kplan_id(lib, plan_id)
          one_lib=Klit.new(:kplan_id=>plan_id, :nomer_srt=>lib) if one_lib.nil?
          one_lib.literatura=params["klib#{lib}"]
          one_lib.save
        end
        redirect_to body_path(:id=>plan_id)
      end


  def kp_body
    id=params[:id]
    @kbody=Kbody.where("kplan_id=?", id)
    @page_count= @kbody.empty? ? 0 : @page_count=@kbody.maximum("nomer_page")
  end

  def kp_view 
    id=params[:id]
    @title=Ktitl.find_by_kplan_id(id)
    @body=Kbody.find_by_kplan_id(id)
    @lib=Klit.find_by_kplan_id(id)
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

      def test_db #Заполнение бд тестовой инфой
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



