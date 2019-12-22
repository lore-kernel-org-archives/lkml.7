Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF814C2D0C8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 23:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC61120684
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 23:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfLVXXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 18:23:07 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:48068 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfLVXXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 18:23:06 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ijAYy-000643-9g; Sun, 22 Dec 2019 23:23:04 +0000
Date:   Sun, 22 Dec 2019 23:23:04 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] vfs.git assorted fixes
Message-ID: <20191222232304.GN4203@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Eric's s_inodes softlockup fixes + Jan's fix for recent regression
from pipe rework.

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to 1edc8eb2e93130e36ac74ac9c80913815a57d413:

  fs: call fsnotify_sb_delete after evict_inodes (2019-12-18 00:03:01 -0500)

----------------------------------------------------------------
Eric Sandeen (2):
      fs: avoid softlockups in s_inodes iterators
      fs: call fsnotify_sb_delete after evict_inodes

Jan Kara (1):
      pipe: Fix bogus dereference in iov_iter_alignment()

 fs/drop_caches.c     | 2 +-
 fs/inode.c           | 7 +++++++
 fs/notify/fsnotify.c | 4 ++++
 fs/quota/dquot.c     | 1 +
 fs/super.c           | 4 +++-
 lib/iov_iter.c       | 3 ++-
 6 files changed, 18 insertions(+), 3 deletions(-)
