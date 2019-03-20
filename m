Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF35C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C3D21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553103029;
	bh=ub2HAK+f656+uXzaBlruuTEW67j12T5I9OMOFehDXa4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=tluUzBVqWKnlniybxapnSZ+coziHOXV5mH+SVPR/oe6rzG4Nn1OLlk1jBFYytYcT2
	 yPzvRjjr8QBwE27rkGdC0g7+106QdbMszNqlb3vLWQIoIF1tdPDyJpafeDvtb7nAV/
	 J7TcTHdG7OIS7mlQK1HkFdhA9e2d+Q3GzJj5Qia0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfCTRa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:30:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45128 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbfCTRaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=uZ85V6amUZSKrtt5nSnLuvVMB8N+4CANUppmW1Rz16M=; b=LyngBu7sHZLD
        B0AuBAfIHRshVl62isQ4fyNer09J+gBgaR0ojl7MDpw5Mg/t1btgtFSa5VLetguzPVJhRf5MJoPe2
        vrKpqBtTGRzphF+6b7Mq8VwCWBuTTpq03krd9rVPly6P5wjmsFMVE1rGYOz1EC2n88cfGn0fjxTJp
        lavvk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6f2c-0001AL-Ok; Wed, 20 Mar 2019 17:30:14 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 45ACA1126E4C; Wed, 20 Mar 2019 17:30:14 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Ludovic Barre <ludovic.barre@st.com>, kbuild-all@01.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: spi-mem: stm32-qspi: stm32_qspi_pm_ops can be static" to the spi tree
In-Reply-To:  <20190316073341.GA132987@lkp-hsx03>
X-Patchwork-Hint: ignore
Message-Id: <20190320173014.45ACA1126E4C@debutante.sirena.org.uk>
Date:   Wed, 20 Mar 2019 17:30:14 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-mem: stm32-qspi: stm32_qspi_pm_ops can be static

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

From 43a8d240eee4f523c7120f47a4c9469f5abfb308 Mon Sep 17 00:00:00 2001
From: kbuild test robot <lkp@intel.com>
Date: Sat, 16 Mar 2019 15:33:41 +0800
Subject: [PATCH] spi: spi-mem: stm32-qspi: stm32_qspi_pm_ops can be static

Fixes: 2e541b64ee52 ("spi: spi-mem: stm32-qspi: add suspend/resume support")
Signed-off-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 3e8ca10011cc..7879a523583c 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -517,7 +517,7 @@ static int __maybe_unused stm32_qspi_resume(struct device *dev)
 	return 0;
 }
 
-SIMPLE_DEV_PM_OPS(stm32_qspi_pm_ops, stm32_qspi_suspend, stm32_qspi_resume);
+static SIMPLE_DEV_PM_OPS(stm32_qspi_pm_ops, stm32_qspi_suspend, stm32_qspi_resume);
 
 static const struct of_device_id stm32_qspi_match[] = {
 	{.compatible = "st,stm32f469-qspi"},
-- 
2.20.1

