Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C3CECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B13214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502538AbfJQMqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:46:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389259AbfJQMqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 08:46:31 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0FFA97FDFA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 12:46:31 +0000 (UTC)
Received: by mail-ot1-f70.google.com with SMTP id h13so1041938otk.20
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 05:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vaWTT7JqqW/omoel2Kh7+Tx9nZC4ZDq/vWAR367HkMc=;
        b=Si/S9EPiBZDU4YXa+TmuLbbd0USbu8sBlTASMisBuqp3ig7AnmyVzkeHDx3+YW5fYv
         w2qigVFua/oMZFbKZnXgSH8T8CWw7T1jDmuygF1eLcjuCJeDrCixbeQep65zOB8lYv3D
         szq50xJHSeUt5/JYAdY+RvGBF0b+SWuJ5TtfIiM+k6J9s7tRt3ncOIpne6VtWLVmfCg0
         LxWjFy+GQLR96DiCBztVe+NjgnF6a5IGeq+94h0bSv6Zgo5uXJJT85c8meYpCafS3RY3
         eFfSY2HG5R4QW+nFN8XXuaMAB+YZRWhFFuKXibcw3SJO0RHi1fCDq6qobsUq6MRIum9/
         3ESg==
X-Gm-Message-State: APjAAAX7dcHBaa3KN7FpJL60/jlpf9MuX8YvJDCm0hPA5RuA4RWi/Z1M
        /NoRzohq+Y0ZZyusqQPfeF09wG1Sq2X0xwC94npGUqOUWf1+lSKz7oRmqpntUJ+lxr2s6QRK9S5
        Kp48Ls98T8sbYD98a8w3fGQCiAscfOjbtTndYMTk2
X-Received: by 2002:a9d:578c:: with SMTP id q12mr2894077oth.185.1571316390464;
        Thu, 17 Oct 2019 05:46:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqymPkeFxkVdqnQC5LbPy95EWMAssDeF/PPOZOqn+xXKlKhhjqCK4Yb0h5AV9GEqyNDK0ze/wDlm4K38c45cWow=
X-Received: by 2002:a9d:578c:: with SMTP id q12mr2894065oth.185.1571316390261;
 Thu, 17 Oct 2019 05:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191017110225.30841-1-ben.dooks@codethink.co.uk> <25bb4857-950e-592a-b2ba-7730867742b3@redhat.com>
In-Reply-To: <25bb4857-950e-592a-b2ba-7730867742b3@redhat.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 17 Oct 2019 14:46:19 +0200
Message-ID: <CAHc6FU7V6PK4OhzqiELiG8cXi5jhpV7whe5Dx5jbL_69LxzUpg@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH] gfs2: make gfs2_fs_parameters static
To:     Andrew Price <anprice@redhat.com>
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        linux-kernel@lists.codethink.co.uk,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 1:42 PM Andrew Price <anprice@redhat.com> wrote:
> On 17/10/2019 12:02, Ben Dooks (Codethink) wrote:
> > The gfs2_fs_parameters is not used outside the unit
> > it is declared in, so make it static.
> >
> > Fixes the following sparse warning:
> >
> > fs/gfs2/ops_fstype.c:1331:39: warning: symbol 'gfs2_fs_parameters' was not declared. Should it be static?
> >
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > ---
> > Cc: Bob Peterson <rpeterso@redhat.com>
> > Cc: Andreas Gruenbacher <agruenba@redhat.com>
> > Cc: cluster-devel@redhat.com
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >   fs/gfs2/ops_fstype.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> > index 681b44682b0d..ebdef1c5f580 100644
> > --- a/fs/gfs2/ops_fstype.c
> > +++ b/fs/gfs2/ops_fstype.c
> > @@ -1328,7 +1328,7 @@ static const struct fs_parameter_enum gfs2_param_enums[] = {
> >       {}
> >   };
> >
> > -const struct fs_parameter_description gfs2_fs_parameters = {
> > +static const struct fs_parameter_description gfs2_fs_parameters = {
> >       .name = "gfs2",
> >       .specs = gfs2_param_specs,
> >       .enums = gfs2_param_enums,
> >
>
> Looks good to me.

Andy, I've added a reviewed-by tag for you and pushed this to for-next.

Thanks,
Andreas
