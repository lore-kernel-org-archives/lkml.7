Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FBCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C766521874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553103012;
	bh=L1J+MvzZQHBtaZqkDP2py1Cd9qMf0Gv5u4Fp5+MUtxE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=f6tPNbBzNd4AhcSJGOdwunjVQE+J4UrxCkvP+yoBS3HuCD4mT4UNskPTZXV0cDUos
	 buRTL0T90hdD0wp7TFTm3vf9Ia36Kckd/Yc289H9yEGpeKdfRbRleVHAEr1Cm2Xc3m
	 Z8jwO52rwE2dLCTvdgYZTleg49mC4wvNjVv4CMYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfCTRaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:30:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44636 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbfCTRaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Fl5b0C2/XLReQ3ulbr+C75GtihFM6509WoNXr+Zl7DE=; b=In37qWUaCu/a
        eqZ9QthPaGn7XrtTHT3+C/D5UYZylsx/CU3BvV7iQNFLJNcthcpeMF4IWBcdKBGn9u30TMDulBsFO
        y4FVJTe/2VTMGDS5gW3Ay6J7eToaoCiBomPYfAzwTgL6m9VH4R4IkFnQhfzb163lfakfQOdWz4Tec
        AmsHU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6f2U-00019p-26; Wed, 20 Mar 2019 17:30:06 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8B0771126E4C; Wed, 20 Mar 2019 17:30:05 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Gareth Williams <gareth.williams.jx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: dw: Add support for an optional interface clock" to the spi tree
In-Reply-To:  <1553010727-23157-4-git-send-email-gareth.williams.jx@renesas.com>
X-Patchwork-Hint: ignore
Message-Id: <20190320173005.8B0771126E4C@debutante.sirena.org.uk>
Date:   Wed, 20 Mar 2019 17:30:05 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: dw: Add support for an optional interface clock

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

From 560ee7e9100916e30e126a53d127ca54745b2a8e Mon Sep 17 00:00:00 2001
From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Tue, 19 Mar 2019 15:52:07 +0000
Subject: [PATCH] spi: dw: Add support for an optional interface clock

The Synopsys SSI Controller has an interface clock, but most SoCs hide
this away. However, on some SoCs you need to explicitly enable the
interface clock in order to access the registers. Therefore, add support
for an optional interface clock.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw-mmio.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 4bd59a93d988..de952b17bc10 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -30,6 +30,7 @@
 struct dw_spi_mmio {
 	struct dw_spi  dws;
 	struct clk     *clk;
+	struct clk     *pclk;
 	void           *priv;
 };
 
@@ -172,6 +173,14 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* Optional clock needed to access the registers */
+	dwsmmio->pclk = devm_clk_get_optional(&pdev->dev, "pclk");
+	if (IS_ERR(dwsmmio->pclk))
+		return PTR_ERR(dwsmmio->pclk);
+	ret = clk_prepare_enable(dwsmmio->pclk);
+	if (ret)
+		goto out_clk;
+
 	dws->bus_num = pdev->id;
 
 	dws->max_freq = clk_get_rate(dwsmmio->clk);
@@ -199,6 +208,8 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	return 0;
 
 out:
+	clk_disable_unprepare(dwsmmio->pclk);
+out_clk:
 	clk_disable_unprepare(dwsmmio->clk);
 	return ret;
 }
@@ -208,6 +219,7 @@ static int dw_spi_mmio_remove(struct platform_device *pdev)
 	struct dw_spi_mmio *dwsmmio = platform_get_drvdata(pdev);
 
 	dw_spi_remove_host(&dwsmmio->dws);
+	clk_disable_unprepare(dwsmmio->pclk);
 	clk_disable_unprepare(dwsmmio->clk);
 
 	return 0;
-- 
2.20.1

