defmodule Mypage.Repo do
  use Ecto.Repo,
    otp_app: :mypage,
    adapter: Ecto.Adapters.Postgres
end
