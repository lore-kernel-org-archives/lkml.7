Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD8BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C058206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554108874;
	bh=t41cv8SX+OLTt9ja1DmcBZNS4rGG7lDLRLebcdsgY4w=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=AREVf/Mb5EfLhaM8TZvDpfASkRJodUWyf3hhSpbxrC+k/7ItZMahcM+Bi4NRimiI/
	 wSdIy/+3CVKuUGWtiKReqH93NWJdMMNxu8LSvtRbRLfoc4mTNi2+s9Ma3IDn5Hy5Ly
	 eDwtTgEKyOpUrMerkRhHiad/hTWZsgP+qGoCrkZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbfDAIyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:54:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33306 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbfDAIyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=si1V0BEhNf+WG451ADlnbD+4ka5zDA6STwyQMIT/b1s=; b=p+pgd+VSAm14
        BryK/DyU54syXDUV6kQHt0v6r2Zs2hOnEpzgZblkTkczYLI1UmOLxH4KdiQms3Tzotm+atZujv4wB
        axnlbanKgBQRgX6H9rrLKckrE+ljOM0idoG2pNI4+Wtv1iL3wr7kUPbKDyqJx/200QtBAtFQ/6QBg
        +vQTA=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hAsi3-0008Po-2c; Mon, 01 Apr 2019 08:54:27 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 08C89440082; Mon,  1 Apr 2019 09:54:24 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: spi-fsl-spi: relax message sanity checking a little" to the spi tree
In-Reply-To:  <20190327143040.16013-3-rasmus.villemoes@prevas.dk>
X-Patchwork-Hint: ignore
Message-Id: <20190401085424.08C89440082@finisterre.ee.mobilebroadband>
Date:   Mon,  1 Apr 2019 09:54:23 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-fsl-spi: relax message sanity checking a little

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

From 17ecffa289489e8442306bbc62ebb964e235cdad Mon Sep 17 00:00:00 2001
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Date: Wed, 27 Mar 2019 14:30:51 +0000
Subject: [PATCH] spi: spi-fsl-spi: relax message sanity checking a little

The comment says that we should not allow changes (to
bits_per_word/speed_hz) while CS is active, and indeed the code below
does fsl_spi_setup_transfer() when the ->cs_change of the previous
spi_transfer was set (and for the very first transfer).

So the sanity checking is a bit too strict - we can change it to
follow the same logic as is used by the actual transfer loop.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-spi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 6d114daa178a..481b075689b5 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -370,13 +370,15 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
 	int status;
 
 	/* Don't allow changes if CS is active */
-	first = list_first_entry(&m->transfers, struct spi_transfer,
-			transfer_list);
+	cs_change = 1;
 	list_for_each_entry(t, &m->transfers, transfer_list) {
+		if (cs_change)
+			first = t;
+		cs_change = t->cs_change;
 		if ((first->bits_per_word != t->bits_per_word) ||
 			(first->speed_hz != t->speed_hz)) {
 			dev_err(&spi->dev,
-				"bits_per_word/speed_hz should be same for the same SPI transfer\n");
+				"bits_per_word/speed_hz cannot change while CS is active\n");
 			return -EINVAL;
 		}
 	}
-- 
2.20.1

