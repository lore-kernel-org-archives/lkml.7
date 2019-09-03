Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98120C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E71A2173E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567511886;
	bh=gqXxYA+eBCrq0ypyMekMW0x6jV3u4mVNZu4xiVm9QEs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=jEWNcDeFcJo3oKrlP9K0GtupLoJoetKb7HHTfwUXo+Dpv+zP4wn3KEv6tTlePve8q
	 mVtD/JLg6Ug/uRSQgEWdkrHSietnAEPRBvMijhoE4KW5J1Y1umq4NIrT6d6/qdn8Ks
	 DWMVDt1gnCjBQjT8WbPOficFu6NIbQctxl9E1Ehw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbfICL6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:58:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53124 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729028AbfICL54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=9QLn3xYH8VzmqLxk4ywgpvBD9QB5GdBoT1g3gRW0UwQ=; b=EOZq1a5fl1ez
        xqtGEXtdvhnxJelb6DzE22AzLPCO1FFEPIyXiN2GmIMAPLJ1R9CaHNoYuIDl6ATz4Qxhi2Eb01Fg+
        Y6KhrK/hmi+smum782C8Pktkob8O6MGGCpZvrJwmwW3njStm1eOQSKxF8/oXQ9+awqmjC11dRPI9H
        FAIsU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i57RV-0008M0-IQ; Tue, 03 Sep 2019 11:57:49 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 11BF62742D3C; Tue,  3 Sep 2019 12:57:49 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Keiji Hayashibara <hayashibara.keiji@socionext.com>
Cc:     broonie@kernel.org, hayashibara.keiji@socionext.com,
        jaswinder.singh@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, masami.hiramatsu@linaro.org,
        yamada.masahiro@socionext.com
Subject: Applied "spi: uniphier: remove unnecessary code" to the spi tree
In-Reply-To: <1567488661-11428-3-git-send-email-hayashibara.keiji@socionext.com>
X-Patchwork-Hint: ignore
Message-Id: <20190903115749.11BF62742D3C@ypsilon.sirena.org.uk>
Date:   Tue,  3 Sep 2019 12:57:49 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: uniphier: remove unnecessary code

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

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

From 151d0eafa4f59bbc7f8edfbefd5de2c97370d9b9 Mon Sep 17 00:00:00 2001
From: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Date: Tue, 3 Sep 2019 14:31:00 +0900
Subject: [PATCH] spi: uniphier: remove unnecessary code

This commit removed if() because priv->is_save_param is always true.

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Link: https://lore.kernel.org/r/1567488661-11428-3-git-send-email-hayashibara.keiji@socionext.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-uniphier.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index c1e6f3245557..226f8508bff2 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -226,8 +226,7 @@ static void uniphier_spi_setup_transfer(struct spi_device *spi,
 		priv->speed_hz = t->speed_hz;
 	}
 
-	if (!priv->is_save_param)
-		priv->is_save_param = true;
+	priv->is_save_param = true;
 
 	/* reset FIFOs */
 	val = SSI_FC_TXFFL | SSI_FC_RXFFL;
-- 
2.20.1

