Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF84C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC6120684
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="d0C+nItl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfDXJ51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:57:27 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14504 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfDXJ50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:57:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cc033020000>; Wed, 24 Apr 2019 02:57:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 24 Apr 2019 02:57:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 24 Apr 2019 02:57:25 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Apr
 2019 09:57:24 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 24 Apr 2019 09:57:25 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cc033020001>; Wed, 24 Apr 2019 02:57:24 -0700
From:   Wei Ni <wni@nvidia.com>
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <edubezval@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <rui.zhang@intel.com>,
        <srikars@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Wei Ni <wni@nvidia.com>
Subject: [PATCH] arm64: defconfig: Enable TEGRA_SOCTHERM
Date:   Wed, 24 Apr 2019 17:56:59 +0800
Message-ID: <1556099819-15553-1-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556099842; bh=3Zl50xPDs9YMxHDoegrqA8p5DSe1qZQvYV9scE9dHYI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=d0C+nItlShd+4jzpwfN/ngpQJTuEYkZJzXk2BAx4kcQ15otPTTmDGjMfC4ke87QQz
         jY8JAFHx/vM74imSnQUnMS70VXtlRvWFBdCTa/IFWSxiLFg1qxi6KdewlPfUEte+uN
         dNS8BwqN9UfDR0ByYJkK6I19+ZsiPA2BRNIrsdYEdS/qdLEq3Z1yekfVFUj5Yulj+4
         u4QjC/9UGzB4TkNEoWUyyQuiGUqrXIVDOP7fV7H5oY4/c/jQr6L1fn/Q2uL0NrBvsx
         wfd3oB/rnAQ8XVLtEuBhj5K26ranSebEe1Rba3WleYWS+zUTnfbIhq4tW61YjMY39U
         tQIS/U7aToK8w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Tegra soctherm, and builds as kernel.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c8432e24207e..3d8f9d5bf7cb 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -406,6 +406,7 @@ CONFIG_ARMADA_THERMAL=y
 CONFIG_BCM2835_THERMAL=m
 CONFIG_BRCMSTB_THERMAL=m
 CONFIG_EXYNOS_THERMAL=y
+CONFIG_TEGRA_SOCTHERM=y
 CONFIG_TEGRA_BPMP_THERMAL=m
 CONFIG_QCOM_TSENS=y
 CONFIG_UNIPHIER_THERMAL=y
-- 
2.7.4

