Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3A0C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA3F20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554708736;
	bh=N7eSKnf+W6K7na+3xMaYbGoytAoC27dsPIh4tUmxZiA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=KCYd5ryv7fjz/TPPuaelCzyckL/hquJd7jP4xAicuQB3M5q1nEBqLASJ7v391Ubca
	 PieGqbZUc6pV+C3OcKCmwQJQwIqi6+x4kgTORqyrYbl3p1pX3TG6aMDPINeSULlHMN
	 n0THvl4cVykyAN6K2LqUlLGGrI2Y3+oNUadi4mig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfDHHcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:32:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44052 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfDHHcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=3V7COzg9VsqwdKmX61evL9k/DgvUjpk+t1Eg5v+5cAY=; b=e896xRSpC7ly
        ONlshISX5+ZqRf4WPwLr4qsro0gQFKAuBM2WQxcnl2NQHJzsn3Y4/d1efCHwepCJ/QZSkam+TUaZY
        n+l3Mxn+lyYpPE5s1MNqR47LUubeEHPbWbCnqctO7A/auqARHAlmVftg3V6u3gO5Pg5mcEeN/Zgqo
        IL2Wk=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDOlD-0003xR-VE; Mon, 08 Apr 2019 07:32:09 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 246DB441D3B; Mon,  8 Apr 2019 14:31:58 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, talho@nvidia.com, skomatineni@nvidia.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: tegra114: add 3 wire transfer mode support" to the spi tree
In-Reply-To:  <1554423259-26056-9-git-send-email-skomatineni@nvidia.com>
X-Patchwork-Hint: ignore
Message-Id: <20190408073158.246DB441D3B@finisterre.ee.mobilebroadband>
Date:   Mon,  8 Apr 2019 14:31:58 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: tegra114: add 3 wire transfer mode support

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

From 9d199231b000414e420a35912760f2d67e9c56d7 Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Thu, 4 Apr 2019 17:14:08 -0700
Subject: [PATCH] spi: tegra114: add 3 wire transfer mode support

This patch adds 3 wire transfer support to SPI mode list along with
its implementation.

3 wire or Bi-directional mode uses only one serial data pin for the
transfer. SPI in master mode uses MOSI data line only and MISO data
line is not used.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 1e749ce13029..751672b3bc16 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -754,6 +754,11 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		else
 			command1 &= ~SPI_LSBIT_FE;
 
+		if (spi->mode & SPI_3WIRE)
+			command1 |= SPI_BIDIROE;
+		else
+			command1 &= ~SPI_BIDIROE;
+
 		if (tspi->cs_control) {
 			if (tspi->cs_control != spi)
 				tegra_spi_writel(tspi, command1, SPI_COMMAND1);
@@ -1158,7 +1163,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
-			    SPI_TX_DUAL | SPI_RX_DUAL;
+			    SPI_TX_DUAL | SPI_RX_DUAL | SPI_3WIRE;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	master->setup = tegra_spi_setup;
 	master->transfer_one_message = tegra_spi_transfer_one_message;
-- 
2.20.1

