Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402C0C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6582D2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556220302;
	bh=i7o4/KAM9w/j/vrlfjnm2Z7x9k/q7+qiT0YqaCAJeuE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=01vXCoE5j2pp9aDGjVoRo/ofx2woJYT/r2SG8I3a9llpaDKzdTole+qC3YaAT8PS4
	 lb1TG7RWyn3j3/hLoiHy2ujvzHduHP3Ih7AK5NM+0QdFk558ufxHhFzxeEkA08ZI0S
	 nmJvhrG/5GC5ceBL6D+nIXzAeYNyvgdkeba0rng0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbfDYTZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:25:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49586 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbfDYTY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=RMQxBYecru7AZfpWdXHlmx2fBKOoa/neKiWA/f5l0AE=; b=aF3oimYlyMLZ
        atETN1gVZvHlrCm93x4KSGINhTi72MVrTlfdYG0A8+x5eiNPUmukg0mJ7N76IUZwgMyFyxM/je6sc
        uf0hlqGczEvL+vaPlT4cB2iukoJiaQdtWvmNQNR3I1JoMHI2Mfy5VkdDob1H6V4+jOwd16zBefssE
        cpqJY=;
Received: from 188.29.164.24.threembb.co.uk ([188.29.164.24] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJjzJ-0004aN-1w; Thu, 25 Apr 2019 19:24:53 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 10782441D3E; Thu, 25 Apr 2019 20:24:45 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Fabien Dessenne <fabien.dessenne@st.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Applied "spi: stm32: return the get_irq error" to the spi tree
In-Reply-To: <1556109524-21874-1-git-send-email-fabien.dessenne@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190425192445.10782441D3E@finisterre.ee.mobilebroadband>
Date:   Thu, 25 Apr 2019 20:24:45 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: stm32: return the get_irq error

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.1

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

From adb366f61af4486cafb5234aa820721543e21780 Mon Sep 17 00:00:00 2001
From: Fabien Dessenne <fabien.dessenne@st.com>
Date: Wed, 24 Apr 2019 14:38:44 +0200
Subject: [PATCH] spi: stm32: return the get_irq error

During probe, return the "get_irq" error value instead of -ENOENT. This
allows the driver to be defer probed if needed.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
Acked-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 4186ed20d796..b222ce8d083e 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1839,8 +1839,9 @@ static int stm32_spi_probe(struct platform_device *pdev)
 
 	spi->irq = platform_get_irq(pdev, 0);
 	if (spi->irq <= 0) {
-		dev_err(&pdev->dev, "no irq: %d\n", spi->irq);
-		ret = -ENOENT;
+		ret = spi->irq;
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to get irq: %d\n", ret);
 		goto err_master_put;
 	}
 	ret = devm_request_threaded_irq(&pdev->dev, spi->irq,
-- 
2.20.1

