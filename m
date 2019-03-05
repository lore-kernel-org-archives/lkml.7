Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0321EC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB4820684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551798557;
	bh=sRo7jyiAjflDbSlBGQRMU/ebEQYQihWhf6TpLfCNrU4=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=MfCNex31RZHm1Wj3JZAcAUiSPWdpp5cN2Bw0HnKL7BmLId9ryxS/mYeToeQzUeEeQ
	 WFYtEsUPKh6RL69tyNglXtqOhae2a9jw1GUR9B1yvK4s1TVOkscCQEoxsId/W9Yww3
	 CDkEfotM26urpQhVJgQuuY0R8mnluHuQYyDbSxKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfCEPJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:09:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727653AbfCEPJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 10:09:15 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1261420684;
        Tue,  5 Mar 2019 15:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551798554;
        bh=sRo7jyiAjflDbSlBGQRMU/ebEQYQihWhf6TpLfCNrU4=;
        h=Date:From:To:cc:Subject:From;
        b=bdJshlj22S6M5XzDK1q9R0R0kN9YWDwk2ZZOt7PZ/SujGbzVPNC0EZ0mTp86vpGNu
         pWNmqA+ASGKrVNGNGarFAeFsL/LGoomHdd3L2M7WmlVwG0PP54UooTJ0L6QqnnStfX
         dZZ9GUhVr3lE8RRO8maC+hJJvtcWBncpZMZsCruw=
Date:   Tue, 5 Mar 2019 16:09:11 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID for 5.1
Message-ID: <nycvar.YFH.7.76.1903051558000.19912@cbobk.fhfr.pm>
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

to receive HID subsystem updates for 5.1 merge window:

=====
- support for Pro Pen slim, from Jason Gerecke
- power management improvements to Intel-ISH driver, from Song Hongyan
- UCLogic driver revamp in order to be able to support wider range of
  Huion tablets, from Nikolai Kondrashov
- Asus Transbook support, from NOGUCHI Hiroshi
- other assorted small bugfixes / cleanups and device ID additions
=====

Thanks.

----------------------------------------------------------------
Andy Shevchenko (1):
      HID: intel-ish-hid: Switch to use new generic UUID API

Colin Ian King (1):
      HID: elan: Make array buf static, shrinks object size

Gustavo A. R. Silva (2):
      HID: wacom: Mark expected switch fall-through
      HID: roccat: Mark expected switch fall-through

Hans de Goede (1):
      HID: Add support for Toshiba WT10A tablet bluetooth keyboard

Hong Liu (4):
      HID: intel-ish-hid: avoid binding wrong ishtp_cl_device
      HID: intel-ish-hid: Optimize writing ipc message from queue
      HID: intel-ish-hid: move doorbell writing before flush
      HID: intel-ish-hid: remove data[128] usage on stack when sending HBM request

Hongye Yuan (2):
      HID: sony: Transform one-time SHANWAN check into quirk
      HID: sony: Fix SHANWAN PS3 GamePad rumble and led settings support

Jarrad Whitaker (1):
      HID: fix Logitech WingMan Formula GP joined axes

Jason Gerecke (2):
      HID: wacom: Move HID fix for AES serial number into wacom_hid_usage_quirk
      HID: wacom: Add support for Pro Pen slim

Kai-Heng Feng (1):
      HID: i2c-hid: Ignore input report if there's no data present on Elan touchpanels

Mikael Wikström (1):
      HID: multitouch: Lenovo X1 Tablet Gen3 trackpoint and buttons

NOGUCHI Hiroshi (3):
      HID: hid-asus: Add Transbook T90CHI support
      HID: Add ASUS T100CHI keyboard dock battery quirks
      HID: hid-asus: Add BT keyboard dock battery monitoring support

