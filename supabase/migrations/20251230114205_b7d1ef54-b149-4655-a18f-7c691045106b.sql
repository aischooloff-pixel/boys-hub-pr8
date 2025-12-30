-- Create notifications table
CREATE TABLE public.notifications (
  id uuid NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_profile_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  type text NOT NULL, -- 'like', 'comment', 'rep', 'article_approved', 'article_rejected', 'favorite'
  message text NOT NULL,
  article_id uuid REFERENCES public.articles(id) ON DELETE CASCADE,
  from_user_id uuid REFERENCES public.profiles(id) ON DELETE SET NULL,
  is_read boolean NOT NULL DEFAULT false,
  created_at timestamp with time zone NOT NULL DEFAULT now()
);

-- Enable RLS
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;

-- Policies
CREATE POLICY "Users can view own notifications" 
ON public.notifications 
FOR SELECT 
USING (true);

CREATE POLICY "Service role can manage notifications" 
ON public.notifications 
FOR ALL 
USING (true)
WITH CHECK (true);

-- Index for faster queries
CREATE INDEX idx_notifications_user_profile_id ON public.notifications(user_profile_id);
CREATE INDEX idx_notifications_created_at ON public.notifications(created_at DESC);