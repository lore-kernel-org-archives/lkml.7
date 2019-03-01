Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F3CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F37220838
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388201AbfCANuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 08:50:05 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:52718 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387877AbfCANuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 08:50:04 -0500
Received: from ramsan ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id idq21z00Z3XaVaC06dq2ey; Fri, 01 Mar 2019 14:50:02 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gziY6-00079A-Br; Fri, 01 Mar 2019 14:50:02 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gziY6-0007bP-9C; Fri, 01 Mar 2019 14:50:02 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [git pull] m68k updates for 5.1
Date:   Fri,  1 Mar 2019 14:50:01 +0100
Message-Id: <20190301135001.29176-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.1-tag1

for you to fetch changes up to 28713169d879b67be2ef2f84dcf54905de238294:

  m68k: Add -ffreestanding to CFLAGS (2019-01-21 10:36:53 +0100)

----------------------------------------------------------------
m68k updates for v5.1

  - VLA removal,
  - Gcc-8.x build fixes,
  - Small improvements and cleanups,
  - Defconfig updates.

----------------------------------------------------------------
Finn Thain (5):
      m68k/mac: Clean up unused timer definitions
      m68k/mac: Skip VIA port setup unless RTC is connected
      m68k/mac: Remove obsolete comment
      m68k/mac: Use '030 reset method on SE/30
      m68k: Add -ffreestanding to CFLAGS

Geert Uytterhoeven (5):
      m68k/defconfig: Drop NET_VENDOR_<FOO>=n
      m68k: Avoid VLA use in mangle_kernel_stack()
      m68k/atari: Avoid VLA use in atari_switches_setup()
      m68k/defconfig: Update defconfigs for v5.0-rc1
      dio: Fix buffer overflow in case of unknown board

Jonathan Neuschäfer (1):
      m68k/apollo: Fix comment in Makefile

 arch/m68k/Makefile                   |  5 ++++-
 arch/m68k/apollo/Makefile            |  2 +-
 arch/m68k/atari/config.c             |  2 +-
 arch/m68k/configs/amcore_defconfig   | 20 -------------------
 arch/m68k/configs/amiga_defconfig    | 37 ++---------------------------------
 arch/m68k/configs/apollo_defconfig   | 34 ++------------------------------
 arch/m68k/configs/atari_defconfig    | 33 ++-----------------------------
 arch/m68k/configs/bvme6000_defconfig | 33 ++-----------------------------
 arch/m68k/configs/hp300_defconfig    | 34 ++------------------------------
 arch/m68k/configs/mac_defconfig      | 34 ++------------------------------
 arch/m68k/configs/multi_defconfig    | 34 ++------------------------------
 arch/m68k/configs/mvme147_defconfig  | 34 ++------------------------------
 arch/m68k/configs/mvme16x_defconfig  | 33 ++-----------------------------
 arch/m68k/configs/q40_defconfig      | 38 ++----------------------------------
 arch/m68k/configs/sun3_defconfig     | 33 ++-----------------------------
 arch/m68k/configs/sun3x_defconfig    | 34 ++------------------------------
 arch/m68k/include/asm/macints.h      |  3 ---
 arch/m68k/kernel/signal.c            |  3 ++-
 arch/m68k/mac/misc.c                 | 18 ++++-------------
 arch/m68k/mac/via.c                  | 20 +++++++++++--------
 drivers/dio/dio.c                    |  4 ++--
 21 files changed, 50 insertions(+), 438 deletions(-)

Thanks for pulling!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
