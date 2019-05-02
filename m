Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D780CC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A87208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556763608;
	bh=1t+kTCZXzJxBEhAEF5vMMj+FkRvSTgGAxvO14p0DDyc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=yUmMohHlhWLOx+CBa/Q5Wh4w4oW25NVgISN34mkeuQhgaSSYQqw73buAIUDAGHap/
	 wGnJWcuDHbl9U1xMD3iwJ323wRVz4V8iJ1R3H6VOYe5OsNb+foKqMjlfbs8tz3w77e
	 2J5gMm+w9TtDXagOUHoyaSczkMYnJmWcmrD3BzkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfEBCUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 22:20:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56908 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfEBCTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 22:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=qn5Pu9SeCeSm13Dg3lR1i9rI9Ck3sTa0tClj1YYd9FA=; b=rVFtzOs+yibi
        yC7njH5GNfpJZL6ue9Jd3Ia7FawklWHoZF8FaQ0ppYH6k1f9XJgQLSdTWL+nidFrDHqbbHtV2iHo8
        lHGxBafow7NluMN1IzYz+8qROIdA5ygo2BfLKh/S68YLVB+elYviDydiQrK6JM+9Kf0cfvpzkn1/F
        twogM=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1JV-0005wN-NU; Thu, 02 May 2019 02:19:10 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id C1260441D3C; Thu,  2 May 2019 03:19:05 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org,
        jonathanh@nvidia.com, kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, robh+dt@kernel.org, skomatineni@nvidia.com,
        talho@nvidia.com, thierry.reding@gmail.com
Subject: Applied "spi: expand mode support" to the spi tree
In-Reply-To:  <1555363834-32155-3-git-send-email-skomatineni@nvidia.com>
X-Patchwork-Hint: ignore
Message-Id: <20190502021905.C1260441D3C@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:19:05 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: expand mode support

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

From 937e6d756422637eeb212c645ded69569a67fabc Mon Sep 17 00:00:00 2001
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

