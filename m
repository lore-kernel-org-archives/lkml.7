Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DBEC43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 15:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722A3214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 15:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576337237;
	bh=BSQVMNbCG4fPWQgnA5zQnefINcUCM9LyOPamsJUyTn4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=oYNdjvcTtMkoOKWF9gNDtyHgcAnggslfgnPHGChv/CJfGTD2DS7wwpiOhJtL1WeOE
	 FH67fooO0xjli57VV16zlcAWVNLz2o83PhFIUgt4ocYeqkCeij+idUxaG3E3Tl6bzj
	 SvmfwjzdqTzdXUeRocYya12En6LBB7QFJdB8zLPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfLNP1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 10:27:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfLNP1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 10:27:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FB81214AF;
        Sat, 14 Dec 2019 15:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576337234;
        bh=BSQVMNbCG4fPWQgnA5zQnefINcUCM9LyOPamsJUyTn4=;
        h=Date:From:To:Cc:Subject:From;
        b=FrfF6ta7pG8uH+lmGTQdjWhywN/vzP2tdnS7wj7SxDGaLDYNjcfDqcMgdktGoOc+9
         oMiX3oxOc23G4rfssfLsjFZmHKZl1N6/bATKau1MKiBhQi97OByuSirPxF99H35Wsj
         YuVIl7fSKbycMV1TU69ErD1QQm8IhmdLjQrpcNa4=
Date:   Sat, 14 Dec 2019 16:27:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.5-rc2
Message-ID: <20191214152712.GA3459916@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.5-rc2

for you to fetch changes up to 3c3caae4cd6e122472efcf64759ff6392fb6bce2:

  usb: dwc3: pci: add ID for the Intel Comet Lake -H variant (2019-12-12 14:02:37 +0100)

----------------------------------------------------------------
USB driver fixes for 5.5-rc2

Here are some small USB driver fixes for reported issues for 5.5-rc2

There's the usual gadget and xhci fixes, as well as some other problems
that syzbot has been finding during it's fuzzing runs.  Full details are
in the shortlog.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Bryan O'Donoghue (1):
      usb: common: usb-conn-gpio: Don't log an error on probe deferral

EJ Hsu (1):
      usb: gadget: fix wrong endpoint desc

Emiliano Ingrassia (1):
      usb: core: urb: fix URB structure initialization function

Fredrik Noring (1):
      USB: Fix incorrect DMA allocations for local memory pool drivers

Greg Kroah-Hartman (1):
      Merge tag 'fixes-for-v5.5-rc2' of git://git.kernel.org/.../balbi/usb into usb-linus

Heikki Krogerus (1):
      usb: dwc3: pci: add ID for the Intel Comet Lake -H variant

Henry Lin (1):
      usb: xhci: only set D3hot for pci device

Johan Hovold (4):
      USB: serial: io_edgeport: fix epic endpoint lookup
      USB: idmouse: fix interface sanity checks
      USB: adutux: fix interface sanity check
      USB: atm: ueagle-atm: add missing endpoint check

Kai-Heng Feng (1):
      xhci: Increase STS_HALT timeout in xhci_suspend()

Mathias Nyman (3):
      xhci: fix USB3 device initiated resume race with roothub autosuspend
      xhci: handle some XHCI_TRUST_TX_LENGTH quirks cases as default behaviour.
      xhci: make sure interrupts are restored to correct state

Mika Westerberg (1):
      xhci: Fix memory leak in xhci_add_in_port()

Pete Zaitcev (1):
      usb: mon: Fix a deadlock in usbmon between mmap and read

Tejas Joglekar (1):
      usb: dwc3: gadget: Fix logical condition

Thinh Nguyen (2):
      usb: dwc3: gadget: Clear started flag for non-IOC
      usb: dwc3: ep0: Clear started flag on completion

Wen Yang (2):
      usb: roles: fix a potential use after free
      usb: typec: fix use after free in typec_register_port()

 drivers/usb/atm/ueagle-atm.c          | 18 ++++++++++-----
 drivers/usb/common/usb-conn-gpio.c    |  3 ++-
 drivers/usb/core/hcd.c                | 42 +++++++++++++++++------------------
 drivers/usb/core/urb.c                |  1 +
 drivers/usb/dwc3/dwc3-pci.c           |  6 ++++-
 drivers/usb/dwc3/ep0.c                |  8 +++++++
 drivers/usb/dwc3/gadget.c             |  5 ++++-
 drivers/usb/gadget/function/f_ecm.c   |  6 ++++-
 drivers/usb/gadget/function/f_rndis.c |  1 +
 drivers/usb/host/xhci-hub.c           | 22 +++++++++++++-----
 drivers/usb/host/xhci-mem.c           |  4 ++++
 drivers/usb/host/xhci-pci.c           | 13 +++++++++++
 drivers/usb/host/xhci-ring.c          |  6 ++---
 drivers/usb/host/xhci.c               |  9 +++-----
 drivers/usb/host/xhci.h               |  1 +
 drivers/usb/misc/adutux.c             |  2 +-
 drivers/usb/misc/idmouse.c            |  2 +-
 drivers/usb/mon/mon_bin.c             | 32 +++++++++++++++++---------
 drivers/usb/roles/class.c             |  2 +-
 drivers/usb/serial/io_edgeport.c      | 10 +++++----
 drivers/usb/storage/scsiglue.c        |  3 ++-
 drivers/usb/typec/class.c             |  6 +++--
 22 files changed, 135 insertions(+), 67 deletions(-)
