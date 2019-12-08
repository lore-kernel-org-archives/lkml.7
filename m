Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61295C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 04:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF4220692
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 04:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfLHEqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 23:46:21 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:57580 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfLHEqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 23:46:21 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1idoSC-0001Jw-Ai; Sun, 08 Dec 2019 04:46:03 +0000
Date:   Sun, 8 Dec 2019 04:45:56 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] several misc cleanups
Message-ID: <20191208044556.GR4203@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	No common topic; FWIW, timestamp-related one got combined with
Deepa's patches and moved out into #work.timestamp; probably the next cycle
fodder.  A couple of dcache_readdir()-related ones (likely to get some
massage) - moved into next.misc for now, #work.dcache_readdir once it
gets into shape for public tree; they belong there anyway.  Which has
left just these three...

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

for you to fetch changes up to 5c8b0dfc6f4a5e6c707827d0172fc1572e689094:

  make __d_alloc() static (2019-10-25 14:08:24 -0400)

----------------------------------------------------------------
Al Viro (1):
      make __d_alloc() static

Ben Dooks (2):
      fs/fnctl: fix missing __user in fcntl_rw_hint()
      fs/namespace: add __user to open_tree and move_mount syscalls

 fs/dcache.c    | 2 +-
 fs/fcntl.c     | 2 +-
 fs/internal.h  | 1 -
 fs/namespace.c | 6 +++---
 4 files changed, 5 insertions(+), 6 deletions(-)
