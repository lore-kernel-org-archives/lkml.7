Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2990C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D782184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552578892;
	bh=nmPxByjNTGl8Ev7nUDxHN5CryucOi/XNshe2e46H6zI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Mj7Mc2PoztUV/sr+fuj0Lxf3r7h87zUEUgQU2JUChCg6ilmUwvvt/pejrFtYAXDaw
	 mUT6hEiHxx9bkc7ijyloZMMzAB2PRaePLPKO6BeHLQZ7cZ89nlimEcjx2Kn6usr/1V
	 p9bQvdmDN93kuZ7b8bzll6OflUbMq6orScNF6LPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfCNPyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:54:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36868 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbfCNPyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=cKn5w9O1CdfOS3qnL9lTwXTSuqffmCm/wJafbl/5Z/o=; b=Xr5kYxMLnSWs
        n+d1R7hRoMx1+MLzDvCBrHGOISrcWH3kDnEBJiEo3hvPw1tkp451G5pqJfpex3j9vzuu0irWm2n+k
        OZo7ykUiEKBkbpgAv/eRjyp72ekH9Bdy4yuKYIzM2nUOIIcphPvjA+NwVA4hQiUS7LoeytgvK8gQv
        sLRsQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h4Sgv-0002kB-Iv; Thu, 14 Mar 2019 15:54:45 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id EBE3A1126E64; Thu, 14 Mar 2019 15:54:44 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: fix SPI_BPW_RANGE_MASK() regression" to the spi tree
In-Reply-To:  <20190313210118.3507256-1-arnd@arndb.de>
X-Patchwork-Hint: ignore
Message-Id: <20190314155444.EBE3A1126E64@debutante.sirena.org.uk>
Date:   Thu, 14 Mar 2019 15:54:44 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: fix SPI_BPW_RANGE_MASK() regression

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 6d85028134d3f4f946924e2f9f0aaff47d9de840 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 13 Mar 2019 22:00:34 +0100
Subject: [PATCH] spi: fix SPI_BPW_RANGE_MASK() regression

Geert points out that I confused the min/max arguments that are
reversed between SPI_BPW_RANGE_MASK() and GENMASK(). This time
I have verified the result of the macro after fixing the arguments.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: eefffb42f665 ("spi: work around clang bug in SPI_BPW_RANGE_MASK()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/spi/spi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index b27386450089..a0975cf76cf6 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -444,7 +444,7 @@ struct spi_controller {
 	/* bitmask of supported bits_per_word for transfers */
 	u32			bits_per_word_mask;
 #define SPI_BPW_MASK(bits) BIT((bits) - 1)
-#define SPI_BPW_RANGE_MASK(min, max) GENMASK((min) - 1, (max) - 1)
+#define SPI_BPW_RANGE_MASK(min, max) GENMASK((max) - 1, (min) - 1)
 
 	/* limits on transfer speed */
 	u32			min_speed_hz;
-- 
2.20.1

