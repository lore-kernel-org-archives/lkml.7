Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A7BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9417220854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553516569;
	bh=DV4nYIDNvdRAp4ZT5RiKv81EUZ1gfiADBaVQAIrtkWM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Uj5szrTimfKheLs/1lhJIHsqs9aZQdHrmNqjTIoqtKukcnq7yPfHiAHRlmTp24RFl
	 GB+NEL3lo8hV/fIheCvjKqifwobGHymkRf1C2fSfyohdswYdC1y61VTCZe6yRLxHee
	 8qa7HFbxg4owK96q8sW6lwXY89A3HRl0OVby9TXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbfCYMWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:22:48 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37038 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731010AbfCYMWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=bVt1CA26reaScpiomvMqOebzq5c2f/4rSBhkk2+4CWo=; b=Pti2UQi7/2iH
        SI4T+P+MDdT+b+fJ6KqUK/lqc7kSQd3XdO9GojclgSpfbJUf0dxJiCbKmABTpY1LacYyVItnPuwqh
        d8YH5Y2NDF8NvXvsqFwa4TxNpiuQgMWTw2rBXS46AAk0qka3dKECAe0HCRU0xkBsMi61lOWqexTuY
        mpJKc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h8Occ-000257-UY; Mon, 25 Mar 2019 12:22:34 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3BA8011288F1; Mon, 25 Mar 2019 12:22:34 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: atmel-quadspi: Make atmel_qspi_get_name static" to the spi tree
In-Reply-To:  <20190321151656.16816-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190325122234.3BA8011288F1@debutante.sirena.org.uk>
Date:   Mon, 25 Mar 2019 12:22:34 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: atmel-quadspi: Make atmel_qspi_get_name static

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

From 55e3dacaf538745b7d57dce43b9950687ff878ab Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 21 Mar 2019 23:16:56 +0800
Subject: [PATCH] spi: atmel-quadspi: Make atmel_qspi_get_name static

Fix sparse warning:

drivers/spi/atmel-quadspi.c:369:12: warning:
 symbol 'atmel_qspi_get_name' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/atmel-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index fffc21cd5f79..e54109759d34 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -366,7 +366,7 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	return err;
 }
 
-const char *atmel_qspi_get_name(struct spi_mem *spimem)
+static const char *atmel_qspi_get_name(struct spi_mem *spimem)
 {
 	return dev_name(spimem->spi->dev.parent);
 }
-- 
2.20.1

