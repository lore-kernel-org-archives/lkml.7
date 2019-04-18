Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3C2C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD1E2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555583179;
	bh=6AYkS87d1UYmspkOYTwTJ9AY901ySwjRsjSUCTeq6SQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=jGuaeFGM3+ldvFAPw01YGqg0sw0eOJp2u08ipw1ny0CzOaLNvPL2B4nWDxdxq0VpC
	 ZC+cKys560HO1EYXmjLj277/9+/je2SUVUeZep5bEE026Zak74zhBf+eVvLec1jrOC
	 5weOTL9blPSGrJChq+8QVZGFMr5LIHvVvtEQFbzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388695AbfDRK0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:26:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43818 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388628AbfDRK0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=crZSK5+edneJhR4v4BhEOqssp1SICb4jR4cWnndST9Q=; b=Utzcxml6LmRH
        Qgtu7S63DabUulh2J88EuCQyhZb5Jf/6tmHEAhyl2+7IM2WLMQuD9QvX3lQFPsQAnmcyTWCDSqxf4
        bov5dUEm3uV34NcImSW4AyHxCcer7wiqyUI9rTKCEYYJqHIV5+xdbX9ianDZHvR6hqGwiLOUS2asI
        v4+Ms=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hH4F6-0001TR-OL; Thu, 18 Apr 2019 10:26:08 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0CC9F1126DCF; Thu, 18 Apr 2019 11:26:08 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org,
        jonathanh@nvidia.com, kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, robh+dt@kernel.org, skomatineni@nvidia.com,
        talho@nvidia.com, thierry.reding@gmail.com
Subject: Applied "spi: expand mode support" to the spi tree
In-Reply-To: <1555363834-32155-3-git-send-email-skomatineni@nvidia.com>
X-Patchwork-Hint: ignore
Message-Id: <20190418102608.0CC9F1126DCF@debutante.sirena.org.uk>
Date:   Thu, 18 Apr 2019 11:26:08 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: expand mode support

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.2

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

From 4b490710d4d24f95e95a07baac6f3f98bb94cf3b Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Mon, 15 Apr 2019 14:30:27 -0700
Subject: [PATCH] spi: expand mode support

This patch changes mode and mode_bits from u16 to u32 to allow more
mode configurations.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/spi/spi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 589f9dc9ac2b..053abd22ad31 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -143,7 +143,7 @@ struct spi_device {
 	u32			max_speed_hz;
 	u8			chip_select;
 	u8			bits_per_word;
-	u16			mode;
+	u32			mode;
 #define	SPI_CPHA	0x01			/* clock phase */
 #define	SPI_CPOL	0x02			/* clock polarity */
 #define	SPI_MODE_0	(0|0)			/* (original MicroWire) */
@@ -443,7 +443,7 @@ struct spi_controller {
 	u16			dma_alignment;
 
 	/* spi_device.mode flags understood by this controller driver */
-	u16			mode_bits;
+	u32			mode_bits;
 
 	/* bitmask of supported bits_per_word for transfers */
 	u32			bits_per_word_mask;
@@ -1291,7 +1291,7 @@ struct spi_board_info {
 	/* mode becomes spi_device.mode, and is essential for chips
 	 * where the default of SPI_CS_HIGH = 0 is wrong.
 	 */
-	u16		mode;
+	u32		mode;
 
 	/* ... may need additional spi_device chip config data here.
 	 * avoid stuff protocol drivers can set; but include stuff
-- 
2.20.1

