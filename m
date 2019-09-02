Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B36DC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 15:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07B02087E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 15:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567438436;
	bh=pghzbeWl3KPThv+7pJa01BvuqNz1rWFn0NoduQIlb60=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=QDHTm9JTSUd3EkcUvtNitG06tUUZjUlgkvdcFrKURwkLDRbEHBszO2BzBs2lajkVl
	 GmTuHr+ADb3XltWRN0bCt5qwWnE4RRyGirXVZqFhp237759XvkI9mO5jjma4PCmiS7
	 QMer5Lb3o/9Uz8aY8I3bQtzWE+FiuiVAkz+V5MVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfIBPdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 11:33:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbfIBPdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 11:33:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47C8A2087E;
        Mon,  2 Sep 2019 15:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567438433;
        bh=pghzbeWl3KPThv+7pJa01BvuqNz1rWFn0NoduQIlb60=;
        h=Date:From:To:Cc:Subject:From;
        b=IIh86nBJ251zD6ZEuIvhY1KFqzBeW54iEAQF21569JuTQAfNlxuzc+skPYuX+g9/p
         0PCumn2ggdS8lHtYbQe1UEnLW4eZZsXvoTTZZP/qrv/14tv1zGt9qGdTTbZZGz1c7G
         C1mDiQ0FO3sR44M2PbKYIO+Ic/HLS6kofJ6S3mWQ=
Date:   Mon, 2 Sep 2019 17:33:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.3-rc7
Message-ID: <20190902153351.GA9779@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d1abaeb3be7b5fa6d7a1fbbd2e14e3310005c4c1:

  Linux 5.3-rc5 (2019-08-18 14:31:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.3-rc7

for you to fetch changes up to 1426bd2c9f7e3126e2678e7469dca9fd9fc6dd3e:

  USB: cdc-wdm: fix race between write and disconnect due to flag abuse (2019-08-28 22:48:38 +0200)

----------------------------------------------------------------
USB fixes for 5.3-rc7

Here are some small USB fixes that have been in linux-next this past
week for 5.3-rc7

They fix the usual xhci, syzbot reports, and other small issues that
have come up last week.

All have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Colin Ian King (1):
      typec: tcpm: fix a typo in the comparison of pdo_max_voltage

Geert Uytterhoeven (1):
      usb: host: xhci: rcar: Fix typo in compatible string matching

Gustavo A. R. Silva (1):
      usb: udc: lpc32xx: silence fall-through warning

Henk van der Laan (1):
      usb-storage: Add new JMS567 revision to unusual_devs

Kai-Heng Feng (2):
      USB: storage: ums-realtek: Update module parameter description for auto_delink_en
      USB: storage: ums-realtek: Whitelist auto-delink support

Nagarjuna Kristam (1):
      usb: host: xhci-tegra: Set DMA mask correctly

Oliver Neukum (2):
      usbtmc: more sanity checking for packet size
      USB: cdc-wdm: fix race between write and disconnect due to flag abuse

Peter Chen (1):
      usb: chipidea: udc: don't do hardware access if gadget has stopped

Schmid, Carsten (1):
      usb: hcd: use managed device resources

Yoshihiro Shimoda (1):
      usb: host: ohci: fix a race condition between shutdown and irq

 drivers/usb/chipidea/udc.c           | 32 ++++++++++++++++++++++++--------
 drivers/usb/class/cdc-wdm.c          | 16 ++++++++++++----
 drivers/usb/class/usbtmc.c           |  3 +++
 drivers/usb/core/hcd-pci.c           | 30 ++++++++----------------------
 drivers/usb/gadget/udc/lpc32xx_udc.c |  2 +-
 drivers/usb/host/ohci-hcd.c          | 15 ++++++++++++---
 drivers/usb/host/xhci-rcar.c         |  2 +-
 drivers/usb/host/xhci-tegra.c        | 10 ++++++++++
 drivers/usb/storage/realtek_cr.c     | 15 +++++++++------
 drivers/usb/storage/unusual_devs.h   |  2 +-
 drivers/usb/typec/tcpm/tcpm.c        |  2 +-
 11 files changed, 82 insertions(+), 47 deletions(-)
