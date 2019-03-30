Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A739CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2812184D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553936610;
	bh=HC/LzwoMId+8km5QVzkQX3m8VSnNWD1+PF8L9bwGKvQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=XZMhJnC/VzwSSiW6LOce+KAAOFA84OQSmNTKPee1EEZfbModgH3cVGgSfkAQOc9oG
	 ca2f/+lcms2EkRv2h+VcWDslEPH5I7GKwXt/KSzU7/GvVxYGhQE5+ZziYZU89Ovy56
	 /rCHJ6e9j9akF4WK50Ghu9SsgEQOv2XlRfSEjEs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbfC3JD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 05:03:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730372AbfC3JD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 05:03:28 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95FBB2184D;
        Sat, 30 Mar 2019 09:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553936607;
        bh=HC/LzwoMId+8km5QVzkQX3m8VSnNWD1+PF8L9bwGKvQ=;
        h=Date:From:To:Cc:Subject:From;
        b=BsCl9ZakcD4WsuVoid/9JQptYlOFRJVhSn9zgiBJN3x7U5elcphO+20R3UpTYfjrh
         S9RWIhFVY0u/LscjyttGYTw7WeQbpeXZZ9I8RKrW0zxIamWBwbVi4jG7IZiCQoHeCm
         2eWr3P2i3y2PGG9JtDrZeWZSpJu8s8CPwZYSkF2M=
Date:   Sat, 30 Mar 2019 10:03:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.1-rc3
Message-ID: <20190330090323.GA5549@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.1-rc3

for you to fetch changes up to d65d25b84f1f19cc35819a733576cafc54adc275:

  Merge tag 'usb-serial-5.1-rc3' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (2019-03-29 15:31:16 +0100)

----------------------------------------------------------------
USB fixes for 5.1-rc3

Here are some small USB fixes for 5.1-rc3.

Nothing major at all here, just a small collection of fixes for reported
issues, and potential problems with error handling paths.  Also a few
new device ids, as normal.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aditya Pakki (1):
      usb: usb251xb: fix to avoid potential NULL pointer dereference

Arnd Bergmann (1):
      usb: mtu3: fix EXTCON dependency

Bjørn Mork (1):
      USB: serial: option: add Olicard 600

Chen-Yu Tsai (2):
      phy: sun4i-usb: Support set_mode to USB_HOST for non-OTG PHYs
      usb: core: Try generic PHY_MODE_USB_HOST if usb_phy_roothub_set_mode fails

Fabrizio Castro (1):
      usb: common: Consider only available nodes for dr_mode

Felipe Balbi (1):
      usb: dwc3: pci: add support for Comet Lake PCH ID

George McCollister (1):
      USB: serial: ftdi_sio: add additional NovaTech products

Greg Kroah-Hartman (3):
      USB: serial: cp210x: add new device id
      Merge tag 'fixes-for-v5.1-rc2' of git://git.kernel.org/.../balbi/usb into usb-linus
      Merge tag 'usb-serial-5.1-rc3' of https://git.kernel.org/.../johan/usb-serial into usb-linus

Guido Kiener (3):
      usb: gadget: net2280: Fix overrun of OUT messages
      usb: gadget: net2280: Fix net2280_dequeue()
      usb: gadget: net2272: Fix net2272_dequeue()

Gustavo A. R. Silva (2):
      usb: typec: Fix unchecked return value
      usb: usb251xb: Remove unnecessary comparison of unsigned integer with >= 0

Hans de Goede (1):
      usb: typec: tcpm: Try PD-2.0 if sink does not respond to 3.0 source-caps

Kristian Evensen (1):
      USB: serial: option: add support for Quectel EM12

Lin Yi (1):
      USB: serial: mos7720: fix mos_parport refcount imbalance on error path

Mans Rullgard (1):
      USB: serial: option: set driver_info for SIM5218 and compatibles

Mathias Nyman (3):
      xhci: Fix port resume done detection for SS ports with LPM enabled
      usb: xhci: dbc: Don't free all memory with spinlock held
      xhci: Don't let USB3 ports stuck in polling state prevent suspend

Mukesh Ojha (1):
      usb: u132-hcd: fix resource leak

Radoslav Gerganov (1):
      USB: gadget: f_hid: fix deadlock in f_hidg_write()

Romain Izard (1):
      usb: cdc-acm: fix race during wakeup blocking TX traffic

Yasushi Asano (1):
      usb: host: xhci-rcar: Add XHCI_TRUST_TX_LENGTH quirk

 drivers/phy/allwinner/phy-sun4i-usb.c |  5 ++++-
 drivers/usb/class/cdc-acm.c           |  4 +---
 drivers/usb/common/common.c           |  2 ++
 drivers/usb/core/hcd.c                |  3 +++
 drivers/usb/dwc3/dwc3-pci.c           |  4 ++++
 drivers/usb/gadget/function/f_hid.c   |  6 +++---
 drivers/usb/gadget/udc/net2272.c      |  1 +
 drivers/usb/gadget/udc/net2280.c      |  8 +++-----
 drivers/usb/host/u132-hcd.c           |  3 +++
 drivers/usb/host/xhci-dbgcap.c        |  5 +++--
 drivers/usb/host/xhci-hub.c           | 19 ++++++++++++-------
 drivers/usb/host/xhci-rcar.c          |  1 +
 drivers/usb/host/xhci-ring.c          |  9 ++++++---
 drivers/usb/host/xhci.h               |  8 ++++++++
 drivers/usb/misc/usb251xb.c           |  4 ++--
 drivers/usb/mtu3/Kconfig              |  1 +
 drivers/usb/serial/cp210x.c           |  1 +
 drivers/usb/serial/ftdi_sio.c         |  2 ++
 drivers/usb/serial/ftdi_sio_ids.h     |  4 +++-
 drivers/usb/serial/mos7720.c          |  4 ++--
 drivers/usb/serial/option.c           | 17 ++++++++++++-----
 drivers/usb/typec/tcpm/tcpm.c         | 27 ++++++++++++++++++++++++++-
 drivers/usb/typec/tcpm/wcove.c        |  9 +++++++--
 23 files changed, 110 insertions(+), 37 deletions(-)
