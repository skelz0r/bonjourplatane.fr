require 'date'
require 'liquid'

require 'human_first_name'
require 'get_platane_image'
require 'get_image_owner'

class GeneratePlatanePost
  attr_reader :date,
    :interactive

  def initialize(date, interactive: false)
    @date = date
    @interactive = interactive
  end

  def perform
    download_image
    create_post
    change_today_files
  end

  def download_image
    File.open(final_image_path, 'w') { |f| f.write(URI.parse(platane_image['photo_url']).read) }
  end

  def create_post
    template = Liquid::Template.parse(File.read(post_template))
    variables = {
      'title' => first_name,
      'date' => date.to_time.to_s,
      'date_formatted' => date_formatted,
      'user_name' => image_owner['username'],
      'user_profile_url' => image_owner['url']
    }
    rendered_template = template.render(variables)

    File.open(final_post_path, 'w') { |f| f.write(rendered_template) }
  end

  def change_today_files
    write_today_file(
      first_name,
      'today_name.html'
    )

    write_today_file(
      "![#{first_name}](/images/#{date_formatted}.jpg)\n\nCrédits: [#{image_owner['username']}](#{image_owner['url']}) on flickr",
      'today_image.md'
    )
  end

  private

  def write_today_file(content, file_name)
    File.open(file_path("../_includes/#{file_name}"), 'w') { |f| f.write(content) }
  end

  def post_template
    file_path(
      '../templates/post.md'
    )
  end

  def final_image_path
    file_path(
      "../images/#{final_image_name}"
    )
  end

  def final_image_name
    "#{date_formatted}.jpg"
  end

  def final_post_path
    file_path(
      "../_posts/#{date_formatted}-#{sanitize_string(first_name)}.md",
    )
  end

  def sanitize_string(string)
    string
      .gsub(/^.*(\\|\/)/, '')
      .gsub(/[éèê]/, 'e')
      .gsub(/[^0-9A-Za-z.\-]/, '_')
      .downcase
  end

  def file_path(path)
    File.expand_path(
      File.join(
        File.dirname(__FILE__),
        path
      )
    )
  end

  def date_formatted
    date.strftime('%Y-%m-%d')
  end

  def image_owner
    @image_owner ||= GetImageOwner.new(platane_image['user_id']).perform
  end

  def platane_image
    @platane_image ||= GetPlataneImage.new(interactive: interactive).perform
  end

  def first_name
    @first_name ||= HumanFirstName.new(date).get
  end
end
