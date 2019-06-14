Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E523C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5A72183F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfFNQzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:55:18 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:40571 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfFNQzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:55:14 -0400
Received: by mail-oi1-f173.google.com with SMTP id w196so2450708oie.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 09:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=uCDoaz8aKWpO13fo3w+/O/u1UspM1FCDsjyWvamzqQU=;
        b=lqsvFaqBdhaFiM79FpX2iUE9OTWhVH+BpfsjB375KARax6049EjFTOXjWRUHX7PoVi
         mq9Q8a5qDT1GdCcsjuU2kU87HNGblHAEBCH1YaS209FjaGLmv06hT9Q0ryvjOQCPCQ44
         U2TjDCDFS4VkyXDPPrxwhMUhW3SvfYQl29tHZAKWLUseIfg8dZTto7NRHOgXHeRrN4Br
         qmmqNWs2jjwn3dVqXriWJZUZSCWw09qy+089P1pjSaOUBAwtxqRe77/yNFKba82oeGka
         6d6UN0+3NizrFmpzNxjWPkk6RvIJPkLYW66Bjj9hIM0mwHpIapivFQFjafCL4HTeN7X4
         PCaQ==
X-Gm-Message-State: APjAAAX8sbrhj96zCyl/doic4uajW0bkhaKQoB4K+lAjhMuQ923F2SWw
        DkvOmGOYLxzHnSVQq09nOgcDhe6smeroGhYLIpo8BN415Gg=
X-Google-Smtp-Source: APXvYqy0NUn4FSP3QtqqdPCPF8oryEc1IkqQfJ01gZ/4QulvGNLsv+5GPlEyyHacfI/g3qwf1evgUMXjoAL/lV4kuTc=
X-Received: by 2002:aca:342:: with SMTP id 63mr2349932oid.10.1560531313156;
 Fri, 14 Jun 2019 09:55:13 -0700 (PDT)
MIME-Version: 1.0
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 14 Jun 2019 18:55:02 +0200
Message-ID: <CAHc6FU7aKs3bUwjnPeLn4Nw82ojGcQxkJbDsgtVdXYVRjVW0bQ@mail.gmail.com>
Subject: [GIT PULL] gfs2: Fix rounding error in gfs2_iomap_page_prepare
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

could you please pull the following gfs2 fix?

Thank you very much,
Andreas

The following changes since commit dc8ca9cc6e23054eb85599c9417ef2416848e7e8:

  Merge tag 'gfs2-v5.2.fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2
(2019-06-06 12:33:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
tags/gfs2-v5.2.fixes2

for you to fetch changes up to 2741b6723bf6f7d92d07c44bd6a09c6e37f3f949:

  gfs2: Fix rounding error in gfs2_iomap_page_prepare (2019-06-14
18:49:07 +0200)

----------------------------------------------------------------
Fix rounding error in gfs2_iomap_page_prepare

----------------------------------------------------------------
Andreas Gruenbacher (1):
      gfs2: Fix rounding error in gfs2_iomap_page_prepare

 fs/gfs2/bmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
