Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381EFC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13CE720650
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbfIPImY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 04:42:24 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:53500 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfIPImX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 04:42:23 -0400
Received: from ramsan ([84.194.98.4])
        by laurent.telenet-ops.be with bizsmtp
        id 28iM2100G05gfCL018iMBS; Mon, 16 Sep 2019 10:42:21 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i9maT-00083x-5r; Mon, 16 Sep 2019 10:42:21 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i9maT-0003rK-3c; Mon, 16 Sep 2019 10:42:21 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [git pull] m68k updates for 5.4
Date:   Mon, 16 Sep 2019 10:42:15 +0200
Message-Id: <20190916084215.14792-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.4-tag1

for you to fetch changes up to 0f1979b402df5f0dd86425830ddaa191d70f3655:

  m68k: Remove ioremap_fullcache() (2019-09-02 09:50:26 +0200)

----------------------------------------------------------------
m68k updates for v5.4

  - ioremap() cleanups,
  - Defconfig updates,
  - Small fixes and cleanups.

----------------------------------------------------------------
Christoph Hellwig (2):
      m68k: Simplify ioremap_nocache()
      m68k: Remove ioremap_fullcache()

Finn Thain (2):
      m68k: mac: Revisit floppy disc controller base addresses
      m68k: Prevent some compiler warnings in Coldfire builds

Geert Uytterhoeven (2):
      m68k: atari: Rename shifter to shifter_st to avoid conflict
      m68k: defconfig: Update defconfigs for v5.3-rc2

 arch/m68k/atari/config.c             |   6 +-
 arch/m68k/configs/amiga_defconfig    |  13 +++-
 arch/m68k/configs/apollo_defconfig   |  13 +++-
 arch/m68k/configs/atari_defconfig    |  13 +++-
 arch/m68k/configs/bvme6000_defconfig |  13 +++-
 arch/m68k/configs/hp300_defconfig    |  13 +++-
 arch/m68k/configs/mac_defconfig      |  13 +++-
 arch/m68k/configs/multi_defconfig    |  13 +++-
 arch/m68k/configs/mvme147_defconfig  |  13 +++-
 arch/m68k/configs/mvme16x_defconfig  |  13 +++-
 arch/m68k/configs/q40_defconfig      |  13 +++-
 arch/m68k/configs/sun3_defconfig     |  13 +++-
 arch/m68k/configs/sun3x_defconfig    |  13 +++-
 arch/m68k/include/asm/atarihw.h      |  13 +---
 arch/m68k/include/asm/io_mm.h        |   6 +-
 arch/m68k/include/asm/kmap.h         |  17 +----
 arch/m68k/include/asm/macintosh.h    |  11 +--
 arch/m68k/mac/config.c               | 128 +++++++++++++++++------------------
 drivers/video/fbdev/atafb.c          |  42 ++++++------
 19 files changed, 223 insertions(+), 156 deletions(-)

Thanks for pulling!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
