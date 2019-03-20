Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F74C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A772721873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553103020;
	bh=BktbQdP6RHOucOhLGis5My9r8bRJIQglDRRPv5PxkeA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=iZry+8L4WS0aNJjxoSzQnf1UOPi3nfb2oHNh3iQkYfBEeYAcwOhWcRjvwf6iwuBLD
	 9g2iftgPPBpN3rot5sElluqrSJPLdWtFbNzn3PjPuT/2hdSo93wHOL3UFuau7gd+u3
	 RWpaAMajlIcqTZbC2L5Xe3DPG9/w3bOLQp8+HXOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfCTRaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:30:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44856 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbfCTRaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=mermph5pAyT0/OS7ZOwLxCzevxbph4wWI2JuW9V/HSs=; b=hJw/OWj9ehxh
        7o1WJ7tkr0Xb4AhmhUvr1xDet0sHP7MJE+o5lhVsXpzUfnVjV+qVOcK5U/lnv4kqfi8F1ZDMdGne3
        kBJWNCHe2ouoURGBbkSOgMrJc1HtIb/8XFTjN4RBheSE6pAXYL67eQp8txKxalDvgAgVJBTiXmg1N
        PcRSs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6f2a-0001AE-Jy; Wed, 20 Mar 2019 17:30:12 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1F8EF1126E4C; Wed, 20 Mar 2019 17:30:12 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: mxic: simplify getting .driver_data" to the spi tree
In-Reply-To:  <20190319163637.30949-1-wsa+renesas@sang-engineering.com>
X-Patchwork-Hint: ignore
Message-Id: <20190320173012.1F8EF1126E4C@debutante.sirena.org.uk>
Date:   Wed, 20 Mar 2019 17:30:12 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: mxic: simplify getting .driver_data

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

From f457cb707836e79a88b64ab22230edc2aa8ce0af Mon Sep 17 00:00:00 2001
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Tue, 19 Mar 2019 17:36:37 +0100
Subject: [PATCH] spi: mxic: simplify getting .driver_data

We should get 'driver_data' from 'struct device' directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mxic.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index e41ae6ef0f8a..f48563c09b97 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -492,8 +492,7 @@ static int mxic_spi_transfer_one(struct spi_master *master,
 
 static int __maybe_unused mxic_spi_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct spi_master *master = platform_get_drvdata(pdev);
+	struct spi_master *master = dev_get_drvdata(dev);
 	struct mxic_spi *mxic = spi_master_get_devdata(master);
 
 	mxic_spi_clk_disable(mxic);
@@ -504,8 +503,7 @@ static int __maybe_unused mxic_spi_runtime_suspend(struct device *dev)
 
 static int __maybe_unused mxic_spi_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct spi_master *master = platform_get_drvdata(pdev);
+	struct spi_master *master = dev_get_drvdata(dev);
 	struct mxic_spi *mxic = spi_master_get_devdata(master);
 	int ret;
 
-- 
2.20.1

