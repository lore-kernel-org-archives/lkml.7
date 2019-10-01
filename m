Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3410C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A354222C6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569930070;
	bh=mQunNPHWI321bMUBhvRJdJd7tAkBtmNwyblEoMrFUJM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=BsohimTX6udzcg+cqPo4r60bn2/kN97OZ4KJY6Nz3JTUcw06fqrs3Hhg71Ny/nM59
	 cxZYmzAxhZ1VGP9GLif7u3qecCQfrK8QjFCdOZBQUnvCkCQI+tEgnrpNCvCSzzQ0CI
	 wfH8zSSPlcI0sf48+u9sSrwxaxRtgyDT8mX5XEIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387544AbfJALlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:41:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40942 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387594AbfJALlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=t6QaYLUtMP7FT0N0YeWXRrrbr9pVC1Hq/x3bsn93qgA=; b=RmgGI0h4dbDT
        v9IbUcKRZ2319gI6qJ8piygWiCVx6sI4jy+hikrJQq+alDHCFH2m8Pq2rZFfcf/rlrS5eH6BcyU8l
        3PAIdIwpvDlpxa3XhoZqm6yyurwY+wVGMtquNNRgYPpCH886LWZ5rNSLQehAAZbo8cxkszmp+CNCt
        0jD/4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFGWf-0004YU-Ov; Tue, 01 Oct 2019 11:41:05 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 4111927429C0; Tue,  1 Oct 2019 12:41:05 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: fsl-lpspi: clean up indentation issue" to the spi tree
In-Reply-To: <20190926113701.26986-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Message-Id: <20191001114105.4111927429C0@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 12:41:05 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: fsl-lpspi: clean up indentation issue

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

From 1b0a2b2d3ccb98cf998816d87f7193139d54579e Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 26 Sep 2019 12:37:01 +0100
Subject: [PATCH] spi: fsl-lpspi: clean up indentation issue

The complete call is indented incorrectly, remove the extraneous tabs.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20190926113701.26986-1-colin.king@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-lpspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index d08e9324140e..5efd73cd0ead 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -779,7 +779,7 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
 
 	if (temp_SR & SR_FCF && (temp_IER & IER_FCIE)) {
 		writel(SR_FCF, fsl_lpspi->base + IMX7ULP_SR);
-			complete(&fsl_lpspi->xfer_done);
+		complete(&fsl_lpspi->xfer_done);
 		return IRQ_HANDLED;
 	}
 
-- 
2.20.1

