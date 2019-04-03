Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308DEC10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005C52084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554266599;
	bh=/7RooQ2Fv2weKGTOtSwBmNIFCAuZm6guhn/xYLeBX74=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=coPrbVo+ikH6Zbfo2jy99CLpjEtNvN30QYkF6/05dJg3GEa7IjV5u1j6ZNlwtsN4I
	 3WchDeCp7ZqL2+yXmUgPgVUip/diXz1GD3OhFxXZmw++DrLkd4A7gpJ7ZIKUaOWteC
	 a28wJFRQpdnU2rA6I3G1xY2hRMrKzym9q8adygtQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbfDCEnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:43:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42050 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbfDCEnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Jd7MruEtZPZEh0N08vGtCmStcnh6HYe4t6Epk0Je2SE=; b=MbZIvUfCEg8g
        uRq1rxaE9n3uSJaEVE6GKD5Z5PY07oU+cGpK4Jeq8Z8Dq1TkOqvxKZbaKuYjDzDtESYkgNxSPECX7
        4Iyi7lDgCyUNwKJ5xXh/5195h04xLsS3uWl6eRCvLBnNAjeivtWB5ADuSYxK2dpXbvrxptR/LhCZA
        kA6Cs=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBXjs-00042B-JK; Wed, 03 Apr 2019 04:43:04 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 58669440083; Wed,  3 Apr 2019 05:43:01 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        bbrezillon@kernel.org, vigneshr@ti.com, linux-spi@vger.kernel.org,
        dwmw2@infradead.org, marek.vasut@gmail.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, nagasuresh12@gmail.com,
        linux-spi@vger.kernel.org
Subject: Applied "spi: spi-mem: export spi_mem_default_supports_op()" to the spi tree
In-Reply-To:  <1554105540-19704-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Patchwork-Hint: ignore
Message-Id: <20190403044301.58669440083@finisterre.ee.mobilebroadband>
Date:   Wed,  3 Apr 2019 05:43:01 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-mem: export spi_mem_default_supports_op()

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

From 46109648052fe778c75f199d72255c899578d6f7 Mon Sep 17 00:00:00 2001
From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Date: Mon, 1 Apr 2019 13:29:00 +0530
Subject: [PATCH] spi: spi-mem: export spi_mem_default_supports_op()

Export spi_mem_default_supports_op(), so that controller drivers
can use this.
spi-mem driver already exports this using EXPORT_SYMBOL,
but not declared it in spi-mem.h.
This patch declares spi_mem_default_supports_op() in spi-mem.h and
also removes the static from the function prototype.

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mem.c       | 4 ++--
 include/linux/spi/spi-mem.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index a4d8d19ecff9..3397fd10cf8d 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -135,8 +135,8 @@ static int spi_check_buswidth_req(struct spi_mem *mem, u8 buswidth, bool tx)
 	return -ENOTSUPP;
 }
 
-static bool spi_mem_default_supports_op(struct spi_mem *mem,
-					const struct spi_mem_op *op)
+bool spi_mem_default_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op)
 {
 	if (spi_check_buswidth_req(mem, op->cmd.buswidth, true))
 		return false;
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 3703d0dcac2e..c845cd6e22ba 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -341,6 +341,9 @@ int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
 
 void spi_mem_driver_unregister(struct spi_mem_driver *drv);
 
+bool spi_mem_default_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op);
+
 #define spi_mem_driver_register(__drv)                                  \
 	spi_mem_driver_register_with_owner(__drv, THIS_MODULE)
 
-- 
2.20.1

