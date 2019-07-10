Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B02FC74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E8520844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562772902;
	bh=uQlV1GIPquId2RgSZiLFYLjs8hd9/+CMYQebpE8Z+fs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=sOigoPBsPZ77xdBSJE+kXUlZ2TSrxqxOeDH4u6eq6xKXKbiIUmJRAG0pbFcAqwBJK
	 XjL5fwekpPvvx2hJdXSDs9fWqQTmW3PZT+vKf80UCZBzE3oM0ER5Sxwhb6RgwqiZTR
	 YBkCAvF5TjJkKYHVAenB8s3NkoAZcW0rf8FeIxQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfGJPfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:35:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45840 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbfGJPe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=SwHG6LTAEAh13sjDvyFHVD4GV3/BS+B3YNOvIoOotQs=; b=nTP0/1VSUJm0
        ngl2m7yQueHy4gxqaEnAj8ukmW3EdIcRETyiGGUXXIaU9+UZn9oYJjHu+PXZOqKIZMcoAc25jbAeg
        BVljbvfzBgMIotY8bigzHBvqsgmbQHO3g9uBA3Bc/fje/Zq0p5alIwEyytWbRfjD/8BGiK+Lsifcs
        xW1sk=;
Received: from [217.140.106.53] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hlEcQ-00083t-6C; Wed, 10 Jul 2019 15:34:54 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id DF598D02D7C; Wed, 10 Jul 2019 16:34:53 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Han Xu <han.xu@nxp.com>
Cc:     ashish.kumar@nxp.com, broonie@kernel.org, han.xu@nxp.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-qspi: change i.MX7D RX FIFO size" to the spi tree
In-Reply-To: <20190710023128.13115-3-han.xu@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190710153453.DF598D02D7C@fitzroy.sirena.org.uk>
Date:   Wed, 10 Jul 2019 16:34:53 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-fsl-qspi: change i.MX7D RX FIFO size

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

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

From d6b197a14863818a7ed7890e91f043fab49e8c60 Mon Sep 17 00:00:00 2001
From: Han Xu <han.xu@nxp.com>
Date: Wed, 10 Jul 2019 10:31:27 +0800
Subject: [PATCH] spi: spi-fsl-qspi: change i.MX7D RX FIFO size

The RX FIFO should be 128 byte rather than 512 byte. It's a typo on
reference manual.

Signed-off-by: Han Xu <han.xu@nxp.com>
Link: https://lore.kernel.org/r/20190710023128.13115-3-han.xu@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 41a49b93ca60..448c00e4065b 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -206,7 +206,7 @@ static const struct fsl_qspi_devtype_data imx6sx_data = {
 };
 
 static const struct fsl_qspi_devtype_data imx7d_data = {
-	.rxfifo = SZ_512,
+	.rxfifo = SZ_128,
 	.txfifo = SZ_512,
 	.ahb_buf_size = SZ_1K,
 	.quirks = QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_4X_INT_CLK,
-- 
2.20.1

