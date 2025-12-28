ALTER TABLE public.profiles
ADD COLUMN IF NOT EXISTS is_blocked boolean NOT NULL DEFAULT false;

ALTER TABLE public.profiles
ADD COLUMN IF NOT EXISTS blocked_at timestamp with time zone NULL;

CREATE INDEX IF NOT EXISTS idx_profiles_is_blocked ON public.profiles (is_blocked);
