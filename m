Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BFEC73C65
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 23:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870C920844
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 23:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562716109;
	bh=qFrC8sxMr5sSrn21isAFo4hDzPkoKULEHPfDpSXwACA=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=si9iDYnKdEhmzAgPA31lORjB99huz0+yOq7393DG9xQ/f0gsG3yWgd5ilcD+LobBN
	 XQ3aLiV7qhkKV4rmh8+1EubHPmQ3rKItd3elatFZGvGTSlZ8ZP+wd3bYfW9e3H58D7
	 E3lDXZeeeBJxeCf0RY+jX3we2F/gAJvy9EYyePPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfGIXr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 19:47:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfGIXr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 19:47:57 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E659720693;
        Tue,  9 Jul 2019 23:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562716075;
        bh=qFrC8sxMr5sSrn21isAFo4hDzPkoKULEHPfDpSXwACA=;
        h=Date:From:To:cc:Subject:From;
        b=HsyXjQwZVvCHi2dLho7lj6f8hXjLxdN+5XWkvvM082htUjjP6OirhoLjvr3aPcXst
         8vsnx8T7XZt+bZTPk7KrzwLNnsibFNdU9tOON++bh2PN3++pgGUqhx9s7GdWssBmMU
         wGYJX6k1xlgmB0bvlWIKpAuuIr7LM71ZnOgBAIh8=
Date:   Wed, 10 Jul 2019 01:47:48 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID for 5.3
Message-ID: <nycvar.YFH.7.76.1907100143190.5899@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive 5.3 merge window HID subsystem updates. Highlights:

=====
- Documentation conversion to ReST, from Mauro Carvalho Chehab
- Wacom MobileStudio Pro support, from Ping Cheng
- Wacom 2nd Gen Intuos Pro Small support, from Aaron Armstrong Skomra
- assorted small fixes and device ID additions
=====

Thanks.

----------------------------------------------------------------
Aaron Armstrong Skomra (8):
      HID: wacom: generic: only switch the mode on devices with LEDs
      HID: wacom: generic: Correct pad syncing
      HID: wacom: correct touch resolution x/y typo
      HID: wacom: Add 2nd gen Intuos Pro Small support
      HID: wacom: generic: read HID_DG_CONTACTMAX from any feature report
      HID: wacom: generic: support the 'report valid' usage for touch
      HID: wacom: generic: read the number of expected touches on a per collection basis
      HID: wacom: generic: add touchring adjustment for 2nd Gen Pro Small

Colin Ian King (2):
      HID: logitech-dj: make const array template static
      HID: logitech-hidpp: HID: make const array consumer_rdesc_start static

Hans de Goede (1):
      HID: logitech-dj: Add usb-id for the 27MHz MX3000 receiver

Mauro Carvalho Chehab (1):
      docs: hid: convert to ReST

Ping Cheng (1):
      HID: wacom: add new MobileStudio Pro support

Sebastian Parschauer (1):
      HID: Add another Primax PIXART OEM mouse quirk

Song Hongyan (1):
      HID: remove NO_D3 flag when remove driver

Wang Xuerui (1):
      HID: uclogic: Add support for Ugee Rainbow CV720

YueHaibing (1):
      HID: logitech-dj: fix return value of logi_dj_recv_query_hidpp_devices

 Documentation/hid/{hid-alps.txt => hid-alps.rst}   |  87 +++-
 .../hid/{hid-sensor.txt => hid-sensor.rst}         | 194 +++++----
 .../hid/{hid-transport.txt => hid-transport.rst}   |  82 +++-
 Documentation/hid/{hiddev.txt => hiddev.rst}       | 154 ++++---
 Documentation/hid/{hidraw.txt => hidraw.rst}       |  53 ++-
 Documentation/hid/index.rst                        |  18 +
 Documentation/hid/intel-ish-hid.rst                | 485 +++++++++++++++++++++
 Documentation/hid/intel-ish-hid.txt                | 454 -------------------
 Documentation/hid/{uhid.txt => uhid.rst}           |  46 +-
 Documentation/input/input.rst                      |   2 +-
 MAINTAINERS                                        |   2 +-
 drivers/hid/hid-ids.h                              |   2 +
 drivers/hid/hid-lg.c                               |   2 -
 drivers/hid/hid-logitech-dj.c                      |  19 +-
 drivers/hid/hid-logitech-hidpp.c                   |   2 +-
 drivers/hid/hid-quirks.c                           |   1 +
 drivers/hid/hid-uclogic-core.c                     |   2 +
 drivers/hid/hid-uclogic-params.c                   |   2 +
 drivers/hid/intel-ish-hid/ipc/pci-ish.c            |   1 +
 drivers/hid/wacom_sys.c                            |  13 +-
 drivers/hid/wacom_wac.c                            | 152 +++++--
 drivers/hid/wacom_wac.h                            |   3 +
 22 files changed, 1049 insertions(+), 727 deletions(-)
 rename Documentation/hid/{hid-alps.txt => hid-alps.rst} (64%)
 rename Documentation/hid/{hid-sensor.txt => hid-sensor.rst} (61%)
 rename Documentation/hid/{hid-transport.txt => hid-transport.rst} (93%)
 rename Documentation/hid/{hiddev.txt => hiddev.rst} (77%)
 rename Documentation/hid/{hidraw.txt => hidraw.rst} (89%)
 create mode 100644 Documentation/hid/index.rst
 create mode 100644 Documentation/hid/intel-ish-hid.rst
 delete mode 100644 Documentation/hid/intel-ish-hid.txt
 rename Documentation/hid/{uhid.txt => uhid.rst} (94%)

-- 
Jiri Kosina
SUSE Labs

