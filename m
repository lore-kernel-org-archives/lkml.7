Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851B2C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642C4217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfI0O1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 10:27:43 -0400
Received: from nautica.notk.org ([91.121.71.147]:35603 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbfI0O1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 10:27:43 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 06DF6C009; Fri, 27 Sep 2019 16:27:41 +0200 (CEST)
Date:   Fri, 27 Sep 2019 16:27:26 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [GIT PULL] 9p updates for 5.4
Message-ID: <20190927142725.GA8169@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Some of the usual small fixes and cleanup.

I didn't get the target version wrong this time! :)


The following changes since commit 089cf7f6ecb266b6a4164919a2e69bd2f938374a:

  Linux 5.3-rc7 (2019-09-02 09:57:40 -0700)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-5.4

for you to fetch changes up to aafee43b72863f1f70aeaf1332d049916e8df239:

  9p/vfs_super.c: Remove unused parameter data in v9fs_fill_super
  (2019-09-03 11:10:13 +0000)

----------------------------------------------------------------
9p pull request for inclusion in 5.4

Small fixes all around:
 - avoid overlayfs copy-up for PRIVATE mmaps
 - KUMSAN uninitialized warning for transport error
 - one syzbot memory leak fix in 9p cache
 - internal API cleanup for v9fs_fill_super

----------------------------------------------------------------
Bharath Vedartham (2):
      9p/cache.c: Fix memory leak in v9fs_cache_session_get_cookie
      9p/vfs_super.c: Remove unused parameter data in v9fs_fill_super

Chengguang Xu (1):
      9p: avoid attaching writeback_fid on mmap with type PRIVATE

Lu Shuaibing (1):
      9p: Transport error uninitialized

 fs/9p/cache.c     | 2 ++
 fs/9p/vfs_file.c  | 3 +++
 fs/9p/vfs_super.c | 4 ++--
 net/9p/client.c   | 1 +
 4 files changed, 8 insertions(+), 2 deletions(-)

Cheers,
-- 
Dominique | Asmadeus
