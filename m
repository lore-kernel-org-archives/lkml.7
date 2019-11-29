Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE9BC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 19:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C131921721
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 19:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575056903;
	bh=v3DsA2LNxLFq0aGOJswSI4TX6+ZN4PkKHVs9ZwrqgvY=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=0VP/jMnqfNPLi3iDc/0VcP2WjsCN9jdAuD82k7OtHd4MFSielyZmrw3AcG8XqgD2W
	 p4DHZhAjTMkSRMZH+ya8e9T55X6MBM37lsKF6PdgXuKuXhqrphST2zwNAB1TW32T46
	 lxmhe4KCrqP5pE968exG2fpe2ts8DkuzotEneV4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfK2Tqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 14:46:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:42244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbfK2Tqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 14:46:54 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6FAB216F4;
        Fri, 29 Nov 2019 19:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575056812;
        bh=v3DsA2LNxLFq0aGOJswSI4TX6+ZN4PkKHVs9ZwrqgvY=;
        h=Date:From:To:cc:Subject:From;
        b=VljVSUbz7J9eetmNNeTGPz4pWrr0pwIEFo0SPO3AVJfHt6G45lm580m7xU2FXDieq
         XTLJ3o2hkbQ9B0NW9V5VwQa2wxv2WB+2O4vbF7v1im0fGkkCqCoSLc5PZVeRmvufri
         Qh8sqyWH9R9/wZD2DqT2Iyg9STkVEJMIztBCeUbQ=
Date:   Fri, 29 Nov 2019 20:46:49 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID for 5.5
Message-ID: <nycvar.YFH.7.76.1911292041280.1799@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive 5.5 queue for HID susbsytem:

=====
- Support for Logitech G15 (Hans de Goede)
- HID parser improvements, improving support for some devices;
  e.g. Windows Precision Touchpad, products from Primax, etc.
  (Bla¸ Hrastnik, Candle Sun)
- robustification of tablet mode support in google-whiskers driver (Dmitry 
  Torokhov)
- assorted small fixes, device-specific quirks and device ID additions
=====

Thanks.

----------------------------------------------------------------
Aaron Ma (1):
      HID: i2c-hid: fix no irq after reset on raydium 3118

Andrew Duggan (1):
      HID: rmi: Check that the RMI_STARTED bit is set before unregistering the RMI transport device

Bla¸ Hrastnik (1):
      HID: Improve Windows Precision Touchpad detection.

Candle Sun (1):
      HID: core: check whether Usage Page item is after Usage ID items

Dmitry Torokhov (3):
      HID: google: whiskers: more robust tablet mode detection
      HID: google: whiskers: signal tablet mode switch on disconnect
      HID: google: whiskers: signal tablet mode on connect

Geert Uytterhoeven (1):
      HID: intel-ish-hid: Spelling s/diconnect/disconnect/

Hans de Goede (9):
      Input: Add event-codes for macro keys found on various keyboards
      HID: Add driver for Logitech gaming keyboards (G15, G15 v2)
      HID: lg-g15: Add keyboard and LCD backlight control
      HID: lg-g15: Add support for the M1-M3 and MR LEDs
      HID: lg-g15: Add support for the G510 keyboards' gaming keys
      HID: lg-g15: Add support for controlling the G510's RGB backlight
      HID: lg-g15: Add support for the G510's M1-M3 and MR LEDs
      HID: logitech: Add depends on LEDS_CLASS to Logitech Kconfig entry
      HID: logitech-hidpp: Silence intermittent get_battery_capacity errors

Heiner Kallweit (1):
      HID: quirks: remove hid-led devices from hid_have_special_driver

Jinke Fan (1):
      HID: quirks: Add quirk for HP MSU1465 PIXART OEM mouse

Kai-Heng Feng (1):
      HID: i2c-hid: Reset ALPS touchpads on resume

Nicolas Boichat (1):
      HID: google: Detect base folded usage instead of hard-coding whiskers

Rishi Gupta (1):
      HID: hidraw: replace printk() with corresponding pr_xx() variant

You-Sheng Yang (1):
      HID: i2c-hid: remove orphaned member sleep_delay

 MAINTAINERS                            |   7 +
 drivers/hid/Kconfig                    |   1 +
 drivers/hid/Makefile                   |   1 +
 drivers/hid/hid-core.c                 |  55 +-
 drivers/hid/hid-google-hammer.c        | 146 ++++--
 drivers/hid/hid-ids.h                  |   6 +
 drivers/hid/hid-lg-g15.c               | 899 +++++++++++++++++++++++++++++++++
 drivers/hid/hid-logitech-hidpp.c       |   3 +
 drivers/hid/hid-quirks.c               |   8 +-
 drivers/hid/hid-rmi.c                  |   3 +-
 drivers/hid/hidraw.c                   |  10 +-
 drivers/hid/i2c-hid/i2c-hid-core.c     |  16 +-
 drivers/hid/intel-ish-hid/ishtp/hbm.c  |   2 +-
 include/uapi/linux/input-event-codes.h |  75 +++
 14 files changed, 1166 insertions(+), 66 deletions(-)
 create mode 100644 drivers/hid/hid-lg-g15.c

-- 
Jiri Kosina
SUSE Labs

