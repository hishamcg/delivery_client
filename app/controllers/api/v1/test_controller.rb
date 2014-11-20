class Api::V1::TestController <  ApplicationController
  respond_to :json,:xml

  def chat
    # hash = {}
    # hash[:contacts] = [{:name => "Pollo", :number => "1234"}
    #                     {:name => "ahmed", :number => "123445"}]
    # hash[:message] = [{:name => "Pollo", :number => "1234", :message => "hello bro", :time => "12:30"}
    #                     {:name => "ahmed", :number => "123445", :message => "im fine macha", :time => "12:31"}]
    render :json => {:success => true,
                     :chat_id => "1234",
                     :contacts => [{:name => "Pollo", :number => "1234"},{:name => "ahmed", :number => "123445"}],
                     :message => [{:name => "Pollo", :number => "1234", :message => "hello bro", :time => "12:30"},
                      {:name => "ahmed", :number => "123445", :message => "im fine macha", :time => "12:31"},
                      {:name => "ahmed", :number => "123445", :message => "dai ennada", :time => "12:32"},
                      {:name => "Pollo", :number => "1234", :message => "hello bro", :time => "12:30"},
                      {:name => "Pollo", :number => "1234", :message => "aksdh bro", :time => "12:30"},
                      {:name => "Pollo", :number => "1234", :message => "aksdh bro", :time => "12:30"}]
                    }
  end

  def chats
    hash = {}
    hash[:contacts] = [{:name => "Pollo", :no => "1234"}]
    render :json => hash
  end


end
