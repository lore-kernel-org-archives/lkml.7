Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213AFC4CEC4
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 07:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F20206C2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 07:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437743AbfIUHgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 03:36:47 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:53000 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437704AbfIUHgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 03:36:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7DCC7613E499;
        Sat, 21 Sep 2019 09:36:42 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pDRSi2FE9BcI; Sat, 21 Sep 2019 09:36:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 36990613E49B;
        Sat, 21 Sep 2019 09:36:42 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 74EVnzMEAycD; Sat, 21 Sep 2019 09:36:42 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 171ED613E499;
        Sat, 21 Sep 2019 09:36:42 +0200 (CEST)
Date:   Sat, 21 Sep 2019 09:36:42 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <1224182178.3529.1569051402039.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UBI/UBIFS/JFFS2 updates for 5.4-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Index: XWVcrwQH697MbsYhdr9Nkm4o9xdpbw==
Thread-Topic: UBI/UBIFS/JFFS2 updates for 5.4-rc1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 089cf7f6ecb266b6a4164919a2e69bd2f938374a:

  Linux 5.3-rc7 (2019-09-02 09:57:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/upstream-5.4-rc1

for you to fetch changes up to 6a379f67454a3c740671ed6c7793b76ffecef50b:

  jffs2: Fix memory leak in jffs2_scan_eraseblock() error path (2019-09-15 22:42:41 +0200)

Please note that there is a small merge conflict between
9163e0184bd7d5f ("ubifs: Fix memory leak bug in alloc_ubifs_info() error path")
from UBIFS tree and 

50d7aad57710e2b ("vfs: Convert ubifs to use the new mount API")
from VFS tree.

----------------------------------------------------------------
This pull request contains the following changes for UBI, UBIFS and JFFS2:

UBI:
- Be less stupid when placing a fastmap anchor
- Try harder to get an empty PEB in case of contention
- Make ubiblock to warn if image is not a multiple of 512

UBIFS:
- Various fixes in error paths

JFFS2:
- Various fixes in error paths

----------------------------------------------------------------
Christoph Hellwig (1):
      jffs2: Remove jffs2_gc_fetch_page and jffs2_gc_release_page

Colin Ian King (1):
      ubifs: Remove redundant assignment to pointer fname

Jia-Ju Bai (1):
      jffs2: Fix possible null-pointer dereferences in jffs2_add_frag_to_fragtree()

Richard Weinberger (2):
      ubi: Don't do anchor move within fastmap area
      ubi: block: Warn if volume size is not multiple of 512

Wenwen Wang (4):
      ubifs: Fix memory leak in read_znode() error path
      ubifs: Fix memory leak in __ubifs_node_verify_hmac error path
      ubifs: Fix memory leak bug in alloc_ubifs_info() error path
      jffs2: Fix memory leak in jffs2_scan_eraseblock() error path

Zhihao Cheng (1):
      ubi: ubi_wl_get_peb: Increase the number of attempts while getting PEB

 drivers/mtd/ubi/block.c      | 43 +++++++++++++++++++++++++++++++++++--------
 drivers/mtd/ubi/fastmap-wl.c |  6 +++---
 drivers/mtd/ubi/wl.c         |  6 ++++++
 fs/jffs2/fs.c                | 27 ---------------------------
 fs/jffs2/gc.c                | 21 +++++++++++++--------
 fs/jffs2/nodelist.c          |  2 +-
 fs/jffs2/os-linux.h          |  3 ---
 fs/jffs2/scan.c              |  5 ++++-
 fs/ubifs/auth.c              |  4 +++-
 fs/ubifs/debug.c             |  1 -
 fs/ubifs/super.c             |  4 +++-
 fs/ubifs/tnc_misc.c          |  1 +
 12 files changed, 69 insertions(+), 54 deletions(-)
