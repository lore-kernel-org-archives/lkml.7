Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0B1C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DA020882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554266550;
	bh=/R5IO1TdFWA671UnKlDpoFYgFK9Bb6pLWqB9NcCRtiE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=nSgw6YFfeVHjyxJEw52YHlm0BFsI4w0+QSO02s5JzxC3TFENUtg9UVFbRj9u5pVd9
	 GB9EnoMbN1WyvS17AcYQ7ZTJvHR/VEDXQkPZA9vcvoj6DMX+I3uFnCanlV7FoByUgF
	 TRxTm10EVb6H2DFqUCobXMwPbFui3P9zAj163ddc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfDCEma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:42:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40584 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbfDCEm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=NPeduGz+9mec+3IumoCAqAM0ew2GTeDpO/fBBwD4BzI=; b=va9nuMp87KKl
        H9Oyv7t5rWCetz87+yn7B6tUwChLvcGOmJPoTSrKx5RJ0UeE24xUXPcVwdYr0Srzwl+RwpH5zqlkz
        nNtjEC22Oj4kdugBPdjSiVlc0E744J2/f9yhm6cTkbJFoOXmELTalWItoOE6XD2Sg0T81JG6x6r/v
        2UJuE=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBXjE-00040V-L9; Wed, 03 Apr 2019 04:42:24 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id E7247440083; Wed,  3 Apr 2019 05:42:21 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: lpspi: add missing complete in abort func at dma mode" to the spi tree
In-Reply-To:  <20190402124609.22157-1-xiaoning.wang@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190403044221.E7247440083@finisterre.ee.mobilebroadband>
Date:   Wed,  3 Apr 2019 05:42:21 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: lpspi: add missing complete in abort func at dma mode

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

From 8863eca8c46affaa91ae35390b00358b925483eb Mon Sep 17 00:00:00 2001
From: Clark Wang <xiaoning.wang@nxp.com>
Date: Tue, 2 Apr 2019 12:45:53 +0000
Subject: [PATCH] spi: lpspi: add missing complete in abort func at dma mode

Add the missing complete operations for dma_completion to fix the
problem of blocking at the wait_for_completion_interruptible()
function when use spi_slave_abort().

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-lpspi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 4de8eb378752..2ad9d6262c2b 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -482,7 +482,13 @@ static int fsl_lpspi_slave_abort(struct spi_controller *controller)
 				spi_controller_get_devdata(controller);
 
 	fsl_lpspi->slave_aborted = true;
-	complete(&fsl_lpspi->xfer_done);
+	if (!fsl_lpspi->usedma)
+		complete(&fsl_lpspi->xfer_done);
+	else {
+		complete(&fsl_lpspi->dma_tx_completion);
+		complete(&fsl_lpspi->dma_rx_completion);
+	}
+
 	return 0;
 }
 
-- 
2.20.1

