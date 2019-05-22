Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B15C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04FE20675
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbfEVMTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 08:19:51 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:34547 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbfEVMTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 08:19:51 -0400
Received: by mail-ot1-f46.google.com with SMTP id l17so1870288otq.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 05:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=qR0MaKhITKtU6hBO20rUhBwrXuT23cfT9o9u+4k7qjw=;
        b=spBHVLpJoJSrfgn3nUNCYQmtEDq64i2mVsTWou/KPrAVUU2bJSmc5ybzI0g/10rGdg
         EUTY1XGRMPh5JKXeNQpkGLUtE6DzkDCgXZji5ELYUgbLyVzd2ETMWNRy9prIij8b83BG
         CGMXEg4Xttl16+o0Zvx1GvaN01m+0Z9XtSV3rmK8KCpvYMM5LoNzpeUHdPLQqLNPVfSy
         lL9BMN9WbDQrT9w0KRi9p9yhpjp4WXrzXLidVHbrpqR7zfOz2Pu88C6NM1SuSbEbLfxd
         E2rJcplGs7Qos/ZntUGs00GdzhWymqiu6VfwYvvwaYJVSgo1wgoWnLAtlGcYFg3PfKyY
         hjrA==
X-Gm-Message-State: APjAAAVVOA+UF7J7nM/MCAcaKPyjh+xxL4p6M7UTqUQzJHTCzmgyjjds
        lyNoKhQ5SxdB4RnWVgJbjg/iKQLbWYjS89QMg309pw==
X-Google-Smtp-Source: APXvYqwDcWks8Ve32hEDwrgPlUaxWsbEp7qMwRFloclbktCS4gJ7NdKb2on86R3g9M+yYiMVnHNT87opgcNI0pRCrS8=
X-Received: by 2002:a9d:63c1:: with SMTP id e1mr20475056otl.341.1558527590980;
 Wed, 22 May 2019 05:19:50 -0700 (PDT)
MIME-Version: 1.0
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 22 May 2019 14:19:39 +0200
Message-ID: <CAHc6FU71Yp9Y8ZDrJnJ3AAQazW8-WpTCLCHWYu-+JQ2tTu4Ymg@mail.gmail.com>
Subject: [GIT PULL] gfs2: Fix sign extension bug in gfs2_update_stats
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

could you please pull the following gfs2 fix?

Thanks,
Andreas

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
tags/gfs2-5.1.fixes2

for you to fetch changes up to 5a5ec83d6ac974b12085cd99b196795f14079037:

  gfs2: Fix sign extension bug in gfs2_update_stats (2019-05-22 14:09:44 +0200)

----------------------------------------------------------------
Fix a gfs2 sign extension bug introduced in v4.3.

----------------------------------------------------------------
Andreas Gruenbacher (1):
      gfs2: Fix sign extension bug in gfs2_update_stats

 fs/gfs2/lock_dlm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)
