# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141119191342) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "avatars", force: true do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.string   "direct_upload_url"
    t.boolean  "processed",          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "avatars", ["imageable_id", "imageable_type"], name: "index_avatars_on_imageable_id_and_imageable_type", using: :btree

  create_table "brand_identities", id: false, force: true do |t|
    t.integer "brand_id",    null: false
    t.integer "identity_id", null: false
  end

  add_index "brand_identities", ["brand_id", "identity_id"], name: "index_brand_identities_on_brand_id_and_identity_id", using: :btree
  add_index "brand_identities", ["identity_id", "brand_id"], name: "index_brand_identities_on_identity_id_and_brand_id", using: :btree

  create_table "brand_users", force: true do |t|
    t.integer  "brand_id"
    t.integer  "user_id"
    t.integer  "auth_level", default: 3
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "brand_users", ["brand_id"], name: "index_brand_users_on_brand_id", using: :btree
  add_index "brand_users", ["user_id"], name: "index_brand_users_on_user_id", using: :btree

  create_table "brands", force: true do |t|
    t.string   "company_name"
    t.string   "url"
    t.string   "snapchat"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "instagram"
    t.string   "google"
    t.string   "pinterest"
    t.string   "city"
    t.string   "state"
    t.string   "lat"
    t.string   "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "session_token"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  add_index "brands", ["session_token"], name: "index_brands_on_session_token", using: :btree

  create_table "campaign_previews", force: true do |t|
    t.integer  "campaign_id"
    t.string   "email"
    t.datetime "sent_at"
    t.string   "preview_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "campaign_previews", ["campaign_id"], name: "index_campaign_previews_on_campaign_id", using: :btree

  create_table "campaign_settings", force: true do |t|
    t.integer  "campaign_id"
    t.boolean  "notification_before_campaign_start_manager"
    t.boolean  "notification_before_campaign_start_all"
    t.boolean  "notification_after_campaign_start_manager"
    t.boolean  "notification_after_campaign_start_all"
    t.boolean  "notification_campaign_end_manager"
    t.boolean  "notification_campaign_end_all"
    t.boolean  "analytics_snap_expires_manager"
    t.boolean  "analytics_snap_expires_all"
    t.boolean  "analytics_campaign_end_manager"
    t.boolean  "analytics_campaign_end_all"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "campaign_settings", ["campaign_id"], name: "index_campaign_settings_on_campaign_id", using: :btree

  create_table "campaigns", force: true do |t|
    t.string   "name"
    t.integer  "manager_id"
    t.integer  "property_id"
    t.integer  "influencer_id"
    t.boolean  "approved",             default: false
    t.datetime "time_approved"
    t.datetime "time_scheduled"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "session_token"
    t.integer  "media_order",          default: [],    array: true
    t.string   "preview_file_name"
    t.string   "preview_content_type"
    t.integer  "preview_file_size"
    t.datetime "preview_updated_at"
    t.integer  "approver_id"
    t.string   "approver_type"
    t.string   "url_token"
    t.datetime "time_started"
    t.datetime "time_completed"
    t.boolean  "draft"
  end

  add_index "campaigns", ["approver_id", "approver_type"], name: "index_campaigns_on_approver_id_and_approver_type", using: :btree
  add_index "campaigns", ["influencer_id"], name: "index_campaigns_on_influencer_id", using: :btree
  add_index "campaigns", ["manager_id"], name: "index_campaigns_on_manager_id", using: :btree
  add_index "campaigns", ["property_id"], name: "index_campaigns_on_property_id", using: :btree
  add_index "campaigns", ["session_token"], name: "index_campaigns_on_session_token", using: :btree

  create_table "comment_tags", id: false, force: true do |t|
    t.integer "comment_id", null: false
    t.integer "tag_id",     null: false
  end

  add_index "comment_tags", ["comment_id", "tag_id"], name: "index_comment_tags_on_comment_id_and_tag_id", using: :btree
  add_index "comment_tags", ["tag_id", "comment_id"], name: "index_comment_tags_on_tag_id_and_comment_id", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "media_id"
    t.integer  "friend_id"
    t.string   "text"
    t.datetime "time_posted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["friend_id"], name: "index_comments_on_friend_id", using: :btree
  add_index "comments", ["media_id"], name: "index_comments_on_media_id", using: :btree

  create_table "contacts", force: true do |t|
    t.string   "full_name"
    t.string   "email"
    t.string   "snapchat"
    t.string   "avg_views"
    t.string   "company_name"
    t.string   "phone"
    t.string   "interest_as"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.string   "owner_type"
  end

  add_index "delayed_jobs", ["owner_id", "owner_type"], name: "index_delayed_jobs_on_owner_id_and_owner_type", using: :btree
  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "espinita_audits", force: true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.text     "audited_changes"
    t.string   "comment"
    t.integer  "version"
    t.string   "action"
    t.string   "remote_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "espinita_audits", ["auditable_id", "auditable_type"], name: "index_espinita_audits_on_auditable_id_and_auditable_type", using: :btree
  add_index "espinita_audits", ["user_id", "user_type"], name: "index_espinita_audits_on_user_id_and_user_type", using: :btree

  create_table "followercounts", force: true do |t|
    t.integer  "follower_count"
    t.datetime "checked_at"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "followercounts", ["identity_id"], name: "index_followercounts_on_identity_id", using: :btree

  create_table "frequency_periods", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friend_snaps", force: true do |t|
    t.integer  "friend_id",                     null: false
    t.integer  "snap_id",                       null: false
    t.boolean  "screenshotted", default: false
    t.boolean  "viewed",        default: false
    t.datetime "view_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friend_snaps", ["friend_id", "snap_id"], name: "index_friend_snaps_on_friend_id_and_snap_id", using: :btree
  add_index "friend_snaps", ["screenshotted"], name: "index_friend_snaps_on_screenshotted", using: :btree
  add_index "friend_snaps", ["snap_id", "friend_id"], name: "index_friend_snaps_on_snap_id_and_friend_id", using: :btree
  add_index "friend_snaps", ["view_time"], name: "index_friend_snaps_on_view_time", using: :btree

  create_table "friend_vines", id: false, force: true do |t|
    t.integer  "friend_id",  null: false
    t.integer  "vine_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friend_vines", ["friend_id", "vine_id"], name: "index_friend_vines_on_friend_id_and_vine_id", using: :btree
  add_index "friend_vines", ["vine_id", "friend_id"], name: "index_friend_vines_on_vine_id_and_friend_id", using: :btree

  create_table "friends", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "snapchat"
    t.string   "twitter"
    t.string   "vine"
    t.string   "facebook"
    t.string   "instagram"
    t.string   "lat"
    t.string   "lng"
    t.string   "referral_channel"
    t.integer  "age"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "referrer"
  end

  add_index "friends", ["referrer"], name: "index_friends_on_referrer", using: :btree
  add_index "friends", ["snapchat"], name: "index_friends_on_snapchat", using: :btree

  create_table "identities", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.string   "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_salt"
    t.string   "password_hash"
    t.string   "encrypted_password"
    t.string   "refresh_token"
    t.integer  "user_id"
  end

  add_index "identities", ["uid"], name: "index_identities_on_uid", using: :btree
  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "identity_friends", force: true do |t|
    t.integer  "identity_id"
    t.integer  "friend_id"
    t.datetime "time_added"
  end

  add_index "identity_friends", ["friend_id", "identity_id"], name: "index_identity_friends_on_friend_id_and_identity_id", unique: true, using: :btree
  add_index "identity_friends", ["identity_id", "friend_id"], name: "index_identity_friends_on_identity_id_and_friend_id", unique: true, using: :btree

  create_table "influencers", force: true do |t|
    t.string   "snapchat"
    t.string   "twitter"
    t.string   "instagram"
    t.string   "youtube"
    t.string   "facebook"
    t.string   "vine"
    t.string   "city"
    t.string   "state"
    t.string   "lat"
    t.string   "lng"
    t.string   "referral_channel"
    t.string   "primary_channel"
    t.datetime "birthday"
  end

  create_table "invitations", force: true do |t|
    t.integer  "inviter_id"
    t.string   "inviter_type"
    t.string   "recipient_email"
    t.string   "token"
    t.string   "auth_level"
    t.integer  "accessible_id"
    t.string   "accessible_type"
    t.boolean  "accepted",        default: false
    t.datetime "accepted_at"
    t.integer  "invited_id"
    t.string   "invited_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invitations", ["invited_id", "invited_type"], name: "index_invitations_on_invited_id_and_invited_type", using: :btree
  add_index "invitations", ["inviter_id", "inviter_type"], name: "index_invitations_on_inviter_id_and_inviter_type", using: :btree
  add_index "invitations", ["recipient_email"], name: "index_invitations_on_recipient_email", using: :btree
  add_index "invitations", ["token"], name: "index_invitations_on_token", using: :btree

  create_table "likes", force: true do |t|
    t.integer  "media_id"
    t.integer  "friend_id"
    t.datetime "time_posted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["friend_id"], name: "index_likes_on_friend_id", using: :btree
  add_index "likes", ["media_id"], name: "index_likes_on_media_id", using: :btree

  create_table "managers", force: true do |t|
    t.string "job_title"
    t.string "department"
    t.string "twitter"
    t.string "snapchat"
    t.string "instagram"
    t.string "facebook"
    t.string "vine"
  end

  create_table "media", force: true do |t|
    t.integer  "actable_id"
    t.string   "actable_type"
    t.boolean  "approved",                default: false
    t.integer  "view_count",              default: 0
    t.string   "lat"
    t.string   "lng"
    t.float    "duration"
    t.string   "caption"
    t.string   "url"
    t.datetime "time_approved"
    t.datetime "time_scheduled"
    t.datetime "time_posted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_extension"
    t.string   "readable_time_scheduled"
    t.integer  "campaign_id"
    t.integer  "property_id"
    t.boolean  "posted",                  default: false
    t.string   "checked_at"
  end

  add_index "media", ["campaign_id"], name: "index_media_on_campaign_id", using: :btree
  add_index "media", ["property_id"], name: "index_media_on_property_id", using: :btree

  create_table "media_tags", id: false, force: true do |t|
    t.integer "media_id", null: false
    t.integer "tag_id",   null: false
  end

  add_index "media_tags", ["media_id", "tag_id"], name: "index_media_tags_on_media_id_and_tag_id", using: :btree
  add_index "media_tags", ["tag_id", "media_id"], name: "index_media_tags_on_tag_id_and_media_id", using: :btree

  create_table "properties", force: true do |t|
    t.string   "name"
    t.string   "snapchat"
    t.string   "twitter"
    t.string   "instagram"
    t.string   "youtube"
    t.string   "facebook"
    t.string   "vine"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "session_token"
    t.string   "color"
    t.datetime "stats_updated_at"
    t.integer  "brand_id"
  end

  add_index "properties", ["brand_id"], name: "index_properties_on_brand_id", using: :btree
  add_index "properties", ["session_token"], name: "index_properties_on_session_token", using: :btree

  create_table "property_identities", id: false, force: true do |t|
    t.integer "property_id", null: false
    t.integer "identity_id", null: false
  end

  add_index "property_identities", ["identity_id", "property_id"], name: "index_property_identities_on_identity_id_and_property_id", using: :btree
  add_index "property_identities", ["property_id", "identity_id"], name: "index_property_identities_on_property_id_and_identity_id", using: :btree

  create_table "property_settings", force: true do |t|
    t.integer  "property_id"
    t.integer  "frequency"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "property_settings", ["property_id"], name: "index_property_settings_on_property_id", using: :btree

  create_table "property_users", force: true do |t|
    t.integer  "property_id"
    t.integer  "user_id"
    t.integer  "auth_level",  default: 3
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "property_users", ["property_id"], name: "index_property_users_on_property_id", using: :btree
  add_index "property_users", ["user_id"], name: "index_property_users_on_user_id", using: :btree

  create_table "quick_snaps", force: true do |t|
    t.integer  "property_id"
    t.integer  "snap_id"
    t.float    "duration"
    t.datetime "time_scheduled"
    t.datetime "time_posted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "posted_on",               default: false
    t.string   "readable_time_scheduled"
  end

  add_index "quick_snaps", ["property_id"], name: "index_quick_snaps_on_property_id", using: :btree
  add_index "quick_snaps", ["snap_id"], name: "index_quick_snaps_on_snap_id", using: :btree

  create_table "scheduled_tasks", force: true do |t|
    t.integer  "taskable_id"
    t.string   "taskable_type"
    t.string   "method"
    t.integer  "frequency_quantity"
    t.integer  "frequency_period_id"
    t.string   "at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tz"
  end

  add_index "scheduled_tasks", ["frequency_period_id"], name: "index_scheduled_tasks_on_frequency_period_id", using: :btree
  add_index "scheduled_tasks", ["method"], name: "index_scheduled_tasks_on_method", using: :btree
  add_index "scheduled_tasks", ["taskable_id", "taskable_type"], name: "index_scheduled_tasks_on_taskable_id_and_taskable_type", using: :btree

  create_table "snaps", force: true do |t|
    t.integer  "text_size"
    t.integer  "drawing"
    t.boolean  "front_facing",          default: false
    t.string   "story_id"
    t.boolean  "mature_content",        default: false
    t.string   "snapchat_file_name"
    t.string   "snapchat_content_type"
    t.integer  "snapchat_file_size"
    t.datetime "snapchat_updated_at"
    t.string   "direct_upload_url"
    t.boolean  "processed",             default: false,     null: false
    t.hstore   "snapchat_meta"
    t.string   "media_iv"
    t.string   "media_key"
    t.integer  "screenshot_count",      default: 0
    t.string   "color",                 default: "#8ECDD8"
    t.string   "overlay_file_name"
    t.string   "overlay_content_type"
    t.integer  "overlay_file_size"
    t.datetime "overlay_updated_at"
  end

  add_index "snaps", ["processed"], name: "index_snaps_on_processed", using: :btree
  add_index "snaps", ["story_id"], name: "index_snaps_on_story_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["tag"], name: "index_tags_on_tag", using: :btree

  create_table "users", force: true do |t|
    t.integer  "actable_id"
    t.string   "actable_type"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "phone"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_hash"
    t.string   "password_salt"
    t.boolean  "admin",         default: false
  end

  add_index "users", ["token"], name: "index_users_on_token", using: :btree

  create_table "videos", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "clip_file_name"
    t.string   "clip_content_type"
    t.integer  "clip_file_size"
    t.datetime "clip_updated_at"
    t.string   "wrongClip_file_name"
    t.string   "wrongClip_content_type"
    t.integer  "wrongClip_file_size"
    t.datetime "wrongClip_updated_at"
    t.string   "clip_thumb_exceed_file_name"
    t.string   "clip_thumb_exceed_content_type"
    t.integer  "clip_thumb_exceed_file_size"
    t.datetime "clip_thumb_exceed_updated_at"
    t.string   "clip_thumb_normal_file_name"
    t.string   "clip_thumb_normal_content_type"
    t.integer  "clip_thumb_normal_file_size"
    t.datetime "clip_thumb_normal_updated_at"
    t.string   "clip_thumb_negative_file_name"
    t.string   "clip_thumb_negative_content_type"
    t.integer  "clip_thumb_negative_file_size"
    t.datetime "clip_thumb_negative_updated_at"
    t.string   "clip_thumb_bad_extension_file_name"
    t.string   "clip_thumb_bad_extension_content_type"
    t.integer  "clip_thumb_bad_extension_file_size"
    t.datetime "clip_thumb_bad_extension_updated_at"
    t.string   "portraitClip_file_name"
    t.string   "portraitClip_content_type"
    t.integer  "portraitClip_file_size"
    t.datetime "portraitClip_updated_at"
    t.string   "landscapeClip_file_name"
    t.string   "landscapeClip_content_type"
    t.integer  "landscapeClip_file_size"
    t.datetime "landscapeClip_updated_at"
    t.hstore   "portraitClip_meta"
    t.hstore   "landscapeClip_meta"
  end

  create_table "vines", force: true do |t|
    t.string   "foursquare_id"
    t.string   "venue_name"
    t.integer  "on_fire"
    t.integer  "velocity"
    t.string   "video_file_name"
    t.string   "video_content_type"
    t.integer  "video_file_size"
    t.datetime "video_updated_at"
  end

end
