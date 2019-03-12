Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228C8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA03F2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfCLPOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:14:07 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:51828 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLPOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:14:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C8BD36074BAB;
        Tue, 12 Mar 2019 16:14:05 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6S2-0PNpPCZ5; Tue, 12 Mar 2019 16:14:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7D09260B628A;
        Tue, 12 Mar 2019 16:14:05 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id K3cJTxhT5G1r; Tue, 12 Mar 2019 16:14:05 +0100 (CET)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 397B4609187B;
        Tue, 12 Mar 2019 16:14:05 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds@linux-foundation.org
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] UML updates for 5.1-rc1
Date:   Tue, 12 Mar 2019 16:14:04 +0100
Message-ID: <31705653.NnsrL61LRB@blindfold>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 1c163f4c7b3f621efff9b28a47abb36f7378d783:

  Linux 5.0 (2019-03-03 15:21:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-5.1-rc1

for you to fetch changes up to aea05eb56e47046de1e5b508d40931dca969f1e5:

  um: Fix for a possible OOPS in ubd initialization (2019-03-06 22:39:18 +0100)

----------------------------------------------------------------
This pull request contains updates for UML:

- Bugfix for the UML block device driver

----------------------------------------------------------------
Anton Ivanov (1):
      um: Fix for a possible OOPS in ubd initialization

YueHaibing (1):
      um: Remove duplicated include from vector_user.c

 arch/um/drivers/ubd_kern.c    | 6 +++---
 arch/um/drivers/vector_user.c | 3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)



