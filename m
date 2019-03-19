Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCB6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCCF2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553001251;
	bh=5NilmTcc2XjEOP306vBfM5Emx2OSRh16VIC+CcQKmnk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=A0UgV4ubnY4JzwAt/ILbKWRhDtnrM2xqr4YzJJDJ7eaeVwVriga/jxKIdNw/2bRKH
	 zeO+yI3RiIJfLApY7EIddUpXqM7W8JiEyGNqZiIPjR2XlSq5C0XIQ9dUG3D7iGHecg
	 Bq1v/SOIX9jPIdLJ1yovGGHwDuwWzG8ZMDOv1sTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfCSNOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:14:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49570 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbfCSNOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=id7UHoxTfXdKi8QwkjxSnAgQHXTfbAdm79okVDe3+tU=; b=d8UwGomfNmY4
        J3LODcd9Tv4NAIlH37tNfEjEc639iP0/r5ukL+V2tNha77+bO5Wv/qv5g1b0++kOZD7M9lhKoKijO
        2QwRpfd9Y+Kj7LY9jKErKzeq2XodjJk0yWeOIWymzvhvYIgGtlspUzJJBwD7VE8Hulq1bUKnjMlW+
        mShAs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6EZ6-0003A6-W5; Tue, 19 Mar 2019 13:14:01 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6D59711288DF; Tue, 19 Mar 2019 13:14:00 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Mark Brown <broonie@kernel.org>, Han Xu <han.xu@nxp.com>,
        kbuild-all@01.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Frank Li <frank.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: lpspi: fsl_lpspi_runtime_resume() can be static" to the spi tree
In-Reply-To:  <20190319014633.GA8434@ivb42>
X-Patchwork-Hint: ignore
Message-Id: <20190319131400.6D59711288DF@debutante.sirena.org.uk>
Date:   Tue, 19 Mar 2019 13:14:00 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: lpspi: fsl_lpspi_runtime_resume() can be static

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

From 809b169abbfe2b916f70c957b08dfaaaad0d7c02 Mon Sep 17 00:00:00 2001
From: kbuild test robot <lkp@intel.com>
Date: Tue, 19 Mar 2019 09:46:33 +0800
Subject: [PATCH] spi: lpspi: fsl_lpspi_runtime_resume() can be static

Fixes: 944c01a889d9 ("spi: lpspi: enable runtime pm for lpspi")
Signed-off-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-lpspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 1860f066f838..4de8eb378752 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -780,7 +780,7 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-int fsl_lpspi_runtime_resume(struct device *dev)
+static int fsl_lpspi_runtime_resume(struct device *dev)
 {
 	struct fsl_lpspi_data *fsl_lpspi = dev_get_drvdata(dev);
 	int ret;
@@ -798,7 +798,7 @@ int fsl_lpspi_runtime_resume(struct device *dev)
 	return 0;
 }
 
-int fsl_lpspi_runtime_suspend(struct device *dev)
+static int fsl_lpspi_runtime_suspend(struct device *dev)
 {
 	struct fsl_lpspi_data *fsl_lpspi = dev_get_drvdata(dev);
 
-- 
2.20.1

