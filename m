Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923A3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4E7218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553180876;
	bh=i7C/rEVlvfaWGuvHjsnk+jwAStrNutM7hbOlYeat+uI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=EEQDn5l+rgrUF0R8wxw1x24IctV8Gl0AmceP+JEJ5hz8btQhVTlT2Ba1R/OeCpkQw
	 6Ir+pVxOHB4E6DpNh+apAfHk4E7yeHlmS1et8SGGMCarvShqL1rNUxBbJq2OQtzDsC
	 8Wm1RhdTF0vEYIHydC+y3z9J0vPyXgdJ7gJd1JJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfCUPHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:07:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48640 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbfCUPHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=bP+myiUSXqoDtPnvNwjkzmV3auDQxhhLrB/U0qIc2HE=; b=OdMDJGDu+d53
        XfhDhN0o//1Ag8STDprPZafMpmMFQq+X3mGqBqc+hNrKYLlGRjttCnZWyIF1FKG7L3CayL9pFLank
        9nAz8LNUNfFS6s8FWxoJvC8iQIMZWxtb/BeliSNLkJe3bATtc6Q4UQO5aLdJSGZFME6J0BaHfplqf
        5TKjc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6zIB-0005dz-1u; Thu, 21 Mar 2019 15:07:39 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9683711288EC; Thu, 21 Mar 2019 15:07:38 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: lpspi: fix dataloss when SS is inactivated between every words" to the spi tree
In-Reply-To:  <20190321095720.14438-1-xiaoning.wang@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190321150738.9683711288EC@debutante.sirena.org.uk>
Date:   Thu, 21 Mar 2019 15:07:38 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: lpspi: fix dataloss when SS is inactivated between every words

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

From 69c8a9bcb03222ad3b949064ac05de463c7c9aa3 Mon Sep 17 00:00:00 2001
From: Clark Wang <xiaoning.wang@nxp.com>
Date: Thu, 21 Mar 2019 09:57:12 +0000
Subject: [PATCH] spi: lpspi: fix dataloss when SS is inactivated between every
 words

If we don't use CONT to keep SS activated or use DMA mode without
cs-gpio, SS will be inactivated between every words. The word here
means the data sent once which length can be set as 1/2/4 bytes.

In the isr function, we read the FSR_RXCOUNT just behind the
fsl_lpspi_read_rx_fifo. This causes the value of FSR_RXCOUNT cannot
reflect whether there is still data not sent timely. So do this
judgement by FSR_TXCOUNT.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-lpspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 391863914043..9e117c4635d8 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -62,7 +62,7 @@
 #define CFGR1_PCSPOL	BIT(8)
 #define CFGR1_NOSTALL	BIT(3)
 #define CFGR1_MASTER	BIT(0)
-#define FSR_RXCOUNT	(BIT(16)|BIT(17)|BIT(18))
+#define FSR_TXCOUNT	(0xFF)
 #define RSR_RXEMPTY	BIT(1)
 #define TCR_CPOL	BIT(31)
 #define TCR_CPHA	BIT(30)
@@ -452,7 +452,7 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
 	}
 
 	if (temp_SR & SR_MBF ||
-	    readl(fsl_lpspi->base + IMX7ULP_FSR) & FSR_RXCOUNT) {
+	    readl(fsl_lpspi->base + IMX7ULP_FSR) & FSR_TXCOUNT) {
 		writel(SR_FCF, fsl_lpspi->base + IMX7ULP_SR);
 		fsl_lpspi_intctrl(fsl_lpspi, IER_FCIE);
 		return IRQ_HANDLED;
-- 
2.20.1

