require 'open-uri'
module FedoraHelper
[...]
  def fedora_check_rights(pid, permission)
    d = ODRL::Rights::Document.new
    d.doc = open('http://my.fedora.repository:8080/fedora/get/' + pid + '/Rights')
    d.eval permission, {}, current_user, {}
  end
  def render_fedora_partial(pid, cmodel)
    begin
      fedora_check_rights pid, 'play'
      render :partial=>"fedora/_show_partials/#{cmodel}", :locals=>{:fedora_object=>pid}
    rescue ODRL::Rights::InsufficientPrivileges
      render :partial => "fedora/_show_partials/odrl_rights_insufficientprivileges", :locals=>{:fedora_object=>pid}
    end
  end
[...]
end
