Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5085EC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 01:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28AFB20644
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 01:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfIQBlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 21:41:03 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36428 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbfIQBlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 21:41:02 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iA2UH-0004mL-FE; Tue, 17 Sep 2019 01:41:01 +0000
Date:   Tue, 17 Sep 2019 02:41:01 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] work.mount - infrastructure
Message-ID: <20190917014101.GF1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Infrastructure bits of mount API conversions; the rest is
more of per-filesystem patches and it'll go in a separate pull
request.  Requests, actually, since some are (thankfully) in
the individual filesystem trees now (a huge NFS pile, for example).

The following changes since commit d1abaeb3be7b5fa6d7a1fbbd2e14e3310005c4c1:

  Linux 5.3-rc5 (2019-08-18 14:31:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount-base

for you to fetch changes up to 0f071004109d9c8de7023b9a64fa2ba3fa87cbed:

  mtd: Provide fs_context-aware mount_mtd() replacement (2019-09-05 14:34:23 -0400)

----------------------------------------------------------------
Al Viro (1):
      new helper: get_tree_keyed()

David Howells (2):
      vfs: Create fs_context-aware mount_bdev() replacement
      mtd: Provide fs_context-aware mount_mtd() replacement

Eric Biggers (1):
      vfs: set fs_context::user_ns for reconfigure

 drivers/mtd/mtdcore.h      |   1 +
 drivers/mtd/mtdsuper.c     | 179 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/fs_context.c            |   4 +-
 fs/nfsd/nfsctl.c           |   3 +-
 fs/proc/root.c             |   3 +-
 fs/super.c                 | 104 ++++++++++++++++++++++++++
 include/linux/fs_context.h |  12 ++-
 include/linux/mtd/super.h  |   3 +
 ipc/mqueue.c               |   3 +-
 net/sunrpc/rpc_pipe.c      |   3 +-
 10 files changed, 301 insertions(+), 14 deletions(-)
