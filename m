Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8F1C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9113204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556220441;
	bh=aBfwuQlAZIu1nkB32Wkhi/heFMProdXtmkr/Eb8NTl4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=K7AgiC8T4WUgN2jzsaWiQkgkorwDQkySMovQSN/mWRkB6oZTt5XHpOM1g6EiprVRw
	 I5OPTxm+16K+9cTbOqQrtReXz8cCcgCs8f1iWEhSHYak5sr3BHiqm5MmEeAh5llJHO
	 QOgcVYVTqatsVTLEuFX4xPHNqMJdVqlBEtrXQxI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbfDYT1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:27:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52808 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbfDYT0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Qh/tQSJgW5cW1WWM314yAbyJG2XgZz7T3I4K/Vf7Tzc=; b=vQFP07+Hbwrh
        +bxFr8018r8GauSebmjDitsx5C2KG22evQsJaE6Zn52b6en36UrwVq8UEwbGPO4GNSx7fr1PqKWa1
        G2OJHOeKoq54ARJJDQ5paqX0HGdXVFk1tymSvKyaYnoaOdJy9nDmYJBwBst7QR23pdGPVoNt+rtBd
        6qaLk=;
Received: from 188.29.164.24.threembb.co.uk ([188.29.164.24] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJk11-0004f0-Hu; Thu, 25 Apr 2019 19:26:39 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id AD0EC441D3C; Thu, 25 Apr 2019 20:26:38 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Fabien Dessenne <fabien.dessenne@st.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        Christophe KERELLO <christophe.kerello@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Ludovic Barre <ludovic.barre@st.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Applied "spi: stm32-qspi: manage the get_irq error case" to the spi tree
In-Reply-To: <1556119140-3319-1-git-send-email-fabien.dessenne@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190425192638.AD0EC441D3C@finisterre.ee.mobilebroadband>
Date:   Thu, 25 Apr 2019 20:26:38 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: stm32-qspi: manage the get_irq error case

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.2

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

From 9852254537c499110f6eb32f00a63d8049d04a69 Mon Sep 17 00:00:00 2001
From: Fabien Dessenne <fabien.dessenne@st.com>
Date: Wed, 24 Apr 2019 17:19:00 +0200
Subject: [PATCH] spi: stm32-qspi: manage the get_irq error case

During probe, check the "get_irq" error value.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
Acked-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32-qspi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 11a89aa15d56..42f8e3c6aa1f 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -574,6 +574,12 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		if (irq != -EPROBE_DEFER)
+			dev_err(dev, "IRQ error missing or invalid\n");
+		return irq;
+	}
+
 	ret = devm_request_irq(dev, irq, stm32_qspi_irq, 0,
 			       dev_name(dev), qspi);
 	if (ret) {
-- 
2.20.1

