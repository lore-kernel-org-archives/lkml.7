Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE892C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92111218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552670386;
	bh=EoR1Fol/FaCFB+Jt53k8S6ea9nUs5CNlYlRJU0j+YVk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=p12a3us+U1B4ZEzCLgztO427/iir2WtS46Ez90shAk6quV/DDvgtEH4EVwQb2Q5/x
	 8bd9XlSy71FQCIbBMYgoNzldbGniCRfb7SfM69JOHvz2wkSpoVDPaiZ+Bm4yKhtCBj
	 GuVBSgfY+CuhVNOGJWSBKDfXnjxKOhR6aRKS/KvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbfCORTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:19:45 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54678 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729665AbfCORTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ND+XrZBR4qOjYj5GKv0Q2tW7zwE5uFytjyeNgD8uyW8=; b=LgouO23nx3m3
        r0yXCw99nEx+z1iWjKBoFqty+9eeTA9c+gjs2dlrHRq+MI32OeptmNvyXQI3NRfnzpqDI28h6yu5y
        yFh5g/bW80fNbI6FTKQNVA5qbgZwjl4cmHwpux4FyYZmvXq3UnxccKy0WxvquYwluAJ0unKsT06Ea
        bhkdQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h4qUb-0002fG-82; Fri, 15 Mar 2019 17:19:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AFE6C1126E81; Fri, 15 Mar 2019 17:19:36 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Ludovic Barre <ludovic.barre@st.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: spi-mem: stm32-qspi: avoid memory corruption at low frequency" to the spi tree
In-Reply-To:  <1552050741-27739-2-git-send-email-ludovic.Barre@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190315171936.AFE6C1126E81@debutante.sirena.org.uk>
Date:   Fri, 15 Mar 2019 17:19:36 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-mem: stm32-qspi: avoid memory corruption at low frequency

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

From 5356c2c70e385198e1a753ee364323f2fc01f759 Mon Sep 17 00:00:00 2001
From: Ludovic Barre <ludovic.barre@st.com>
Date: Fri, 8 Mar 2019 14:12:20 +0100
Subject: [PATCH] spi: spi-mem: stm32-qspi: avoid memory corruption at low
 frequency

This patch solves a memory corruption seen at 8 MHz.
To avoid such issue, timeout counter is disabled.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32-qspi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 3b2a9a6b990d..7354f9d68dba 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -76,7 +76,6 @@
 #define QSPI_PSMAR		0x28
 #define QSPI_PIR		0x2c
 #define QSPI_LPTR		0x30
-#define LPTR_DFT_TIMEOUT	0x10
 
 #define STM32_QSPI_MAX_MMAP_SZ	SZ_256M
 #define STM32_QSPI_MAX_NORCHIP	2
@@ -372,8 +371,7 @@ static int stm32_qspi_setup(struct spi_device *spi)
 	flash->presc = presc;
 
 	mutex_lock(&qspi->lock);
-	writel_relaxed(LPTR_DFT_TIMEOUT, qspi->io_base + QSPI_LPTR);
-	cr = FIELD_PREP(CR_FTHRES_MASK, 3) | CR_TCEN | CR_SSHIFT | CR_EN;
+	cr = FIELD_PREP(CR_FTHRES_MASK, 3) | CR_SSHIFT | CR_EN;
 	writel_relaxed(cr, qspi->io_base + QSPI_CR);
 
 	/* set dcr fsize to max address */
-- 
2.20.1

