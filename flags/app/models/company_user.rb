class CompanyUser < ApplicationRecord
    belongs_to :company
    belongs_to :user

    before_validation :set_user_id, if: :email?

    attribute :email, :string

    def set_user_id
        self.user = User.invite!(email: email)
    end

end

