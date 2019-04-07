Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EDAC10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 14:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45AA5213F2
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 14:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfDGOid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 10:38:33 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:47734 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfDGOic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 10:38:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C37D4608A3BD;
        Sun,  7 Apr 2019 16:38:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qpxB1NUzoaBF; Sun,  7 Apr 2019 16:38:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 642FD608A394;
        Sun,  7 Apr 2019 16:38:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Lyek5CjC7P0u; Sun,  7 Apr 2019 16:38:30 +0200 (CEST)
Received: from blindfold.localnet (unknown [195.149.217.187])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 0F3636089E22;
        Sun,  7 Apr 2019 16:38:29 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds@linux-foundation.org
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MTD fixes for 5.1-rc4
Date:   Sun, 07 Apr 2019 16:38:29 +0200
Message-ID: <8693488.C880lHxeKj@blindfold>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00:

  Linux 5.1-rc2 (2019-03-24 14:02:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.1-rc4

for you to fetch changes up to d9b8a67b3b95a5c5aae6422b8113adc1c2485f2b:

  mtd: cfi: fix deadloop in cfi_cmdset_0002.c do_write_buffer (2019-04-05 00:39:19 +0200)

----------------------------------------------------------------
This pull request contains a single fix for MTD:

- Fix for a possible infinite loop in the cfi_cmdset_0002 driver

----------------------------------------------------------------
Liu Jian (1):
      mtd: cfi: fix deadloop in cfi_cmdset_0002.c do_write_buffer

 drivers/mtd/chips/cfi_cmdset_0002.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)



