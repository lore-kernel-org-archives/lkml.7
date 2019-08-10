Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75A8C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 04:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A972084C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 04:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="rloOt8Qr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfHJEQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 00:16:14 -0400
Received: from gateway36.websitewelcome.com ([192.185.195.25]:34823 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbfHJEQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 00:16:14 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 24297400C98F4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2019 22:40:59 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id wInchgMQciQerwInch3ITc; Fri, 09 Aug 2019 23:16:12 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NxiF3xr+Hr1WaF07ZmyWES9WkPZH5m+fizTEj/FCeAg=; b=rloOt8QrMtdR3b7FUOXmcJyEXc
        /XkhD9mX6oLaVWStFM1LOJ5aimns/0wdRYhX1DFBoaMc0853hxk6kSFUBGgez10URYocpPI+Y7JZm
        Pho9Mkrk0dKDcLibKQnIpmMqYhYQquVbSUtceZcpPfD1fcmjElRWF+8fNOpmVn4zYZix7IQzthD+B
        c6KPniUKKUE9zQVHALs6g9IlIyplZstkhfQOYUMWYwGracezHzrUB1kunW1N7tOOgMQA+xcRM0Ko2
        t5OIlsdSkhgKAVELsptaQxHXTq1/WrsY0hzOGjvXgpHNhGcJThYm1zr8TFsoXkn0F1nQdQdhpFh+u
        ptYRjvsw==;
Received: from [187.192.11.120] (port=56154 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hwInb-000FGj-8T; Fri, 09 Aug 2019 23:16:11 -0500
Date:   Fri, 9 Aug 2019 23:16:10 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [GIT PULL] Wimplicit-fallthrough patches for 5.3-rc4
Message-ID: <20190810041610.GA27921@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hwInb-000FGj-8T
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:56154
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wimplicit-fallthrough-5.3-rc4

for you to fetch changes up to 1f7585f30a3af595ac07f610b807c738c9e3baab:

  ARM: ep93xx: Mark expected switch fall-through (2019-08-09 19:53:35 -0500)

----------------------------------------------------------------
Wimplicit-fallthrough patches for 5.3-rc4

Hi Linus,

Please, pull the following patches that mark switch cases where we are
expecting to fall through.

 - Fix fall-through warnings in arm, sparc64, mips, i386 and s390.

Thanks

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

----------------------------------------------------------------
Gustavo A. R. Silva (17):
      ARM/hw_breakpoint: Mark expected switch fall-throughs
      ARM: tegra: Mark expected switch fall-through
      ARM: alignment: Mark expected switch fall-throughs
      ARM: OMAP: dma: Mark expected switch fall-throughs
      mfd: db8500-prcmu: Mark expected switch fall-throughs
      mfd: omap-usb-host: Mark expected switch fall-throughs
      ARM: signal: Mark expected switch fall-through
      watchdog: Mark expected switch fall-throughs
      watchdog: scx200_wdt: Mark expected switch fall-through
      watchdog: wdt977: Mark expected switch fall-through
      crypto: ux500/crypt: Mark expected switch fall-throughs
      s390/net: Mark expected switch fall-throughs
      watchdog: riowd: Mark expected switch fall-through
      video: fbdev: omapfb_main: Mark expected switch fall-throughs
      pcmcia: db1xxx_ss: Mark expected switch fall-throughs
      scsi: fas216: Mark expected switch fall-throughs
      ARM: ep93xx: Mark expected switch fall-through

 arch/arm/kernel/hw_breakpoint.c        |  5 +++++
 arch/arm/kernel/signal.c               |  1 +
 arch/arm/mach-ep93xx/crunch.c          |  1 +
 arch/arm/mach-tegra/reset.c            |  2 +-
 arch/arm/mm/alignment.c                |  4 +++-
 arch/arm/plat-omap/dma.c               | 14 +++++---------
 drivers/crypto/ux500/cryp/cryp.c       |  6 ++++++
 drivers/mfd/db8500-prcmu.c             |  2 ++
 drivers/mfd/omap-usb-host.c            |  4 ++--
 drivers/pcmcia/db1xxx_ss.c             |  4 ++++
 drivers/s390/net/ctcm_fsms.c           |  1 +
 drivers/s390/net/ctcm_mpc.c            |  3 +++
 drivers/s390/net/qeth_l2_main.c        |  2 +-
 drivers/scsi/arm/fas216.c              |  8 ++++++++
 drivers/video/fbdev/omap/omapfb_main.c |  8 ++++++++
 drivers/watchdog/ar7_wdt.c             |  1 +
 drivers/watchdog/pcwd.c                |  2 +-
 drivers/watchdog/riowd.c               |  2 +-
 drivers/watchdog/sb_wdog.c             |  1 +
 drivers/watchdog/scx200_wdt.c          |  1 +
 drivers/watchdog/wdt.c                 |  2 +-
 drivers/watchdog/wdt977.c              |  2 +-
 22 files changed, 58 insertions(+), 18 deletions(-)
