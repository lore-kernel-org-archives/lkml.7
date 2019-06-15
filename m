Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CEAC31E52
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 15:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C17F20673
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 15:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560613730;
	bh=Ge0khhEctwDDjsAI9a281lx6Be7hNKcUJhcPMGAOz8I=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=GWMB5ibhcoGfFNyfFq0/MtQSUD+NjaCjIo7edkw2TVN20WWPZxAM3mDcKsyfngpwK
	 yUr5K8nzeDO7t2BLsbdQjfpEi2ipXOpkptK0MdPpHy+pmfEReOWX9AwSEDCJaWSZGH
	 itlp3AlNRn8De45NC6wBQaOg9qedl5bj4vil9/Vc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfFOPst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 11:48:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbfFOPst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 11:48:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB12B20673;
        Sat, 15 Jun 2019 15:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560613728;
        bh=Ge0khhEctwDDjsAI9a281lx6Be7hNKcUJhcPMGAOz8I=;
        h=Date:From:To:Cc:Subject:From;
        b=NfW/aNUcnLsxHEl4s7R2zYbGx7CDtl/GkQplUAoY+vQUgH1dexOgXY6RttRpLh1s/
         55p8PAysM+MA6JXX+12kSPGZ8ZjGtp2mJyPeX8joKuc/Uz4oHa/IcLNJDn9YYeLYk+
         x1USUq8htT21amMWl7udsdE+OuG3/q+HS0W16dKw=
Date:   Sat, 15 Jun 2019 17:48:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.2-rc5
Message-ID: <20190615154845.GA6603@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:

  Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.2-rc5

for you to fetch changes up to 5f54a85db5df67df8161739a4b2f9c2b7ab219fe:

  usb: typec: Make sure an alt mode exist before getting its partner (2019-06-12 17:13:02 +0200)

----------------------------------------------------------------
USB fixes for 5.2-rc5

Here are some small USB driver fixes for 5.2-rc5

Nothing major, just some small gadget fixes, usb-serial new device ids,
a few new quirks, and some small fixes for some regressions that have
been found after the big 5.2-rc1 merge.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexandre Belloni (1):
      usb: gadget: udc: lpc32xx: allocate descriptor with GFP_ATOMIC

Andrey Smirnov (1):
      usb: phy: mxs: Disable external charger detect in mxs_phy_hw_init()

Andrzej Pietrasiewicz (1):
      usb: gadget: dwc2: fix zlp handling

Chris Packham (1):
      USB: serial: pl2303: add Allied Telesis VT-Kit3

Daniele Palmas (1):
      USB: serial: option: add Telit 0x1260 and 0x1261 compositions

Douglas Anderson (1):
      usb: dwc2: host: Fix wMaxPacketSize handling (fix webcam regression)

Greg Kroah-Hartman (2):
      Merge tag 'fixes-for-v5.2-rc4' of git://git.kernel.org/.../balbi/usb into usb-linus
      Merge tag 'usb-serial-5.2-rc5' of https://git.kernel.org/.../johan/usb-serial into usb-linus

Gustavo A. R. Silva (1):
      usb: typec: ucsi: ccg: fix memory leak in do_flash

Heikki Krogerus (1):
      usb: typec: Make sure an alt mode exist before getting its partner

Jörgen Storvist (1):
      USB: serial: option: add support for Simcom SIM7500/SIM7600 RNDIS mode

Kai-Heng Feng (1):
      USB: usb-storage: Add new ID to ums-realtek

Marco Zatta (1):
      USB: Fix chipmunk-like voice when using Logitech C270 for recording audio.

Martin Schiller (1):
      usb: dwc2: Fix DMA cache alignment issues

Minas Harutyunyan (1):
      usb: dwc2: Set actual frame number for completed ISOC transfer for none DDMA

Wei Yongjun (1):
      usb: gadget: udc: lpc32xx: fix return value check in lpc32xx_udc_probe()

Young Xiao (1):
      usb: gadget: fusb300_udc: Fix memory leak of fusb300->ep[i]

 drivers/usb/core/quirks.c             |  3 +++
 drivers/usb/dwc2/gadget.c             | 24 ++++++++++++++-------
 drivers/usb/dwc2/hcd.c                | 39 +++++++++++++++++++++--------------
 drivers/usb/dwc2/hcd.h                | 20 ++++++++++--------
 drivers/usb/dwc2/hcd_intr.c           |  5 +++--
 drivers/usb/dwc2/hcd_queue.c          | 10 +++++----
 drivers/usb/gadget/udc/fusb300_udc.c  |  5 +++++
 drivers/usb/gadget/udc/lpc32xx_udc.c  |  7 +++----
 drivers/usb/phy/phy-mxs-usb.c         | 14 +++++++++++++
 drivers/usb/serial/option.c           |  6 ++++++
 drivers/usb/serial/pl2303.c           |  1 +
 drivers/usb/serial/pl2303.h           |  3 +++
 drivers/usb/storage/unusual_realtek.h |  5 +++++
 drivers/usb/typec/bus.c               |  2 +-
 drivers/usb/typec/ucsi/ucsi_ccg.c     |  6 ++++--
 15 files changed, 105 insertions(+), 45 deletions(-)
