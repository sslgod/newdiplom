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
              redirect_to cabinet_path
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
              redirect_to cabinet_path
            end
          end

          def create?(model)
            model.save
          end
    
  def cabinet
    @user=User.find(current_user.id)
    @cabinet_plans=@user.kplans.all
  end

  def kp_titl
    id=params[:id]
    user=current_user.id
    if id.nil?
      id=plan_new(user)
    else
      id=plan_copy(id, user)
    end
    @ktitle=Ktitl.find_by_kplan_id(id)
  end

      def plan_copy(plan_id, user_id)
        plan=Kplan.new(user_id:user_id, predmet_comissia:User.find(user_id).predmet_comissia)
        plan.save
        new_id=plan.id
        title=Ktitl.find_by_kplan_id(plan_id).dup
        title.kplan_id=new_id
        title.save
        lib=Klit.find_by_kplan_id(plan_id).dup
        lib.kplan_id=new_id
        lib.save
        body=Kbody.where("kplan_id=?", plan_id)
        body.each do |page|
          newpage=page.dup
          newpage.kplan_id=new_id
          newpage.save
        end
        new_id
      end

      def plan_new(user_id)
        plan=Kplan.new(user_id:user_id, predmet_comissia:User.find(user_id).predmet_comissia)
        plan.save
        new_id=plan.id
        title=Ktitl.new(kplan_id:new_id)
        title.save
        lib=Klit.new(kplan_id:new_id)
        lib.save
        body=Kbody.new(kplan_id:new_id)
        body.save
        new_id
       end

      def save_title
        plan_title=Ktitl.find_by_kplan_id(params[:ktitle][:kplan_id])
        if plan_title.nil?
          plan_title=Ktitl.new(kplan_id:params[:ktitle][:kplan_id])
        end
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
    id=params[:id]
    @klib=Klit.find_by_kplan_id(id)
    @error_messages=""
  end

      def save_lib
        plan_id=params[:klib][:kplan_id].to_i
        lib=Klit.find_by_kplan_id(plan_id)
        if lib.nil?
          lib=Ktitl.new(kplan_id:params[:klib][:kplan_id])
        end
        (1..24).each do |str|
          lib["literatura#{str}"]=params[:klib]["literatura#{str}"]
        end
        lib.save
        redirect_to body_path(:id=>plan_id)
      end


  def kp_body
    id=params[:id]
    @kbody=Kbody.where("kplan_id=?", id)
    @page_count= @kbody.empty? ? 0 : @kbody.maximum("nomer_page")
  end

    def save_body
    end

    def delete_body
    end

  def kp_view 
    id=params[:id]
    @title=Ktitl.find_by_kplan_id(id)
        # => @ktitle["ch_all"]=@ktitle.ch_zan.to_i + @ktitle.ch_labrab.to_i + @ktitle.ch_kprtk.to_i
    @body=Kbody.where("kplan_id=?", id)
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
        a=Kplan.new(user_id:1)
        a.save
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
        a=Klit.new
        a.kplan_id=1
        (1..20).each do |i|
          if i.odd?
            a["literatura#{i}"]="Описание источника из которого был взят для материала лекций"
          else
            a=Klit.new
            a["literatura#{i}"]="продолжение описание литературы, которое не уместилось в первую строку"
          end
        end
        a.save

    b=0
    (1..5).each do |str|
      a=Kbody.new(kplan_id:1, nomer_page:str)
      (1..26).each do |i|
        if i.odd?
            b=b+1
            a["nomer_uroka#{i}"]="#{b}"
            a["tema_zaniatia#{i}"]="#{str} - #{i} - #{a["nomer_uroka#{i}"]} Здесь написана тема занятия - первая строка"
            a["nomer_nedeli#{i}"]=b/2+1
            a["kolvo_chasov#{i}"]=rand((3)+1)*2
            a["vid_zaniatia#{i}"]="Вид занятия #{str}-#{i}"
            a["nagl_posobie#{i}"]="Наглядное посо-"
            a["zadano#{i}"]="Задано студен-"
            c=rand(2)*2
            if c>0
              a["samrab_casov#{i}"]=c.to_s
              a["samrab_zadanie#{i}"]="Задание для са-"
            else
              a["samrab_casov#{i}"]=""
              a["samrab_zadanie#{i}"]=""
            end
        else
            a["nomer_uroka#{i}"]=""
            a["tema_zaniatia#{i}"]="а дальше идет вторая строка текста, продолжение #{str} - #{i}"
            a["nomer_nedeli#{i}"]=""
            a["kolvo_chasov#{i}"]=""
            a["vid_zaniatia#{i}"]=""
            a["nagl_posobie#{i}"]="бие для #{str} - #{i}"
            a["zadano#{i}"]="там надом #{str} - #{i}"
            a["samrab_casov#{i}"]=""
            if i>1
              if a["samrab_zadanie#{i-1}"].empty?
                a["samrab_zadanie#{i}"]=""
              else
                a["samrab_zadanie#{i}"]="мостоятельной#{i}"
              end
            end
        end
        a.save
      end
    end

      end

  
end



