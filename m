Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775CAC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 08:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5711C20823
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 08:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfKYICt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 03:02:49 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51784 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfKYICs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 03:02:48 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 62E8D28DB9C;
        Mon, 25 Nov 2019 08:02:47 +0000 (GMT)
Date:   Mon, 25 Nov 2019 09:02:44 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i3c <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Vitor Soares <vitor.soares@synopsys.com>
Subject: [GIT PULL] i3c: Changes for 5.5
Message-ID: <20191125090244.1ccd14cb@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the I3C PR for 5.5.

Regards,

Boris

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.5

for you to fetch changes up to ae24f2b6f828f4ae37d0f0fd3be4e7744b6aab13:

  MAINTAINERS: add myself as maintainer of Cadence I3C master controller driver (2019-11-14 10:28:51 +0100)

----------------------------------------------------------------
Minor fixes and MAINTAINERS updates

----------------------------------------------------------------
Geert Uytterhoeven (2):
      i3c: Spelling s/dicovered/discovered/
      MAINTAINERS: Mark linux-i3c mailing list moderated

Przemyslaw Gaj (1):
      MAINTAINERS: add myself as maintainer of Cadence I3C master controller driver

Vitor Soares (1):
      i3c: master: use i3c_dev_get_master()

 MAINTAINERS          | 8 +++++++-
 drivers/i3c/master.c | 4 ++--
 2 files changed, 9 insertions(+), 3 deletions(-)
