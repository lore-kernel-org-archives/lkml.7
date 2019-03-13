Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14767C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4EFC20693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552491607;
	bh=9MViBI/7U+ijEtdQopBnK4+pprgCBKwBC0w9f2JcJBs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=bS7IV0ix/l7KkShloq+8zWIKiIDaZmZq2jkU37k1m6B9yPcG5JW/mKSBz3hqsKpAd
	 8h1+nFmlU7WpCjGEdcy33054WVs5+XsL/o1pbPb3OXZSVo36COoIIfL6ZwiVDyMALU
	 4bjT2VKQPYiwZqvwiY+hxrOyOseHtFL2WPgpOxBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfCMPkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:40:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51644 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfCMPkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=mT5mK1CNPKvbZJvdJUcgtev/XZ45Ga6+qTbmebanZQo=; b=kaJuNuko5N7/
        o1SfHeMCPfzMHpI4VXsunQuF99yEn2uJivBhAJzVmYqmmTpv8iuOwdb9zIZcjYvd7B4K+Ac4j9wF6
        Y0C0PksAwk4Rg/dQQIrGjqQ4pRQHF+y8s4yC+nRRMjYsC8KLpG8JfBTR4euzLN6FvQtcxOLmK/cg0
        +0roA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h45z6-0003VC-L0; Wed, 13 Mar 2019 15:40:00 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2E4131128B97; Wed, 13 Mar 2019 15:40:00 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: work around clang bug in SPI_BPW_RANGE_MASK()" to the spi tree
In-Reply-To:  <20190307155506.2993868-1-arnd@arndb.de>
X-Patchwork-Hint: ignore
Message-Id: <20190313154000.2E4131128B97@debutante.sirena.org.uk>
Date:   Wed, 13 Mar 2019 15:40:00 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: work around clang bug in SPI_BPW_RANGE_MASK()

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

From eefffb42f6659c9510105f3e4ebf2a8499d56936 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 7 Mar 2019 16:54:21 +0100
Subject: [PATCH] spi: work around clang bug in SPI_BPW_RANGE_MASK()

Clang-8 evaluates both sides of a ?: expression to check for
valid arithmetic even in the side that is never taken. This
results in a build warning:

drivers/spi/spi-sh-msiof.c:1052:24: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
        .bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32),
                              ^~~~~~~~~~~~~~~~~~~~~~~~~

Change the implementation to use the GENMASK() macro that does
what we want here but does not have a problem with the shift
count overflow.

Link: https://bugs.llvm.org/show_bug.cgi?id=38789
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/spi/spi.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 662b336aa2e4..b27386450089 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -444,8 +444,7 @@ struct spi_controller {
 	/* bitmask of supported bits_per_word for transfers */
 	u32			bits_per_word_mask;
 #define SPI_BPW_MASK(bits) BIT((bits) - 1)
-#define SPI_BIT_MASK(bits) (((bits) == 32) ? ~0U : (BIT(bits) - 1))
-#define SPI_BPW_RANGE_MASK(min, max) (SPI_BIT_MASK(max) - SPI_BIT_MASK(min - 1))
+#define SPI_BPW_RANGE_MASK(min, max) GENMASK((min) - 1, (max) - 1)
 
 	/* limits on transfer speed */
 	u32			min_speed_hz;
-- 
2.20.1

