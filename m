Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C57BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC9620989
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552920741;
	bh=4XP3sXj34XrLx93D1e0tpDmWZlbipkrLAZdoM8xwFgA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=1YqB1z5ulUkohnBvsBIBqKx+fFT6b0cLZIWdXupIAcfyKXaxCpe5MkFcDWrqGW6c6
	 WgJLSVBvRN9OGfORQH3VVGGBGtOmKvMyAi1XxPQy7RStotrBWRAX5QszTpQndnB8VX
	 r3XjbaWTZUWpfAsnAYxDX+wJqEimyamalJBuH6d8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfCROwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:52:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56164 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbfCROwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=IdJrFav9067uu5CqV0sAdGesXJ+zmb/e30HNpuUiMOM=; b=Gy0dKrTgUans
        qTYXt8eGJB6QmSqtkPr0iHeZhnhdRc+Qror4IkfwgKGws1p9j2mdb6ZZvwgeexDG3RwJhLmVpZb/q
        h8YCg1hqSU4YRlpgbaLawyCnQIgxw1+i9RJoV4a4lmLWA9SgX9GNzJbuFARVdemVD4muUFBipnJ2w
        CTW5s=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h5tcU-0005pl-5z; Mon, 18 Mar 2019 14:52:06 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BBDB01128874; Mon, 18 Mar 2019 14:52:05 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: lpspi: Code cleanup" to the spi tree
In-Reply-To:  <20190306063020.793-9-xiaoning.wang@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190318145205.BBDB01128874@debutante.sirena.org.uk>
Date:   Mon, 18 Mar 2019 14:52:05 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: lpspi: Code cleanup

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

From 4e3891a55f671a4e641d2ef4e5ec0e27e56b20d9 Mon Sep 17 00:00:00 2001
From: Clark Wang <xiaoning.wang@nxp.com>
Date: Wed, 6 Mar 2019 06:30:49 +0000
Subject: [PATCH] spi: lpspi: Code cleanup

Delete the extra space.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-lpspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 2ac3ac5ea50a..1860f066f838 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -345,7 +345,7 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
 	writel(scldiv | (scldiv << 8) | ((scldiv >> 1) << 16),
 					fsl_lpspi->base + IMX7ULP_CCR);
 
-	dev_dbg(fsl_lpspi->dev, "perclk=%d, speed=%d, prescale =%d, scldiv=%d\n",
+	dev_dbg(fsl_lpspi->dev, "perclk=%d, speed=%d, prescale=%d, scldiv=%d\n",
 		perclk_rate, config.speed_hz, prescale, scldiv);
 
 	return 0;
-- 
2.20.1

