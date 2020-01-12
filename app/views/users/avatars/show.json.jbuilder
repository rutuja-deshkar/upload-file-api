json.extract! @user, :id, :email
json.files @user.files do |file|
  json.id file.blob_id
  json.url url_for(file)
end