Nikolai Kondrashov (23):
      HID: kye: Add support for EasyPen M406XE
      HID: viewsonic: Support PD1011 signature pad
      HID: Clarify vendor ID reuse by Ugee tablets
      HID: uclogic: Extract report descriptors to a module
      HID: uclogic: Extract tablet parameter discovery into a module
      HID: uclogic: Re-initialize tablets on resume
      HID: uclogic: Designate current protocol v1
      HID: uclogic: Support in-range reporting emulation
      HID: uclogic: Support fragmented high-res reports
      HID: uclogic: Support v2 protocol
      HID: uclogic: Add support for Ugee 2150
      HID: uclogic: Add support for Ugee M540
      HID: uclogic: Add support for Ugee EX07S frame controls
      HID: uclogic: Add support for XP-Pen Star G540
      HID: uclogic: Add support for XP-Pen Star G640
      HID: uclogic: Add support for XP-Pen Deco 01
      HID: uclogic: Support faking Wacom pad device ID
      HID: uclogic: Support Gray-coded rotary encoders
      HID: uclogic: Add support for Ugee G5
      HID: uclogic: Do not initialize non-USB devices
      HID: Remove hid-uclogic entries from hid_have_special_driver
      HID: Remove KYE tablets from hid_have_special_driver
      HID: Remove Waltop tablets from hid_have_special_driver

Rodrigo Rivas Costa (1):
      HID: steam: fix boot loop with bluetooth firmware

Song Hongyan (1):
      HID: intel-ish: ipc: handle PIMR before ish_wakeup also clear PISR busy_clear bit

Srinivas Pandruvada (1):
      HID: intel-ish-hid: Use VID/PID from ISH

William Whistler (1):
      Support for Maltron L90 keyboard media keys

 drivers/hid/Kconfig                                |   13 +
 drivers/hid/Makefile                               |    5 +
 drivers/hid/hid-asus.c                             |  247 ++++-
 drivers/hid/hid-elan.c                             |    2 +-
 drivers/hid/hid-ids.h                              |   20 +-
 drivers/hid/hid-input.c                            |    3 +
 drivers/hid/hid-kye.c                              |   83 ++
 drivers/hid/hid-lg.c                               |   60 ++
 drivers/hid/hid-lg4ff.c                            |    6 +
 drivers/hid/hid-maltron.c                          |  165 +++
 drivers/hid/hid-multitouch.c                       |    6 +
 drivers/hid/hid-quirks.c                           |   33 +-
 drivers/hid/hid-roccat-kone.c                      |    1 +
 drivers/hid/hid-sony.c                             |   31 +-
 drivers/hid/hid-steam.c                            |   34 +-
 drivers/hid/hid-topseed.c                          |    3 +
 drivers/hid/hid-uclogic-core.c                     |  418 ++++++++
 drivers/hid/hid-uclogic-params.c                   | 1122 ++++++++++++++++++++
 drivers/hid/hid-uclogic-params.h                   |  207 ++++
 drivers/hid/{hid-uclogic.c => hid-uclogic-rdesc.c} |  822 ++++++--------
 drivers/hid/hid-uclogic-rdesc.h                    |  155 +++
 drivers/hid/hid-viewsonic.c                        |  105 ++
 drivers/hid/i2c-hid/i2c-hid-core.c                 |    9 +
 drivers/hid/intel-ish-hid/ipc/ipc.c                |   32 +-
 drivers/hid/intel-ish-hid/ishtp-hid-client.c       |    4 +-
 drivers/hid/intel-ish-hid/ishtp-hid.c              |    4 +-
 drivers/hid/intel-ish-hid/ishtp-hid.h              |    6 +-
 drivers/hid/intel-ish-hid/ishtp/bus.c              |   27 +-
 drivers/hid/intel-ish-hid/ishtp/bus.h              |    6 +-
 drivers/hid/intel-ish-hid/ishtp/client.h           |    2 +-
 drivers/hid/intel-ish-hid/ishtp/hbm.c              |   97 +-
 drivers/hid/intel-ish-hid/ishtp/hbm.h              |    2 +-
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h        |    2 -
 drivers/hid/wacom_sys.c                            |   32 +
 drivers/hid/wacom_wac.c                            |   24 +-
 35 files changed, 3049 insertions(+), 739 deletions(-)
 create mode 100644 drivers/hid/hid-maltron.c
 create mode 100644 drivers/hid/hid-uclogic-core.c
 create mode 100644 drivers/hid/hid-uclogic-params.c
 create mode 100644 drivers/hid/hid-uclogic-params.h
 rename drivers/hid/{hid-uclogic.c => hid-uclogic-rdesc.c} (67%)
 create mode 100644 drivers/hid/hid-uclogic-rdesc.h
 create mode 100644 drivers/hid/hid-viewsonic.c

-- 
Jiri Kosina
SUSE Labs

