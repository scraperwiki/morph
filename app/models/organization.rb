# Using American spelling to match GitHub usage
class Organization < Owner
  # TODO rename this to members
  has_and_belongs_to_many :users, join_table: :organizations_users

  def user?
    false
  end

  def organization?
    true
  end

  def self.find_or_create(uid, nickname)
    org = Organization.find_by(uid: uid)
    if org.nil?
      # Get more information for that organisation
      data = Octokit.organization(nickname)
      org = Organization.create(uid: uid, nickname: nickname, name: data.name, blog: data.blog, company: data.company,
        email: data.email, gravatar_url: data.rels[:avatar].href)
    end
    org
  end

  def organizations
    []
  end

  # All organizations that have scrapers
  def self.all_with_scrapers
    Organization.includes(:scrapers).select{|u| !u.scrapers.empty?}
  end
end
