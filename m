Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD7DC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4734B20821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555432394;
	bh=/ouBVB4VZSVZ5oLyD71SIopnuR1PKLOnegkUXeXcLGo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=JjlaDKR/ckvKoKWcooNbkxuTVW/SBK1gL9fdGJiZSS1/1mGMIP0Vs/9/PRrdnLLE6
	 eZLlIL3V8NDd7a4GfFX/HPfGHd+0cb9FvM1sd7a/UuDYZabOMzgJdVXqiIWMRGV+lo
	 nFjSTBtmZRFoZ8dQsYw4vJ64er/hpQjPwOS9KccM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbfDPQdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:33:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32930 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730050AbfDPQdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=WRZTYL0qKzDTJkr5+DO6NFqzZol0XgpRy+qpj9E/6y0=; b=kGBns/O4RtAn
        Wd90T+TlOXH1Z9b0M9X84r8YR/PlYQkYI5DJt7ThiCOwRUT2acjF/quoMssBtdS/X+YGLKcKV/cLz
        8nTfPxCB/QFQ4gMVtuTzKMUIiXWkrsDwHgUWie4DsLgPmTfTQ9eczaxyfLHJofBarxtTWZgvl48Em
        a/2wQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hGR15-0007rm-5x; Tue, 16 Apr 2019 16:33:03 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 956F211281C6; Tue, 16 Apr 2019 17:32:57 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org,
        jonathanh@nvidia.com, kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, robh+dt@kernel.org, skomatineni@nvidia.com,
        talho@nvidia.com, thierry.reding@gmail.com
Subject: Applied "spi: tegra114: fix PIO transfer" to the spi tree
In-Reply-To: <1555363834-32155-2-git-send-email-skomatineni@nvidia.com>
X-Patchwork-Hint: ignore
Message-Id: <20190416163257.956F211281C6@debutante.sirena.org.uk>
Date:   Tue, 16 Apr 2019 17:32:57 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: tegra114: fix PIO transfer

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.1

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

From 3f6e3f7843a6a1667ed890ca51a1388fc7bf3429 Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Mon, 15 Apr 2019 14:30:26 -0700
Subject: [PATCH] spi: tegra114: fix PIO transfer

This patch fixes PIO mode transfer to use PIO bit in SPI_COMMAND1 register.
Current driver uses DMA_EN instead of PIO bit.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index b57f10182fae..21e4fdad013f 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -641,8 +641,9 @@ static int tegra_spi_start_cpu_based_transfer(
 
 	tspi->is_curr_dma_xfer = false;
 
-	val |= SPI_DMA_EN;
-	tegra_spi_writel(tspi, val, SPI_DMA_CTL);
+	val = tspi->command1_reg;
+	val |= SPI_PIO;
+	tegra_spi_writel(tspi, val, SPI_COMMAND1);
 	return 0;
 }
 
-- 
2.20.1

