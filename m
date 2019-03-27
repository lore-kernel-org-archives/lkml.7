Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A94BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EFC206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbfC0Va6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 17:30:58 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34165 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfC0Va6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 17:30:58 -0400
Received: by mail-oi1-f196.google.com with SMTP id v10so9773218oib.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 14:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JCxnMapnujBLhv3W4a2O/ybJVO1nPLBLzENy+BoBkzI=;
        b=CYqhl0kcfwmo/KKVY0YZp4mo3ggX1YGJ7rMFZ7Oxd2HAUtlOQy05VfO2Qvd1XzQ6yr
         Td98CXnrD1Iu1fjDbquG+HzArq4GmYe+ifuht2E6w/zVN72EXmWTX8JXr4N5QPfDrjPI
         jrZc22dUQZESaXI2TvBcTWH30CjZzjx5pLE8TanRVegqLIqux4HXenTiJFM3B6+cNJVJ
         uxNC151vxKOI5g1HGa+PH24GPGf3a+6YervItd8U1BT4npqmGmtSzFb95FpoF2ehJfxM
         X1h30JwmP8MZvDFh6wZvufLYEDWqUpdN2thspRh4Ul6EknC9Ehsao5UO8OZH+5ZlLtiD
         abcQ==
X-Gm-Message-State: APjAAAUWaiQ3UNgifCnghPQv+zIoqhXBZU4nbzO94hXyGfTbWKYM82GY
        MI1yyUNdZTPI8FyaeUqOi76qwqStsgajjjlHOoSLcA==
X-Google-Smtp-Source: APXvYqzpOsg5/ddMOVD6tkFIZoG8HsMUEk6pRb/r/uF6W8zIIVx6JNflvK9lq1O5TOVwuTtQRCo+bN1aBWuoR+W7Pa8=
X-Received: by 2002:aca:5747:: with SMTP id l68mr21554750oib.103.1553722257766;
 Wed, 27 Mar 2019 14:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1552665316.git.rgb@redhat.com> <e724de2037db0fd72fef7154c83615a742417d31.1552665316.git.rgb@redhat.com>
In-Reply-To: <e724de2037db0fd72fef7154c83615a742417d31.1552665316.git.rgb@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 27 Mar 2019 22:30:46 +0100
Message-ID: <CAFqZXNu2NRJg-cy_b=ig4o7v6+3dV1kGp8QtKRcVbtBxrapDMQ@mail.gmail.com>
Subject: Re: [PATCH ghak90 V5 07/10] audit: add containerid support for user records
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Simo Sorce <simo@redhat.com>,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>, nhorman@tuxdriver.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 7:34 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> Add audit container identifier auxiliary record to user event standalone
> records.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>

> ---
>  kernel/audit.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index cfa659b3f6c4..cf448599ef34 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1142,12 +1142,6 @@ static void audit_log_common_recv_msg(struct audit_context *context,
>         audit_log_task_context(*ab);
>  }
>
> -static inline void audit_log_user_recv_msg(struct audit_buffer **ab,
> -                                          u16 msg_type)
> -{
> -       audit_log_common_recv_msg(NULL, ab, msg_type);
> -}
> -
>  int is_audit_feature_set(int i)
>  {
>         return af.features & AUDIT_FEATURE_TO_MASK(i);
> @@ -1409,13 +1403,16 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>
>                 err = audit_filter(msg_type, AUDIT_FILTER_USER);
>                 if (err == 1) { /* match or error */
> +                       struct audit_context *context;
> +
>                         err = 0;
>                         if (msg_type == AUDIT_USER_TTY) {
>                                 err = tty_audit_push();
>                                 if (err)
>                                         break;
>                         }
> -                       audit_log_user_recv_msg(&ab, msg_type);
> +                       context = audit_alloc_local(GFP_KERNEL);
> +                       audit_log_common_recv_msg(context, &ab, msg_type);
>                         if (msg_type != AUDIT_USER_TTY)
>                                 audit_log_format(ab, " msg='%.*s'",
>                                                  AUDIT_MESSAGE_TEXT_MAX,
> @@ -1431,6 +1428,8 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>                                 audit_log_n_untrustedstring(ab, data, size);
>                         }
>                         audit_log_end(ab);
> +                       audit_log_contid(context, audit_get_contid(current));
> +                       audit_free_context(context);
>                 }
>                 break;
>         case AUDIT_ADD_RULE:
> --
> 1.8.3.1
>


-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
