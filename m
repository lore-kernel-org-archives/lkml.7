Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E29C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826B5218A1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554108877;
	bh=iF9Cf8cj8Fo6nJdbbqoYd5oqTLeL2g/lbHW9cJYRBGM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=M9h8dNgMFaxyLaFxt0BIYlm4mhkYrlfgewjyAAVRjHp8Ri6kYnpzIc9O8lhfs2upQ
	 CEV+f4B27q0lDeMj7f36+7CDGkQ+8b/rMWyB94+2Rn/W26yI21yIKWTIMbKvQAOSJn
	 vOIvkuOAceNvF7m6oaaiP+HYc/EoiJuK43efzHYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfDAIyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:54:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33400 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728796AbfDAIye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=cJgPI9Gj+y6hKPumTwgJ+NLdRyKtEqoGlDM7FOLE/pE=; b=Rb9KHPnTQ3XH
        +F/a98pGj6Z5ZBIWoJX3Sltd8jFef42QayNTviLBlL3Ar7ZcnX8+0/OtWKpaW3pFQOuiuN0JENc4J
        r/Q6w/szxIhRyCmiaAWjZxmWUpG/jNuWLndDgD+KnJS6HmDiDrS6j9GO8qwNFClZ4SexRvB6Qlayd
        3AMHU=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hAsi5-0008Pr-VI; Mon, 01 Apr 2019 08:54:30 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 177EA440083; Mon,  1 Apr 2019 09:54:27 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: spi-fsl-spi: remove always-true conditional in fsl_spi_do_one_msg" to the spi tree
In-Reply-To:  <20190327143040.16013-2-rasmus.villemoes@prevas.dk>
X-Patchwork-Hint: ignore
Message-Id: <20190401085427.177EA440083@finisterre.ee.mobilebroadband>
Date:   Mon,  1 Apr 2019 09:54:27 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-fsl-spi: remove always-true conditional in fsl_spi_do_one_msg

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

From 24c363623361b430fb79459ca922e816e6f48603 Mon Sep 17 00:00:00 2001
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Date: Wed, 27 Mar 2019 14:30:50 +0000
Subject: [PATCH] spi: spi-fsl-spi: remove always-true conditional in
 fsl_spi_do_one_msg

__spi_validate() in the generic SPI code sets ->speed_hz and
->bits_per_word to non-zero values, so this condition is always true.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-spi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 3d7b50c65f36..6d114daa178a 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -384,12 +384,10 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
 	cs_change = 1;
 	status = -EINVAL;
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (t->bits_per_word || t->speed_hz) {
-			if (cs_change)
-				status = fsl_spi_setup_transfer(spi, t);
-			if (status < 0)
-				break;
-		}
+		if (cs_change)
+			status = fsl_spi_setup_transfer(spi, t);
+		if (status < 0)
+			break;
 
 		if (cs_change) {
 			fsl_spi_chipselect(spi, BITBANG_CS_ACTIVE);
-- 
2.20.1

