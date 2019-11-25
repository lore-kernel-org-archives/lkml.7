Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30FEC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878F32071E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfKYJda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 04:33:30 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:49720 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbfKYJd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 04:33:29 -0500
Received: from ramsan ([84.195.182.253])
        by xavier.telenet-ops.be with bizsmtp
        id W9ZT2100D5USYZQ019ZTVL; Mon, 25 Nov 2019 10:33:27 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iZAkJ-0007Vh-1n; Mon, 25 Nov 2019 10:33:27 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iZAkI-0003KK-Vo; Mon, 25 Nov 2019 10:33:26 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for 5.5
Date:   Mon, 25 Nov 2019 10:33:20 +0100
Message-Id: <20191125093320.12738-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.5-tag1

for you to fetch changes up to 5ed0794cde59365d4d5895b89bb2f7ef7ffdbd55:

  m68k/atari: Convert Falcon IDE drivers to platform drivers (2019-11-18 10:18:59 +0100)

----------------------------------------------------------------
m68k updates for v5.5

  - Atari Falcon IDE platform driver conversion for module autoload,
  - Defconfig updates (incl. enablement of Amiga ICY I2C),
  - Small fixes and cleanups.

----------------------------------------------------------------
Fuqian Huang (1):
      m68k: q40: Fix info-leak in rtc_ioctl

Geert Uytterhoeven (2):
      m68k: defconfig: Update defconfigs for v5.4-rc1
      m68k: defconfig: Enable ICY I2C and LTC2990 on Amiga

Himanshu Jha (1):
      nubus: Remove cast to void pointer

Michael Schmitz (1):
      m68k/atari: Convert Falcon IDE drivers to platform drivers

 arch/m68k/atari/config.c             | 27 ++++++++++++++++
 arch/m68k/configs/amiga_defconfig    | 14 ++++-----
 arch/m68k/configs/apollo_defconfig   |  8 ++---
 arch/m68k/configs/atari_defconfig    |  8 ++---
 arch/m68k/configs/bvme6000_defconfig |  8 ++---
 arch/m68k/configs/hp300_defconfig    |  8 ++---
 arch/m68k/configs/mac_defconfig      |  8 ++---
 arch/m68k/configs/multi_defconfig    | 14 ++++-----
 arch/m68k/configs/mvme147_defconfig  |  8 ++---
 arch/m68k/configs/mvme16x_defconfig  |  8 ++---
 arch/m68k/configs/q40_defconfig      |  8 ++---
 arch/m68k/configs/sun3_defconfig     |  8 ++---
 arch/m68k/configs/sun3x_defconfig    |  8 ++---
 arch/m68k/q40/config.c               |  1 +
 drivers/ata/pata_falcon.c            | 42 ++++++++++++++++---------
 drivers/ide/falconide.c              | 60 ++++++++++++++++++++++++------------
 drivers/nubus/nubus.c                |  2 +-
 17 files changed, 131 insertions(+), 109 deletions(-)

Thanks for pulling!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
