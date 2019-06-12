Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5A4C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D6B21019
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560355191;
	bh=8bOp45wJH5x1ETED5LRpJfdun9MJAkUUSPe9NmirU7Q=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=CExMU5+1ApReOddavprckt1kjqpmoww28VkdndzCTr1fBpRstDS4Lxh/5XUTHAQPg
	 F5UJG2VCaTY5UwCxUYcexjRjtt3pgNI5Jr0mpzXx5DEKRE4N2KlK5cEHD4Mkd4vzRY
	 zCPc4KP4Otf9a7PwWxmjmqUNRTvkfavOAMVUpuH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502057AbfFLP7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:59:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44578 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438018AbfFLP7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=O8m1fIy1GoaBa9TPUr7v0TsZNi+TbBEkVZJ2zWTnQVY=; b=w2sQEbqRsxb6
        RK2SRGRAY9Bnld1nm2B5mhe5d/5CuT5ejQMZ3Zoh/S5VJVlD+HgsNlqAina3bYEuex9wiMAi7cC3n
        B4+m3roiE3gXSLdr+mhIU40Jq+AOzWuX/tO+a7ySshi/lsfTyY4hF6fP0Rt+h9EthDS+y8fclDInN
        rB+S8=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hb5f6-00036d-Jf; Wed, 12 Jun 2019 15:59:44 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 16CCE440046; Wed, 12 Jun 2019 16:59:44 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: 88pm800: fix warning same module names" to the regulator tree
In-Reply-To: <20190612081158.1424-1-anders.roxell@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190612155944.16CCE440046@finisterre.sirena.org.uk>
Date:   Wed, 12 Jun 2019 16:59:44 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: 88pm800: fix warning same module names

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.3

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

From 6f10419187d0d5fe395e2a2f2a64370961bf02a3 Mon Sep 17 00:00:00 2001
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 12 Jun 2019 10:11:58 +0200
Subject: [PATCH] regulator: 88pm800: fix warning same module names

When building with CONFIG_MFD_88PM800 and CONFIG_REGULATOR_88PM800
enabled as loadable modules, we see the following warning:

warning: same module names found:
  drivers/regulator/88pm800.ko
  drivers/mfd/88pm800.ko

Rework so that the file is named 88pm800-regulator.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/{88pm800.c => 88pm800-regulator.c} | 0
 drivers/regulator/Makefile                           | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/regulator/{88pm800.c => 88pm800-regulator.c} (100%)

diff --git a/drivers/regulator/88pm800.c b/drivers/regulator/88pm800-regulator.c
similarity index 100%
rename from drivers/regulator/88pm800.c
rename to drivers/regulator/88pm800-regulator.c
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 76e78fa449a2..c15b0b613766 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_REGULATOR_VIRTUAL_CONSUMER) += virtual.o
 obj-$(CONFIG_REGULATOR_USERSPACE_CONSUMER) += userspace-consumer.o
 
 obj-$(CONFIG_REGULATOR_88PG86X) += 88pg86x.o
-obj-$(CONFIG_REGULATOR_88PM800) += 88pm800.o
+obj-$(CONFIG_REGULATOR_88PM800) += 88pm800-regulator.o
 obj-$(CONFIG_REGULATOR_88PM8607) += 88pm8607.o
 obj-$(CONFIG_REGULATOR_CPCAP) += cpcap-regulator.o
 obj-$(CONFIG_REGULATOR_AAT2870) += aat2870-regulator.o
-- 
2.20.1

