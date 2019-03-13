Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EF2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C37214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfCMOSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:18:09 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:43264 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfCMOSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:18:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E572C609184E;
        Wed, 13 Mar 2019 15:18:07 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id XWp8lvN4ehiS; Wed, 13 Mar 2019 15:18:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8353C609187E;
        Wed, 13 Mar 2019 15:18:07 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kud4FxutLIA6; Wed, 13 Mar 2019 15:18:07 +0100 (CET)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 477EE609184E;
        Wed, 13 Mar 2019 15:18:07 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds@linux-foundation.org
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] UBI/UBIFS updates for 5.1-rc1 (kernel.org edition)
Date:   Wed, 13 Mar 2019 15:18:06 +0100
Message-ID: <1772241.TFzy4IAa5k@blindfold>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit a3b22b9f11d9fbc48b0291ea92259a5a810e9438:

  Linux 5.0-rc7 (2019-02-17 18:46:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/upstream-5.1-rc1

for you to fetch changes up to 5578e48e5c0bf4684e68ae08caa2293bfb3f5307:

  ubi: wl: Silence uninitialized variable warning (2019-03-05 21:21:07 +0100)

----------------------------------------------------------------
This pull request contains updates for both UBI and UBIFS:

- A new interface for UBI to deal better with read disturb
- Reject unsupported ioctl flags in UBIFS (xfstests found it)

----------------------------------------------------------------
Dan Carpenter (1):
      ubi: wl: Silence uninitialized variable warning

Hou Tao (1):
      ubifs: Reject unsupported ioctl flags explicitly

Richard Weinberger (2):
      ubi: Introduce in_pq()
      ubi: Expose the bitrot interface

 drivers/mtd/ubi/cdev.c      |  30 ++++++++
 drivers/mtd/ubi/ubi.h       |   1 +
 drivers/mtd/ubi/wl.c        | 174 ++++++++++++++++++++++++++++++++++++++++++--
 fs/ubifs/ioctl.c            |   8 ++
 include/uapi/mtd/ubi-user.h |   5 ++
 5 files changed, 211 insertions(+), 7 deletions(-)



