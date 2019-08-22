Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77473C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3A8233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="SEOHjcoy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389685AbfHVRTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:19:48 -0400
Received: from gateway20.websitewelcome.com ([192.185.65.13]:32549 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389626AbfHVRTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:19:47 -0400
X-Greylist: delayed 1288 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Aug 2019 13:19:46 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id BFB07400D3776
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 10:53:35 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 0qPhiofEe3Qi00qPhiV1kF; Thu, 22 Aug 2019 11:58:17 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jDN3gcI13QMuU629GhiL2SRw0Co9gX7UJT+3Os8fErM=; b=SEOHjcoyRRWZGD7Hbi6DMWELk7
        yP/k6pnGV41ErJRQJOySfDIGkbyV7p8KXAbmeF27boVsaEwnQbl4m8EK2qUM17eSCQCgbI4QMlHF+
        W1WuIw1wyvrUvcfD0BRo4UtKhiLMXQY5UtkWLzjM5u7OizXtMxjHdmqRIC04L3KLD2oj2eC6Oi+7+
        eVJFasQCPdfvIGOqBXkXRv/JU30M+DPzsrsN1GS81VGvC9gUo3eVQcyfw5ywAO1bOFjCjrHcVxQk+
        8YBaN4xHV5D8OtP9yuL27fmdqejo+ov//ejEw/PYp4V7SkB0eA+clptDiH7hcXA8Rg0YKU3Up+cuz
        6yPIpZCg==;
Received: from 187-162-252-62.static.axtel.net ([187.162.252.62]:51776 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@linux.embeddedor.com>)
        id 1i0qPg-000n27-S2; Thu, 22 Aug 2019 11:58:16 -0500
Date:   Thu, 22 Aug 2019 11:58:15 -0500
From:   "Gustavo A. R. Silva" <gustavo@linux.embeddedor.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [GIT PULL] Wimplicit-fallthrough patches for 5.3-rc6
Message-ID: <20190822165815.GA2586@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linux.embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.252.62
X-Source-L: No
X-Exim-ID: 1i0qPg-000n27-S2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-252-62.static.axtel.net (embeddedor) [187.162.252.62]:51776
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wimplicit-fallthrough-5.3-rc6

for you to fetch changes up to c3cb6674df4c4a70f949e412dfe2230483092523:

  video: fbdev: acornfb: Mark expected switch fall-through (2019-08-20 19:44:01 -0500)

----------------------------------------------------------------
Wimplicit-fallthrough patches for 5.3-rc6

Hi Linus,

Please, pull the following patches that mark switch cases where we are
expecting to fall through.

 - Fix fall-through warnings on arm and mips for multiple
   configurations.

Thanks

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

----------------------------------------------------------------
Gustavo A. R. Silva (10):
      dmaengine: fsldma: Mark expected switch fall-through
      ARM: riscpc: Mark expected switch fall-through
      drm/sun4i: sun6i_mipi_dsi: Mark expected switch fall-through
      drm/sun4i: tcon: Mark expected switch fall-through
      mtd: sa1100: Mark expected switch fall-through
      watchdog: wdt285: Mark expected switch fall-through
      power: supply: ab8500_charger: Mark expected switch fall-through
      MIPS: Octeon: Mark expected switch fall-through
      scsi: libsas: sas_discover: Mark expected switch fall-through
      video: fbdev: acornfb: Mark expected switch fall-through

 arch/arm/mach-rpc/riscpc.c                   | 1 +
 arch/mips/include/asm/octeon/cvmx-sli-defs.h | 1 +
 drivers/dma/fsldma.c                         | 1 +
 drivers/gpu/drm/sun4i/sun4i_tcon.c           | 1 +
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c       | 1 +
 drivers/mtd/maps/sa1100-flash.c              | 1 +
 drivers/power/supply/ab8500_charger.c        | 1 +
 drivers/scsi/libsas/sas_discover.c           | 1 +
 drivers/video/fbdev/acornfb.c                | 1 +
 drivers/watchdog/wdt285.c                    | 2 +-
 10 files changed, 10 insertions(+), 1 deletion(-)
