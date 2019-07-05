Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDEBC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9211216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Zr6tzeKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfGEQYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 12:24:16 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:48568 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725917AbfGEQYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:24:16 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E09D0C122A;
        Fri,  5 Jul 2019 16:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1562343856; bh=4o2VcCBEFxtaDIdwJ60rzFfjOLVW1pka2ZauMGQyOJA=;
        h=From:To:Cc:Subject:Date:From;
        b=Zr6tzeKamzNRKmkdCrAq3AB7XzU5sVVGD5XeKPD7RcfqR/sP+Kp+9AeTos4zKcFu7
         tINm5CMKyW4FRsc9SF7vS9iRZmekdjL5ywBbo3Y2UnvOz7trnEEHmvIVB4aIF+YfSd
         em50vQnwhX9mXMePz5DhBm33KU2joNbeaEE/KBqoRWSV9Sz5TwW9xB2DbQUp/9Npk+
         49JB+E9k6BcPASjA0/qLxd04KIsqPTg+D7OsGm3lOZtTsYnb5v9YXQjNliBA7FlJ/O
         rlcMEjtbAnhLd/irRW52Z//aCPm8Bc42w8ArgfD7PJaCj+LD5d2cOeKYBXLEr+mKqA
         LMHkECyTCYDxQ==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.79])
        by mailhost.synopsys.com (Postfix) with ESMTP id 24FA3A005D;
        Fri,  5 Jul 2019 16:24:11 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] ARC: [plat-hsdk]: Enable AXI DW DMAC in defconfig
Date:   Fri,  5 Jul 2019 19:24:09 +0300
Message-Id: <20190705162409.8916-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reasons my previous patch "Enable AXI DW DMAC support"
was applied only partially (only device tree part).
So enable AXI DW DMAC in HSDK defconfig to be able to use it in
verification flow.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/configs/hsdk_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defconfig
index c8fb5d60c53f..85e7921e0628 100644
--- a/arch/arc/configs/hsdk_defconfig
+++ b/arch/arc/configs/hsdk_defconfig
@@ -66,6 +66,8 @@ CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_DW=y
+CONFIG_DMADEVICES=y
+CONFIG_DW_AXI_DMAC=y
 CONFIG_EXT3_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
-- 
2.21.0

