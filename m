Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7355C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8265D20830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfEFJFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:05:44 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:57312 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfEFJFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:05:43 -0400
Received: from ramsan ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id 8x5h200053XaVaC01x5hY4; Mon, 06 May 2019 11:05:41 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hNZZ6-0002Cn-Va; Mon, 06 May 2019 11:05:40 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hNZZ6-00018j-TI; Mon, 06 May 2019 11:05:40 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [git pull] m68k updates for 5.2
Date:   Mon,  6 May 2019 11:05:39 +0200
Message-Id: <20190506090539.4338-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.2-tag1

for you to fetch changes up to fdd20ec8786ab2950439c7e78871618f7e51f18b:

  Documentation/features/time: Mark m68k having modern-timekeeping (2019-05-06 10:58:37 +0200)

----------------------------------------------------------------
m68k updates for v5.2

  - Drop arch_gettimeoffset and adopt clocksource API,
  - Defconfig updates.

Note that the top commit is not in linux-next, as I only realized we
forgot to update the Documentation just before I prepared this pull
request.

Thanks for pulling!

----------------------------------------------------------------
Finn Thain (14):
      m68k: Call timer_interrupt() with interrupts disabled
      m68k: mac: Fix VIA timer counter accesses
      m68k: apollo, q40, sun3, sun3x: Remove arch_gettimeoffset implementations
      m68k: Drop ARCH_USES_GETTIMEOFFSET
      m68k: amiga: Convert to clocksource API
      m68k: atari: Convert to clocksource API
      m68k: bvme6000: Convert to clocksource API
      m68k: hp300: Convert to clocksource API
      m68k: hp300: Handle timer counter overflow
      m68k: mac: Convert to clocksource API
      m68k: mvme147: Convert to clocksource API
      m68k: mvme147: Handle timer counter overflow
      m68k: mvme16x: Convert to clocksource API
      m68k: mvme16x: Handle timer counter overflow

Geert Uytterhoeven (2):
      m68k: defconfig: Update defconfigs for v5.1-rc1
      Documentation/features/time: Mark m68k having modern-timekeeping

 .../time/modern-timekeeping/arch-support.txt       |   2 +-
 arch/m68k/Kconfig                                  |   1 -
 arch/m68k/amiga/cia.c                              |   9 ++
 arch/m68k/amiga/config.c                           |  49 +++++--
 arch/m68k/apollo/config.c                          |   7 -
 arch/m68k/atari/ataints.c                          |   4 +-
 arch/m68k/atari/config.c                           |   2 -
 arch/m68k/atari/time.c                             |  70 +++++++---
 arch/m68k/bvme6000/config.c                        |  77 +++++++----
 arch/m68k/configs/amiga_defconfig                  |  14 +-
 arch/m68k/configs/apollo_defconfig                 |  14 +-
 arch/m68k/configs/atari_defconfig                  |  14 +-
 arch/m68k/configs/bvme6000_defconfig               |  14 +-
 arch/m68k/configs/hp300_defconfig                  |  14 +-
 arch/m68k/configs/mac_defconfig                    |  14 +-
 arch/m68k/configs/multi_defconfig                  |  14 +-
 arch/m68k/configs/mvme147_defconfig                |  14 +-
 arch/m68k/configs/mvme16x_defconfig                |  14 +-
 arch/m68k/configs/q40_defconfig                    |  14 +-
 arch/m68k/configs/sun3_defconfig                   |  14 +-
 arch/m68k/configs/sun3x_defconfig                  |  14 +-
 arch/m68k/hp300/config.c                           |   1 -
 arch/m68k/hp300/time.c                             |  73 ++++++++---
 arch/m68k/hp300/time.h                             |   1 -
 arch/m68k/include/asm/mvme147hw.h                  |   2 +-
 arch/m68k/mac/config.c                             |   3 -
 arch/m68k/mac/via.c                                | 146 ++++++++++++++-------
 arch/m68k/mvme147/config.c                         |  73 +++++++----
 arch/m68k/mvme16x/config.c                         |  97 ++++++++++----
 arch/m68k/q40/config.c                             |   9 --
 arch/m68k/q40/q40ints.c                            |  19 +--
 arch/m68k/sun3/config.c                            |   2 -
 arch/m68k/sun3/intersil.c                          |   7 -
 arch/m68k/sun3/sun3ints.c                          |   3 +
 arch/m68k/sun3x/config.c                           |   1 -
 arch/m68k/sun3x/time.c                             |  21 ++-
 arch/m68k/sun3x/time.h                             |   1 -
 37 files changed, 518 insertions(+), 330 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
