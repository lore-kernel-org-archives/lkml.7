Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07EAC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CB620B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561548800;
	bh=eDyuff0IjAIgyOqgUluSecF2v8yM4IjmHJ8XJLbFxgo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=zyi+tzvuG2t4i8OxFmN8sCpw8s4WwUiJsx+QUxakZB/nigakriwZRjncxjLNrH+F1
	 6q+ouYiAj33tbITRtZ9U9CXEMWKpXiu2q2XifppKjHHJ8I9wvppn+eQI+8cEe33Tv5
	 hDzez0sQAreERgI3phtJrGo3df/J3MyjJOZxxUUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfFZLdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 07:33:08 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53592 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFZLdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 07:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=pmKiTP/UH0LuMJK3IPEv8DYClPZZJDCF1B6gxlNM18U=; b=lxNqeI03NvnJ
        5Iy7XhJi0Sw4kNMzUjy3AdWTeLB0RfZd/gaCkSHPEa4JXNH8wLUcigG/COWKd+tnT7UCmq81F7dq0
        qoTd4kxJnMuXe8xUVXCLug4Q2Q6yhD9m0L47QCx6nEXbQmlDnLOgKcd1h18UT3AKYPqpiVeLkArmj
        qoEDU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hg6Ad-0007od-Ab; Wed, 26 Jun 2019 11:32:59 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id D7724440049; Wed, 26 Jun 2019 12:32:58 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Keiji Hayashibara <hayashibara.keiji@socionext.com>
Cc:     broonie@kernel.org, hayashibara.keiji@socionext.com,
        jaswinder.singh@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, masami.hiramatsu@linaro.org,
        yamada.masahiro@socionext.com
Subject: Applied "spi: uniphier: fix timeout error" to the spi tree
In-Reply-To: <1561509708-4175-2-git-send-email-hayashibara.keiji@socionext.com>
X-Patchwork-Hint: ignore
Message-Id: <20190626113258.D7724440049@finisterre.sirena.org.uk>
Date:   Wed, 26 Jun 2019 12:32:58 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: uniphier: fix timeout error

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

From e4671df0bfd67d4864de014fa1751d5e2a56c7a6 Mon Sep 17 00:00:00 2001
From: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Date: Wed, 26 Jun 2019 09:41:47 +0900
Subject: [PATCH] spi: uniphier: fix timeout error

Timeout error was silently ignored.
This commit adds timeout error handling and modifies return type of
wait_for_completion_timeout().

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-uniphier.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index 5a6137fe172d..c3c35c041ef1 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -328,7 +328,8 @@ static int uniphier_spi_transfer_one(struct spi_master *master,
 				     struct spi_transfer *t)
 {
 	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
-	int status;
+	struct device *dev = master->dev.parent;
+	unsigned long time_left;
 
 	uniphier_spi_setup_transfer(spi, t);
 
@@ -338,13 +339,15 @@ static int uniphier_spi_transfer_one(struct spi_master *master,
 
 	uniphier_spi_irq_enable(spi, SSI_IE_RCIE | SSI_IE_RORIE);
 
-	status = wait_for_completion_timeout(&priv->xfer_done,
-					     msecs_to_jiffies(SSI_TIMEOUT_MS));
+	time_left = wait_for_completion_timeout(&priv->xfer_done,
+					msecs_to_jiffies(SSI_TIMEOUT_MS));
 
 	uniphier_spi_irq_disable(spi, SSI_IE_RCIE | SSI_IE_RORIE);
 
-	if (status < 0)
-		return status;
+	if (!time_left) {
+		dev_err(dev, "transfer timeout.\n");
+		return -ETIMEDOUT;
+	}
 
 	return priv->error;
 }
-- 
2.20.1

