Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022CFC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 20:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7D6207FD
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 20:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfKXUFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 15:05:55 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:51678 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfKXUFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 15:05:54 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iYy8n-0005xh-36; Sun, 24 Nov 2019 20:05:53 +0000
Date:   Sun, 24 Nov 2019 20:05:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] vfs.git fixes
Message-ID: <20191124200553.GC4203@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Regression fix, fallen through the cracks.
The following changes since commit 762c69685ff7ad5ad7fee0656671e20a0c9c864d:

  ecryptfs_lookup_interpose(): lower_dentry->d_parent is not stable either (2019-11-10 11:57:45 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to 3e5aeec0e267d4422a4e740ce723549a3098a4d1:

  cramfs: fix usage on non-MTD device (2019-11-23 21:44:49 -0500)

----------------------------------------------------------------
Maxime Bizon (1):
      cramfs: fix usage on non-MTD device

 fs/cramfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
