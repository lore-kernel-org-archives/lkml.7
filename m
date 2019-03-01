Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F89CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C1A2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbfCAJcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 04:32:20 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57084 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbfCAJcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 04:32:20 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8E6F7280A3A;
        Fri,  1 Mar 2019 09:32:18 +0000 (GMT)
Date:   Fri, 1 Mar 2019 10:32:15 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-i3c <linux-i3c@lists.infradead.org>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
Subject: [GIT PULL] i3c: Changes for 5.1
Message-ID: <20190301103215.4ee6e758@collabora.com>
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

I know the merge window is not opened yet, but I'll be on vacation next
week, so I'm sending my I3C PR a bit earlier this time (already sent the
MTD one earlier this week, but for a different reason: I didn't check if
there was an -rc8 :)).

Regards,

Boris

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.1

for you to fetch changes up to 988bb4a1937bd083267444dda21b901dc6a959b3:

  i3c: master: dw-i3c-master: mark expected switch fall-through (2019-02-28 09:47:53 +0100)

----------------------------------------------------------------
- Add a /* fall-through */ comment in the dw-i3c-master driver
- Update the I3C entries in MAINTAINERS to add an IRC chan

----------------------------------------------------------------
Boris Brezillon (1):
      MAINTAINERS: Add an IRC channel for the I3C subsystem

Gustavo A. R. Silva (1):
      i3c: master: dw-i3c-master: mark expected switch fall-through

 MAINTAINERS                        | 1 +
 drivers/i3c/master/dw-i3c-master.c | 1 +
 2 files changed, 2 insertions(+)
