json.extract! @user, :id, :email
json.success true

# no need to show all files in create, user can get all hhis files with show message
# json.files @user.files do |file|
#   json.id file.blob_id
#   json.url url_for(file)
# end
