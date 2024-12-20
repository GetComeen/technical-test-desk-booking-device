# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

users = User.create!([
  { email: "alice@example.com" },
  { email: "bob@example.com" },
  { email: "charlie@example.com" },
])

integration_grants = IntegrationGrant.create!([
  { user: users.first, provider: "google", domain: "sheets" },
])

access_token = <<~TOKEN
  "ya29.a0ARrdaM-VALID-TOKEN-EXAMPLE-1234567890"
TOKEN

refresh_token = <<~TOKEN
  "1//0c-VALID-TOKEN-EXAMPLE-1234567890"
TOKEN

_google_oauth_tokens = Google::OauthToken.create!({
  integration_grant: integration_grants.first,
  access_token:,
  refresh_token:,
  scope: "https://www.googleapis.com/auth/spreadsheets",
  expires_at: 1.day.from_now,
})

desk_sheets = Google::DeskSheet.create!([
  { google_sheet_id: "5ryHHFcj1cnimHvv678t7SivrCrMHrnmfqd", last_synced_at: Time.current },
])

desks = Desk.create!([
  { name: "Enginnering - 1", sync_id: "B1F1D1", google_desk_sheet: desk_sheets.first },
  { name: "Enginnering - 2", sync_id: "B1F1D2", google_desk_sheet: desk_sheets.first },
  { name: "Enginnering - 3", sync_id: "B1F1D3", google_desk_sheet: desk_sheets.first },
  { name: "Research - 1", sync_id: "B1F2D1", google_desk_sheet: desk_sheets.first },
  { name: "Research - 2", sync_id: "B1F2D2", google_desk_sheet: desk_sheets.first },
  { name: "Consulting - 1", sync_id: "B3F3D1" },
  { name: "Consulting - 2", sync_id: "B3F3D2" },
  { name: "Consulting - 3", sync_id: "B3F3D3" },
  { name: "Consulting - 4", sync_id: "B3F3D4" },
  { name: "Consulting - 5", sync_id: "B3F3D5" },
  { name: "Consulting - 6", sync_id: "B3F3D6" },
  { name: "Consulting - 7", sync_id: "B3F3D7" },
  { name: "Consulting - 8", sync_id: "B3F3D8" },
  { name: "Consulting - 9", sync_id: "B3F3D9" },
  { name: "Consulting - 10", sync_id: "B3F3D10" },
])

DeskBooking.create!([
  {
    desk: desks.first,
    user: users.first,
    start_datetime: 1.day.from_now.change(hour: 9),
    end_datetime: 2.days.from_now.change(hour: 6),
  },
  {
    desk: desks.second,
    user: users.second,
    start_datetime: 1.day.from_now.change(hour: 9),
    end_datetime: 2.days.from_now.change(hour: 6),
  },
  {
    desk: desks.third,
    user: users.third,
    start_datetime: 1.day.from_now.change(hour: 9),
    end_datetime: 2.days.from_now.change(hour: 6),
  },
])

Doorkeeper::Application.create!({
  name: "API Dev client",
  redirect_uri: "http://localhost:3000/",
  confidential: false,
})
