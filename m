Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CF8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09313206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554108866;
	bh=Kpdbi5VqQMDiN8Lgit7u20wiacmmaPrufRhvgdVCz2I=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=i4j9AwJAJiJQPEShcRzrORWnfEUdZkHPY3CXD9bI3DqgxkYibRsmNRjo7XdjcBWdX
	 bKtywbNFnpYcEVMNVdhfIhaeklXBmM3TN2QfyY4jZ/BPRwYbfJ+ipkVxCOZSBNZZ/m
	 ro7aEudvnv+weja3QktEHKqSNTCy9r/HqnqVkuJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfDAIyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:54:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33042 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfDAIyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=E6cLqoAWCFIceNVHqu8euOIjh6LoBBnwuT8NmlelZTY=; b=VMOBmixqHf5j
        B/av0SM1Sg5AGP5KxTvX4/8sYwJDUSbVVK4iU7mNGYxSONs29j6ZBkyBMgV1VWBYA/3xDZlqenTPA
        Kss29upcmqcbStAI8g1UTbFxlKrs1dQpSrdby3HyyQWbMYaGD7APmJQyzbnTLB2c3P9iVBl/x+/na
        j07aw=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hAshr-0008PW-Lf; Mon, 01 Apr 2019 08:54:16 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id D5F23440082; Mon,  1 Apr 2019 09:54:12 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, talho@nvidia.com, skomatineni@nvidia.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: tegra114: add SPI_LSB_FIRST support" to the spi tree
In-Reply-To:  <1553666207-11414-12-git-send-email-skomatineni@nvidia.com>
X-Patchwork-Hint: ignore
Message-Id: <20190401085412.D5F23440082@finisterre.ee.mobilebroadband>
Date:   Mon,  1 Apr 2019 09:54:12 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: tegra114: add SPI_LSB_FIRST support

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

From 2b17a3c759e5e2ed3faafb69e243ec312e3bf0da Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Tue, 26 Mar 2019 22:56:33 -0700
Subject: [PATCH] spi: tegra114: add SPI_LSB_FIRST support

Tegra SPI controller supports lsb first mode. Default is MSB bit first
and on selection of SPI_LSB_FIRST through SPI mode transmission happens
with LSB bit first.

This patch adds SPI_LSB_FIRST flag to mode_bits and also configures it
on request.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 929358e3487a..0c52aeeb1d4f 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -696,6 +696,11 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		else if (req_mode == SPI_MODE_3)
 			command1 |= SPI_CONTROL_MODE_3;
 
+		if (spi->mode & SPI_LSB_FIRST)
+			command1 |= SPI_LSBIT_FE;
+		else
+			command1 &= ~SPI_LSBIT_FE;
+
 		if (tspi->cs_control) {
 			if (tspi->cs_control != spi)
 				tegra_spi_writel(tspi, command1, SPI_COMMAND1);
@@ -1047,7 +1052,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 		master->max_speed_hz = 25000000; /* 25MHz */
 
 	/* the spi->mode bits understood by this driver: */
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
 	master->setup = tegra_spi_setup;
 	master->transfer_one_message = tegra_spi_transfer_one_message;
 	master->num_chipselect = MAX_CHIP_SELECT;
-- 
2.20.1

