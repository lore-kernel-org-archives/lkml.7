Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E492C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1701120644
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mjjKlnnd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388046AbfHASLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 14:11:47 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34519 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732904AbfHASLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 14:11:46 -0400
Received: by mail-io1-f67.google.com with SMTP id k8so146453222iot.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 11:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7MPd9Z2BvCtW7Jj5gv1G0oE0SQQ2Vxu4lTK1/nmzm1Y=;
        b=mjjKlnndG/GVdJ2j0Hg/y21fENjZrPYmRXprn1WIV7jx1SFh4AKaGH6jAMk+6QX0b7
         8MAe2ZM+HcBcGCigoIvlWqL3V9NE0D8RrWqeVkaXe7XqLQWa9/3iAo7hvm1eoLZsDCTD
         KPZu7tNADpUrbzM3RdL9AfiLGqRc71KwRISis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7MPd9Z2BvCtW7Jj5gv1G0oE0SQQ2Vxu4lTK1/nmzm1Y=;
        b=AsjrvsEKOb+Xh6lYbTOQm2WYAwLThjfmMWCW0wP6snyVm+MvAQiDF61I9gH5bq1D/h
         L4MTdLfd52dngZ1KSjR8vu7zYIwyrW1+yPAySQ4xK18R0U5IN4EG6yLrDOMpEUdhYhgc
         NKF7fqeocfBLlEZ5qz1EXstDDnA+QO1z79Gr0llTHfrORE9w2IdaHJb5TZ3Z9SocQpWI
         nbAA3BWFmtAweT9u+j/xM/piiS80VYATVRs6v07Ego5yv5DR5YlgdRMR/fsqFnm8cUtL
         SP6tIo334lkE+NI37l6O6g/H9hBzCEYiGw//vdjWwthYc/uqGl/8i6b3CwvIFA5NMz/H
         V/Cg==
X-Gm-Message-State: APjAAAXRBgRIwT00ZxFq5Y77DZrG0H170o6iY2VvdLSZE5PRigndZUeF
        dMHLc6mp+S2PoBVVDFWtVps68Po6vqMhaym3uBnABD0Eohg=
X-Google-Smtp-Source: APXvYqys9OKV3WWO1jdTMSSqa3FCsNk1iOy3DY3kCK56G261uJszlQ4eZ7b5tSvUocfF99RAqKyEnoaFs161mi78zUo=
X-Received: by 2002:a6b:e60b:: with SMTP id g11mr125198636ioh.9.1564683105971;
 Thu, 01 Aug 2019 11:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccMXEVktpuPS5BwkGqTo++dGcpHAuSUZo7WgJhAzFByz0g@mail.gmail.com>
 <CAHk-=whZzJ8WxAeHcirUghcbeOYxmpCr+XxeS9ngH3df3+=p2Q@mail.gmail.com>
In-Reply-To: <CAHk-=whZzJ8WxAeHcirUghcbeOYxmpCr+XxeS9ngH3df3+=p2Q@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Thu, 1 Aug 2019 11:11:34 -0700
Message-ID: <CAJ-EccOqmmrf2KPb7Z7NU6bF_4W1XUawLLy=pLekCyFKqusjKQ@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID MAINTAINERS file update for v5.3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry about that. To fix it I did a "git reset hard" to before any of
those commits by Jann Horn, then fast-forwarded to the v5.3-rc2 tag
and force pushed that to my origin/master then pushed a new branch up
with my MAINTAINERS file changes. Hopefully this is a valid fix.

--
The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  https://github.com/micah-morton/linux.git
  tags/safesetid-maintainers-correction-5.3-rc2

for you to fetch changes up to fc5b34a35458314df1dd00281f6e41f419581aa9:

  Add entry in MAINTAINERS file for SafeSetID LSM (2019-08-01 10:30:57 -0700)

----------------------------------------------------------------
Add entry in MAINTAINERS file for SafeSetID LSM.

Has not had any bake time or testing, since its just changes to a text file.

----------------------------------------------------------------
Micah Morton (1):
      Add entry in MAINTAINERS file for SafeSetID LSM

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

On Thu, Aug 1, 2019 at 6:25 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Jul 31, 2019 at 2:30 PM Micah Morton <mortonm@chromium.org> wrote:
> >
> > You mentioned a couple weeks ago it would be good if I added myself to
> > the MAINTAINERS file for the SafeSetID LSM. Here's the pull request
> > for v5.3.
>
> There's a lot more than the maintainer ID in there. You've rebased old
> patches that I already had etc:
>
>   Jann Horn (10):
>       LSM: SafeSetID: fix pr_warn() to include newline
>       LSM: SafeSetID: fix check for setresuid(new1, new2, new3)
>       LSM: SafeSetID: refactor policy hash table
>       LSM: SafeSetID: refactor safesetid_security_capable()
>       LSM: SafeSetID: refactor policy parsing
>       LSM: SafeSetID: fix userns handling in securityfs
>       LSM: SafeSetID: rewrite userspace API to atomic updates
>       LSM: SafeSetID: add read handler
>       LSM: SafeSetID: verify transitive constrainedness
>       LSM: SafeSetID: fix use of literal -1 in capable hook
>
>   Micah Morton (2):
>       Merge commit 'v5.3-rc2^0'
>       Add entry in MAINTAINERS file for SafeSetID LSM
>
> Not pulled.
>
>                   Linus
