Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3906C282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 09:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C0621855
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 09:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbfDTJXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 05:23:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39678 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDTJXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 05:23:44 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3E3D026BB81;
        Sat, 20 Apr 2019 10:23:43 +0100 (BST)
Date:   Sat, 20 Apr 2019 11:23:40 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i3c <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
Subject: [GIT PULL] i3c: Fixes for 5.1-rc6
Message-ID: <20190420112340.24be3932@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the I3C fixes PR for 5.1-rc6.

Regards,

Boris

The following changes since commit 15ade5d2e7775667cf191cf2f94327a4889f8b9d:

  Linux 5.1-rc4 (2019-04-07 14:09:59 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/fixes-for-5.1-rc6

for you to fetch changes up to 709a53e1948494cc4f6c4636c6f84a4d36a8117e:

  MAINTAINERS: Fix the I3C entry (2019-04-10 12:47:55 +0200)

----------------------------------------------------------------
- Fix the random PID check
- Fix the disable controller logic in the designware driver
- Fix I3C entry in MAINTAINERS

----------------------------------------------------------------
Boris Brezillon (1):
      MAINTAINERS: Fix the I3C entry

Vitor Soares (2):
      i3c: Fix the verification of random PID
      i3c: dw: Fix dw_i3c_master_disable controller by using correct mask

 MAINTAINERS                        | 1 -
 drivers/i3c/master.c               | 5 ++---
 drivers/i3c/master/dw-i3c-master.c | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)
