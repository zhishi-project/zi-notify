class NewsletterController < ApplicationController
  def receive
    mail_questions = []
    questions.each do |question|
      mail_questions << question
    end

    newsletter = {}
    newsletter[:mail_questions] = mail_questions
    newsletter[:zhishi_url] = "https://zhishi.andela.com"
    send_mail(newsletter)
  end

  def send_mail(newsletter)
    mail_params = {}
    mail_params[:subject] = "Zhishi Weekly Newsletter"
    mail_params[:body] = EmailWrapper::NewsletterDesigner.format_content(newsletter)  
    failed_mails = []
    emails.each do |email|
      begin
        NewsletterMailer.notify_by_mail(mail_params, to: email).deliver
      rescue
        failed_mails << email
      end
    end

    p failed_mails
  end

  def emails
    ["chinedu.daniel@andela.com", "innocent.amadi@andela.co", "bodunde.adebiyi@andela.com", "kehinde.ogunde@andela.com", "akinjide.bankole@andela.co", "ebun@andela.com", "e@andela.co", "adeleke.togun@andela.co", "divya.gunasekaran@andela.com", "amos.omondi@andela.com", "chidi.nnadi@andela.co", "brian.busolo@andela.com", "chris.acea@andela.com", "oladipupo.isola@andela.com", "brian.mosigisi@andela.com", "emeka.ashikodi@andela.com", "adimoranma.felix@andela.com", "adebayo.maborukoje@andela.com", "brice@andela.co", "blessing.orazulume@andela.co", "ademola.raimi@andela.com", "akonam.ikpelue@andela.com", "deborah.enomah@andela.co", "ikem.okonkwo@andela.co", "austin.kabiru@andela.com", "andrei.erdoss@andela.com", "collin.mutembei@andela.com", "mel.michael@andela.com", "aliyu.abdullahi@andela.co", "chijioke.ndubisi@andela.co", "atolagbe.bisoye@andela.com", "lisbi@andela.com", "cesar.rufo@andela.com", "brian.ngure@andela.com", "florence.okosun@andela.com", "ifeanyi.oraelosi@andela.com", "eric.gichuri@andela.com", "helen.eboagwu@andela.co", "faical.tchirou@andela.com", "daniel.okocha@andela.com", "eston.karumbi@andela.com", "george.james@andela.com", "damilola.omonori@andela.co", "thomas.nyambati@andela.com", "ajibola.sogbein@andela.co", "abimbola.idowu@andela.com", "oluwakamiye.adelemoni@andela.com", "eugene.mutai@andela.com", "ahmed.onawale@andela.co", "gbenga@andela.com", "evan.greenlowe@andela.co", "emmanuel.isaac@andela.co", "jolaade.adewale@andela.com", "gbolahan.okerayi@andela.com", "chiemeka.alim@andela.co", "olalekan.eyiowuawi@andela.com", "ibraheem.adeniyi@andela.com", "franklin.ugwu@andela.co", "femi.senjobi@andela.com", "herbert.kagumba@andela.com", "hannah.koske@andela.com", "jack.wachira@andela.com", "hassan.oyeboade@andela.com", "chibuzor.obiora@andela.com", "joan.ngatia@andela.com", "bukola.omotoso@andela.com", "japheth.obala@andela.com", "godson.ukpere@andela.com", "jay.greenbaum@andela.com", "jeremy@andela.co", "jason.block@andela.com", "mayowa.pitan@andela.com", "adebayo.adepoju@andela.com", "kevin.ndungu@andela.com", "olalekan.sogunle@andela.co", "james.ndiga@andela.com", "issa.jubril@andela.com", "olajide.aderibigbe@andela.co", "anthony.nandaa@andela.com", "bukola.makinwa@andela.com", "tosin.adesanya@andela.co", "kosy.anyanwu@andela.co", "mayowa.falade@andela.co", "alex.mwaleh@andela.com", "oduye.oluwayemisi@andela.com", "kayode.adeniyi@andela.co", "temitope.olotin@andela.com", "kinuthia.ndungu@andela.com", "john.kariuki@andela.com", "obioma.ofoamalu@andela.com", "mirabel.ekwenugo@andela.co", "kolawole.erinoso@andela.co", "maryam.babalola@andela.com", "olufunmilade.oshodi@andela.com", "oluwadamilola.adebayo@andela.co", "olaide.ojewale@andela.com", "modupe.durosinmi-etti@andela.com", "matt.heider@andela.co", "kuti.gbolahan@andela.com", "olaide.agboola@andela.co", "oreoluwa.akinniranye@andela.co", "osmond.oranagwa@andela.com", "surajudeen.akande@andela.com", "tobi.oduah@andela.com", "michael.rosenberg@andela.co", "oluwaseun.martins@andela.co", "adeyemi.adesanya@andela.com", "simon.peter@andela.com", "stephen.sunday@andela.co", "olumuyiwa.osiname@andela.com", "paul.dariye@andela.com", "priscilla.ekhator@andela.com", "stephen.oduntan@andela.com", "prosper.otemuyiwa@andela.co", "stanley.ndagi@andela.com", "rowland.ekemezie@andela.com", "rukayat.sadiq@andela.com", "sunday.adefila@andela.co", "dotun.owoade@andela.com", "amodu.temitope@andela.com", "dara.oladosu@andela.com", "oyebanji.jacob@andela.com", "terwase.gberikon@andela.co", "olarewaju.oreoluwa@andela.co", "talabi.oluwaseyi@andela.com", "humphrey.thuo@andela.com", "iyanu.durotola@andela.co", "oladele.oluwatoyin@andela.com", "susan.esho@andela.com", "temilade.ojuade@andela.com", "people-intern@andela.com", "robert.opiyo@andela.com", "godwin.onisofien@andela.com", "oluwatoni.sodara@andela.co", "taiwo.judah-ajayi@andela.com", "chijioke.elisha-wigwe@andela.com", "yetunde.sanni@andela.co", "seyi.adekoya@andela.com", "tijesunimi.peters@andela.com", "blessing.ebowe@andela.com", "yusuf.daniju@andela.com", "hassan.ayomon@andela.com", "samuel.james@andela.com", "waleola.akinsanmi@andela.com", "abdulmalik.yusuf@andela.com", "edwin.kupara@andela.com", "chidozie.ijeomah@andela.com", "emmanuel.chigbo@andela.com", "uzo.awili@andela.com", "eniola.arinde@andela.com", "nadayar@andela.co", "bello.babajide@andela.com", "gertrude.nyenyeshi@andela.com", "chris.vundi@andela.com", "sunday.nwuguru@andela.com", "roberto.goizueta@andela.com", "oni.omowunmi@andela.co", "tolulope.komolafe@andela.com", "udo.nkwocha@andela.com", "chidiebere.nwokocha@andela.com", "achile.egbunu@andela.com", "verem.dugeri@andela.co", "alex.obogbare@andela.com", "emmanuel.akinyele@andela.com", "daniel.james@andela.com", "scott.carleton@andela.com", "penina.wanjiru@andela.com", "joshua.mwaniki@andela.co", "lovelyn.tijesunimi-israel@andela.com", "james.muturi@andela.com", "abiodun.shuaib@andela.com"]
  end

  def questions
    [
      OpenStruct.new({
        asked_by: "Seyi Adekoya",
        image: "https://lh3.googleusercontent.com/-TmaBMhYx8mU/AAAAAAAAAAI/AAAAAAAAABg/clWfb3kLxZc/photo.jpg",
        title: "Where can I study JavaScript source code",
        content: "<p>If I want to view Ruby's source code I can go to <a href=\"http://github.com/ruby/ruby\">http://github.com/ruby/ruby</a>&nbsp;but for JavaScript there seems to be nothing like that.</p>".gsub(/<(?:.|\n)*?>/, ''),
        url: "https://zhishi.andela.com/questions/102",
        user_url: "https://zhishi.andela.com/users/90-"
      }),
      OpenStruct.new({
        asked_by: "Amodu Temitope",
        image: "https://lh6.googleusercontent.com/-0FvJsatjem8/AAAAAAAAAAI/AAAAAAAAAA0/4M9yUeAGheA/photo.jpg",
        title: "Is there a recommended format for writing the skilltree biography?",
        content: "<div data-reactid=\".0.0.1.0.0.0.1.0.0.1.0.1.1.0\">\n<div data-reactid=\".0.0.0.1.0.0.1.0.1.1.0\">\n<p>I noticed the \"Bio\" section of skilltree with different people using different approaches to write theirs, and I was wondering if there is a recommended format for it.</p>\n</div>\n</div>".gsub(/<(?:.|\n)*?>/, ''),
        url: "https://zhishi.andela.com/questions/37",
        user_url: "https://zhishi.andela.com/users/32-"
      }),
      OpenStruct.new({
        asked_by: "Adebayo Adepoju",
        image: "https://lh5.googleusercontent.com/-P0_NF5qwOc0/AAAAAAAAAAI/AAAAAAAAADw/dP_D_ZTdRXw/photo.jpg",
        title: "Why is asking questions on Zhishi better than asking an individual on slack?",
        content: "<div data-reactid=\".0.0.1.0.0.0.1.0.0.1.0.1.1.0\">\n<p>I would like to know why we advise Andelans&nbsp;to use Zhishi instead&nbsp;of just reaching out to anyone on slack.</p>\n</div>".gsub(/<(?:.|\n)*?>/, ''),
        url: "https://zhishi.andela.com/questions/112",
        user_url: "https://zhishi.andela.com/users/5-"
      }),
      OpenStruct.new({
        asked_by: "Seyi Adekoya",
        image: "https://lh3.googleusercontent.com/-TmaBMhYx8mU/AAAAAAAAAAI/AAAAAAAAABg/clWfb3kLxZc/photo.jpg",
        title: "Is Andela still considered a startup?",
        content: "<p>Is Andela still considered a startup?</p>".gsub(/<(?:.|\n)*?>/, ''),
        url: "https://zhishi.andela.com/questions/100",
        user_url: "https://zhishi.andela.com/users/90-"
      }),
      OpenStruct.new({
        asked_by: "Amodu Temitope",
        image: "https://lh6.googleusercontent.com/-0FvJsatjem8/AAAAAAAAAAI/AAAAAAAAAA0/4M9yUeAGheA/photo.jpg",
        title: "Is it possible for you to have your leave request be rejected?",
        content: "<p>Is it possible to have your leave request rejected? If yes, what are the possible reasons for the rejection.&nbsp;</p>".gsub(/<(?:.|\n)*?>/, ''),
        url: "https://zhishi.andela.com/questions/63",
        user_url: "https://zhishi.andela.com/users/32-"
      })
    ]
  end
end