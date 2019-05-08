Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CF5C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A26214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfEHLtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 07:49:08 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:38122 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbfEHLtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:49:08 -0400
Received: by mail-oi1-f170.google.com with SMTP id u199so6927619oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 04:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=UiE/dtL+DxzJlyZjaLoLZA2ogaq5/eux+wRF3qdxndo=;
        b=jiMjonzIjrgNe7EAzkLk/4nVT/pqOXjT2WiGo6TPXEvlfnhvMBmJ+igDdeLA5VEWnb
         lsmnRjUQAB0I9dQaVSeFWzBgOmybXGlUh9Cqp4XaJN2lC9GtrbcpcafaKd84OUz3FzFi
         WMFP7/coUZ07Y5b2pSSJn7rR+TFfQPuOxY82LeZXdUi59PrN3dtU8m0HwRMWDwgUDWEz
         C3JU6CvEPeKgSoWMMS3LfjfrD1Ahui0ZfBomLRDd0W3AOKLIJ9D3uFBUmZVJDFRl5mZ7
         xWbxf5KQUWexu5uOHveOXl1bobX+5HKJEi6RlVd405ZgL4YNdgu9PuxWShvD50G8r/Uv
         w7gQ==
X-Gm-Message-State: APjAAAVB0XoASkmsp5tJqxEPnDQ/1BC8SLGCt66k/V1W9SWXWWxQHgpL
        HvO08MM5j9vrRLH6YYOCx4hzKQATqfmRf4v3N6tshg==
X-Google-Smtp-Source: APXvYqxluCoCeUr0XTO0miGV4Vy0BPUjHo8v1sjoZvLpTNp1hAZYGq6eM2jOpvAoF/P55Rr+c9MuiQ/KP2SrGhcbsNk=
X-Received: by 2002:a54:4f02:: with SMTP id e2mr1834383oiy.10.1557316147176;
 Wed, 08 May 2019 04:49:07 -0700 (PDT)
MIME-Version: 1.0
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 8 May 2019 13:48:56 +0200
Message-ID: <CAHc6FU5Yd9EVju+kY8228n-Ccm7F2ZBRJUbesT-HYsy2YjKc_w@mail.gmail.com>
Subject: GFS2: Pull Request
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following changes for the GFS2 file system.

There was a conflict with commit 2b070cfe582b ("block: remove the i
argument to bio_for_each_segment_all") on Jens's block layer changes
which you've already merged. I've resolved that by merging those block
layer changes; please let me know if you want this done differently.

Thanks,
Andreas

The following changes since commit b4b52b881cf08e13d110eac811d4becc0775abbf:

  Merge tag 'Wimplicit-fallthrough-5.2-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux
(2019-05-07 12:48:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
tags/gfs2-for-5.2

for you to fetch changes up to dd665ce42728aa985ec4c7002ffe8690cde74c54:

  Merge tag 'for-5.2/block-20190507' of
git://git.kernel.dk/linux-block (2019-05-08 10:30:57 +0200)

----------------------------------------------------------------
We've got the following patches ready for this merge window:

"gfs2: Fix loop in gfs2_rbm_find (v2)"

  A rework of a fix we ended up reverting in 5.0 because of an iozone
  performance regression.

"gfs2: read journal in large chunks" and
"gfs2: fix race between gfs2_freeze_func and unmount"

  An improved version of a commit we also ended up reverting in 5.0
  because of a regression in xfstest generic/311.  It turns out that the
  journal changes were mostly innocent and that unfreeze didn't wait for
  the freeze to complete, which caused the filesystem to be unmounted
  before it was actually idle.

"gfs2: Fix occasional glock use-after-free"
"gfs2: Fix iomap write page reclaim deadlock"
"gfs2: Fix lru_count going negative"

  Fixes for various problems reported and partially fixed by Citrix
  engineers.  Thank you very much.

"gfs2: clean_journal improperly set sd_log_flush_head"

  Another fix from Bob.

A few other minor cleanups.

----------------------------------------------------------------
Abhi Das (2):
      gfs2: fix race between gfs2_freeze_func and unmount
      gfs2: read journal in large chunks

Andreas Gruenbacher (8):
      gfs2: Fix loop in gfs2_rbm_find (v2)
      gfs2: Fix occasional glock use-after-free
      gfs2: Remove misleading comments in gfs2_evict_inode
      gfs2: Remove unnecessary extern declarations
      gfs2: Rename sd_log_le_{revoke,ordered}
      gfs2: Rename gfs2_trans_{add_unrevoke => remove_revoke}
      gfs2: Fix iomap write page reclaim deadlock
      Merge tag 'for-5.2/block-20190507' of git://git.kernel.dk/linux-block

Bob Peterson (2):
      gfs2: clean_journal improperly set sd_log_flush_head
      gfs2: Replace gl_revokes with a GLF flag

Ross Lagerwall (1):
      gfs2: Fix lru_count going negative

 fs/gfs2/aops.c       |  14 ++-
 fs/gfs2/bmap.c       | 118 ++++++++++++++---------
 fs/gfs2/bmap.h       |   1 +
 fs/gfs2/dir.c        |   2 +-
 fs/gfs2/glock.c      |  25 +++--
 fs/gfs2/glops.c      |   3 +-
 fs/gfs2/incore.h     |   9 +-
 fs/gfs2/log.c        |  47 ++++++----
 fs/gfs2/log.h        |   5 +-
 fs/gfs2/lops.c       | 260 ++++++++++++++++++++++++++++++++++++++++++++++-----
 fs/gfs2/lops.h       |  11 +--
 fs/gfs2/main.c       |   1 -
 fs/gfs2/ops_fstype.c |   7 +-
 fs/gfs2/recovery.c   | 135 ++------------------------
 fs/gfs2/recovery.h   |   4 +-
 fs/gfs2/rgrp.c       |  56 ++++++-----
 fs/gfs2/super.c      |  20 ++--
 fs/gfs2/trans.c      |   4 +-
 fs/gfs2/trans.h      |   2 +-
 fs/gfs2/xattr.c      |   6 +-
 20 files changed, 437 insertions(+), 293 deletions(-)
