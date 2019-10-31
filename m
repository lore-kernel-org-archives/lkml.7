Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922FCCA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A4620873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572528230;
	bh=P3Rii6c7SAQxMHQQILmOf1SC2L267cmZkQ9U08b8l8c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=cCYW7e843q7oIqxJ7mTo2cyD/qXhv1rZsjEOpOYg1ZMX3FmJz/bJXuo7WtH+kb3my
	 kG56xhQbTKkM8l0cyUzyy1xUlOPZKKUoJV0OMj6wsyVpCJQV20tbl2/3+/XqYxR8cG
	 FBwuec/VjhhH0I/U3WEkFLo6hXTaHbQKUiJnvj7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfJaNXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 09:23:49 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56112 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfJaNXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=cX2GQwx79KGhyI+8o2ddFRP7SU55uxLjju8Bx0zNqbU=; b=w1GXU7OLZ6V9
        NOlCeGWK+uVSClvkjcRzuo/o3l28fh9fTqmntUC3CxAMXZbyyEhVLz8thrd9JSq8WC+IZJcgUheOy
        AswowT/c5ZDEURBcNqn1LcApNg7ae2XT2Rahmf+6bGkCr7jeSdXSFfIcLmWo8tdC2FrqIB2gHcbzX
        fViD0=;
Received: from [91.217.168.176] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iQAQQ-0007p7-C8; Thu, 31 Oct 2019 13:23:42 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 100F1D020AA; Thu, 31 Oct 2019 13:23:42 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Luhua Xu <luhua.xu@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        wsd_upstream@mediatek.com
Subject: Applied "spi: add power control when set_cs" to the spi tree
In-Reply-To: <1572426234-30019-1-git-send-email-luhua.xu@mediatek.com>
X-Patchwork-Hint: ignore
Message-Id: <20191031132342.100F1D020AA@fitzroy.sirena.org.uk>
Date:   Thu, 31 Oct 2019 13:23:42 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: add power control when set_cs

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

From d948e6ca189985495a21cd622c31e30e72b6b688 Mon Sep 17 00:00:00 2001
From: Luhua Xu <luhua.xu@mediatek.com>
Date: Wed, 30 Oct 2019 17:03:54 +0800
Subject: [PATCH] spi: add power control when set_cs

As to set_cs takes effect immediately, power spi
is needed when setup spi.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Luhua Xu <luhua.xu@mediatek.com>
Link: https://lore.kernel.org/r/1572426234-30019-1-git-send-email-luhua.xu@mediatek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5ba19ef809c2..294d0038eea6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3261,7 +3261,20 @@ int spi_setup(struct spi_device *spi)
 	if (spi->controller->setup)
 		status = spi->controller->setup(spi);
 
-	spi_set_cs(spi, false);
+	if (spi->controller->auto_runtime_pm && spi->controller->set_cs) {
+		status = pm_runtime_get_sync(spi->controller->dev.parent);
+		if (status < 0) {
+			pm_runtime_put_noidle(spi->controller->dev.parent);
+			dev_err(&spi->controller->dev, "Failed to power device: %d\n",
+				status);
+			return status;
+		}
+		spi_set_cs(spi, false);
+		pm_runtime_mark_last_busy(spi->controller->dev.parent);
+		pm_runtime_put_autosuspend(spi->controller->dev.parent);
+	} else {
+		spi_set_cs(spi, false);
+	}
 
 	if (spi->rt && !spi->controller->rt) {
 		spi->controller->rt = true;
-- 
2.20.1

