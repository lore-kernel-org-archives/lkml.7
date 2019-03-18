Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0997FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F8520863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552920736;
	bh=p2xgiP4eUo5vTcHwwRtgMUD0fcDgUo+oaM/m/dg6xcs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=sgq7qVYvInhfzJDLcT1pHwgMObKXyICY+ArnPMFHywu9/9ErNTyKJ8p2kaPoZ11Ld
	 33XB2Z9wIwSYJxZMnlwvvp45P0uUNYivI5ybJpjZzyUBK1HvaRlbuOQlymsITPEFjJ
	 C8uYiUuHZ0iFUAG1H3Q1VRX1uIrQyoWOMrMM39j4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfCROwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:52:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56096 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbfCROwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=LaqkPKUBhLGgB0vm225DG8zb7jZ1XFS057qalAJjEqY=; b=C9YheUkJJJvK
        edZj5PGrpYIm948ToWgmgY3Fe6kLWhyuyN6VKfek46I7LFQRSINbLG9E8dBoRDhrTub8X++KQ/OdJ
        ZHX3hjeDdhLbrLH3iw+Qgu5Dp+cc100YkaHrgcVQgMo/no1wWXozTYJn0WRmC/7M0+DL1EUggVm4b
        FCOds=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h5tcW-0005pq-C6; Mon, 18 Mar 2019 14:52:08 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id DD4F81128874; Mon, 18 Mar 2019 14:52:07 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     Fugang Duan <Fugang.duan@nxp.com>, Mark Brown <broonie@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: lpspi: Add the missing NULL check" to the spi tree
In-Reply-To:  <20190306063020.793-8-xiaoning.wang@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190318145207.DD4F81128874@debutante.sirena.org.uk>
Date:   Mon, 18 Mar 2019 14:52:07 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: lpspi: Add the missing NULL check

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

From 578465ea2b4b56368ddc3dcefb1f6d607382ef86 Mon Sep 17 00:00:00 2001
From: Clark Wang <xiaoning.wang@nxp.com>
Date: Wed, 6 Mar 2019 06:30:47 +0000
Subject: [PATCH] spi: lpspi: Add the missing NULL check

The spi_transfer *t will be used in one transfer whatever. If t is NULL,
there has no need to try sending data, so add an error return here.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Acked-by: Fugang Duan <Fugang.duan@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-lpspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 9ff32fb67a29..2ac3ac5ea50a 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -438,9 +438,12 @@ static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
 	struct fsl_lpspi_data *fsl_lpspi =
 				spi_controller_get_devdata(spi->controller);
 
+	if (t == NULL)
+		return -EINVAL;
+
 	fsl_lpspi->config.mode = spi->mode;
-	fsl_lpspi->config.bpw = t ? t->bits_per_word : spi->bits_per_word;
-	fsl_lpspi->config.speed_hz = t ? t->speed_hz : spi->max_speed_hz;
+	fsl_lpspi->config.bpw = t->bits_per_word;
+	fsl_lpspi->config.speed_hz = t->speed_hz;
 	fsl_lpspi->config.chip_select = spi->chip_select;
 
 	if (!fsl_lpspi->config.speed_hz)
-- 
2.20.1

