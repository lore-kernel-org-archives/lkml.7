Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB41AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D67214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554108901;
	bh=sIH6RnxfJjWYAfXNrb6tlzaRitjo6FqzqtEjMXrwb2g=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=c/vhT7QDdjfSGrvdxiakd8aolNcTWuuBxPyUQyz0dvZtF44eW8QXl4AFmTBDwPS4+
	 IaCVUxGGXAUd5eExItcoRDlM1TruINLly6dJkyrgvOxXMQllul8nevrGkPUPT62Dwm
	 lQbx6Er6ymK+R7I32oDJ1Dn1UQIXvui3mmXKxhTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfDAIzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:55:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33994 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfDAIyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=SBdQkBRTb0ADEs4q3xs4MqQuxGiaE0VHghiBjrjIst0=; b=QTcjd8vNdTKo
        F52a1Akpv3d1QMZKzkoLYr1cBi+4HwP9LXVjr48BK3/6vb1hWcIcXI/3cR5qDgxeUgqtbD9p23Tvx
        MrBP8dS2Rngl1xb+p9KDuuq29IzxG+85oBUbEkL+FhkoxTjow2QHoWZVO2XfFcdwKBH4MeqVAuFcE
        1LD6Y=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hAsiG-0008QL-PB; Mon, 01 Apr 2019 08:54:41 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id D9D30440083; Mon,  1 Apr 2019 09:54:37 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, talho@nvidia.com, skomatineni@nvidia.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: tegra114: terminate dma and reset on transfer timeout" to the spi tree
In-Reply-To:  <1553666207-11414-6-git-send-email-skomatineni@nvidia.com>
X-Patchwork-Hint: ignore
Message-Id: <20190401085437.D9D30440083@finisterre.ee.mobilebroadband>
Date:   Mon,  1 Apr 2019 09:54:37 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: tegra114: terminate dma and reset on transfer timeout

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

From 32bd1a9551cae34e6889afa235c7afdfede9aeac Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Tue, 26 Mar 2019 22:56:27 -0700
Subject: [PATCH] spi: tegra114: terminate dma and reset on transfer timeout

Fixes: terminate DMA and perform controller reset on transfer timeout
to clear the FIFO's and errors.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 876eb2acdef1..a6153b905d1a 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -869,7 +869,16 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 		if (WARN_ON(ret == 0)) {
 			dev_err(tspi->dev,
 				"spi transfer timeout, err %d\n", ret);
+			if (tspi->is_curr_dma_xfer &&
+			    (tspi->cur_direction & DATA_DIR_TX))
+				dmaengine_terminate_all(tspi->tx_dma_chan);
+			if (tspi->is_curr_dma_xfer &&
+			    (tspi->cur_direction & DATA_DIR_RX))
+				dmaengine_terminate_all(tspi->rx_dma_chan);
 			ret = -EIO;
+			reset_control_assert(tspi->rst);
+			udelay(2);
+			reset_control_deassert(tspi->rst);
 			goto complete_xfer;
 		}
 
-- 
2.20.1

