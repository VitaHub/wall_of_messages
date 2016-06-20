
unless User.find_by(name: "Good Guy")
	user = User.create!(
		name: "Good Guy",
		email: "good_guy@mail.com",
		password: "neverguess123"
	)

	30.times do
		message = user.messages.create!(
			body: "#{Faker::Hipster.sentence}"
		)

		comment = message.comments.build(
			body: "#{Faker::Hipster.sentence(3)}"
		)
		comment.user_id = user.id
		comment.save
	end
end

