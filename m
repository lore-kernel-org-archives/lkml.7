Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F0EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F35206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554108871;
	bh=f0G0zrJEVCc0woehNxhGl98dPVBHBc0rpl6Qjh5xjr8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Az0vZKtm7dFkDCBmbCKQsHkqPiF8ONz9GLT+BIalVSxQe4Yvde6D8Kg26srLoH63s
	 WvnW/WSc+HI1qNQ+ssWtuP9GU9LrWYDetQV8OgO6FTCjtjI8xLT3LTS4TwiITHInjb
	 Px0NkseQlldV9hskxzRnuaoaw0ctWa7gWVqgFCC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfDAIya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:54:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33072 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfDAIyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=llO/cinF4ib8G9T2/WY6QNP6jr0XmyKP/ZEtoHbNaJ4=; b=Q6mSMDobDay+
        gu2o6mkpLWuJ0p7K92kAsBiftUNm/DhlTAyD1irwX+mELCCTSbKXiN/75xzVmSPV8sbotxJW1l1zQ
        oghCC6kcAnzgR8TjT/8NZsZLUVitxuyFYi+BuQ6nLdxCjhjSO7NtZX6aZrntEdkfXY1lL9ub5axQI
        YKffE=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hAshu-0008PZ-In; Mon, 01 Apr 2019 08:54:19 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id BEEC5440083; Mon,  1 Apr 2019 09:54:15 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, talho@nvidia.com, skomatineni@nvidia.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: tegra114: use packed mode for 32 bits per word" to the spi tree
In-Reply-To:  <1553666207-11414-4-git-send-email-skomatineni@nvidia.com>
X-Patchwork-Hint: ignore
Message-Id: <20190401085415.BEEC5440083@finisterre.ee.mobilebroadband>
Date:   Mon,  1 Apr 2019 09:54:15 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: tegra114: use packed mode for 32 bits per word

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

From fc9ba6e3e28afcedf3bb3105b1d8cbc5c183c2a3 Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Tue, 26 Mar 2019 22:56:25 -0700
Subject: [PATCH] spi: tegra114: use packed mode for 32 bits per word

Fixes: Use packed mode for 32 bits per word transfers to increase
performance as each packet is a full 32-bit word.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index a76acedd7e2f..929358e3487a 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -259,7 +259,7 @@ static unsigned tegra_spi_calculate_curr_xfer_param(
 
 	tspi->bytes_per_word = DIV_ROUND_UP(bits_per_word, 8);
 
-	if (bits_per_word == 8 || bits_per_word == 16) {
+	if (bits_per_word == 8 || bits_per_word == 16 || bits_per_word == 32) {
 		tspi->is_packed = 1;
 		tspi->words_per_32bit = 32/bits_per_word;
 	} else {
-- 
2.20.1

