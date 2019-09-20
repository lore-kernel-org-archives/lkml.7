Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD46C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C80222D1
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A+H7cEw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437692AbfITIAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 04:00:21 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44004 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437680AbfITIAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 04:00:20 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8K802R5035673;
        Fri, 20 Sep 2019 03:00:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568966402;
        bh=hPVf1Poa33Pi1B+Nvl5mwDLiUwBQdGQUSOya3aDoUBw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=A+H7cEw/NCFrGPzd+iSisGTGUTC0Du6kPLR4a4dNGW4bJaqK42Iv2RIW3tBBJlKUw
         DUokoPkjMKKcqn6I3j5t4eXtc3l81zN0Hx1KVcMp+Yn/Z7C5reH/e+WefrriVVzIXj
         In6hctgr4LvyUe+nLudEMeRx7ImXUGwTQ1yWipwc=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8K802VM058080
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Sep 2019 03:00:02 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 20
 Sep 2019 02:59:57 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 20 Sep 2019 03:00:01 -0500
Received: from a0393675ula.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8K7xeXW118255;
        Fri, 20 Sep 2019 02:59:57 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <arnd@arndb.de>, <nsekhar@ti.com>, <olof@lixom.net>,
        <t-kristo@ti.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <tony@atomide.com>
CC:     <s-anna@ti.com>, <hch@lst.de>, <bjorn.andersson@linaro.org>,
        <j-keerthy@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 linux-next 4/4] arm64: configs: defconfig: Change CONFIG_REMOTEPROC from m to y
Date:   Fri, 20 Sep 2019 13:29:46 +0530
Message-ID: <20190920075946.13282-5-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190920075946.13282-1-j-keerthy@ti.com>
References: <20190920075946.13282-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6334150e9a36 ("remoteproc: don't allow modular build")
changes CONFIG_REMOTEPROC to a boolean from a tristate config
option which inhibits all defconfigs marking CONFIG_REMOTEPROC as
a module in compiling the remoteproc and dependent config options.

So fix the defconfig to have CONFIG_REMOTEPROC built in.

Fixes: 6334150e9a36 ("remoteproc: don't allow modular build")
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8e05c39eab08..c9a867ac32d4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -723,7 +723,7 @@ CONFIG_TEGRA_IOMMU_SMMU=y
 CONFIG_ARM_SMMU=y
 CONFIG_ARM_SMMU_V3=y
 CONFIG_QCOM_IOMMU=y
-CONFIG_REMOTEPROC=m
+CONFIG_REMOTEPROC=y
 CONFIG_QCOM_Q6V5_MSS=m
 CONFIG_QCOM_Q6V5_PAS=m
 CONFIG_QCOM_SYSMON=m
-- 
2.17.1

