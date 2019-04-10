Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E387DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A467120818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554910240;
	bh=ubrmAfU8dFLAAFPvgesnrrw2NDgN70//i5e/fgvuTKs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=sSQCuW+kvhGMr7mL3hn464kSMRJbLiwB6D5QJr+bYXB9AQ3JiCBiTG7qqgl20QdbP
	 lPK5D3uQdUEUnRxxDvS9ywRlTcCkvRPglmjzRENMBRDY8/e7YGfoYjU8uKD9xdMeid
	 +4ZJzmaRuqjTdpGZsQf9leTD69O92WKE5Ok3LFM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbfDJPaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:30:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56702 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbfDJPaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Emp3hOcVyiSb7KIlXcBJ7QTKbYeL+In2zGI6WcCX49k=; b=ZlyZ3kOvhiq3
        +b8ubWee9CF7kMBbMkWrRcNeL0b2g3fM6Y653AHMG/oiag4NyG9iGFo28iHRDpjlY88tj5lyr01pU
        6BtZqEmDhS8aYViqtnl+k+SdCQlwz+pz82QJYzVv6iYRm+VIFk8hE39/B7lZ1MczTEkDPReVH6Im6
        N0lL8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hEFBE-0001Kj-NA; Wed, 10 Apr 2019 15:30:28 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 03FE41128ED3; Wed, 10 Apr 2019 16:30:28 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        naga.sureshkumar.relli@xilinx.com, vigneshr@ti.com
Subject: Applied "spi: spi-mem: Make spi_mem_default_supports_op() static inline" to the spi tree
In-Reply-To: <20190410131828.35316-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190410153028.03FE41128ED3@debutante.sirena.org.uk>
Date:   Wed, 10 Apr 2019 16:30:27 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-mem: Make spi_mem_default_supports_op() static inline

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

From d4a91044e241d8f87fb990b673549a7d2f9cacc4 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 10 Apr 2019 21:18:28 +0800
Subject: [PATCH] spi: spi-mem: Make spi_mem_default_supports_op() static
 inline

Stub helper spi_mem_default_supports_op() should
be set to static inline

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/spi/spi-mem.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 1941b845aa15..af9ff2f0f1b2 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -315,6 +315,7 @@ spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 {
 }
 
+static inline
 bool spi_mem_default_supports_op(struct spi_mem *mem,
 				 const struct spi_mem_op *op)
 {
-- 
2.20.1

