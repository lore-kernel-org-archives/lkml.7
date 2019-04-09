Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0999CC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 23:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D410D20850
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 23:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfDIXMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 19:12:05 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:55118 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfDIXMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 19:12:05 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hDzuN-00010p-F2; Tue, 09 Apr 2019 23:12:03 +0000
Date:   Wed, 10 Apr 2019 00:12:03 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] several fixes
Message-ID: <20190409231203.GP2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	A few regression fixes from this cycle

The following changes since commit 5e7a8ca319268a70a6c7c3c1fde5bea38e1e5539:

  Merge branch 'work.aio' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2019-04-01 08:28:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to 6af1c849dfb1f1d326fbdd157c9bc882b921f450:

  aio: use kmem_cache_free() instead of kfree() (2019-04-04 20:13:59 -0400)

----------------------------------------------------------------
Dan Carpenter (1):
      aio: Fix an error code in __io_submit_one()

Wei Yongjun (1):
      aio: use kmem_cache_free() instead of kfree()

YueHaibing (1):
      iov_iter: Fix build error without CONFIG_CRYPTO

 fs/aio.c       | 4 ++--
 lib/iov_iter.c | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)
