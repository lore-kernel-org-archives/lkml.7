Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC60C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A2F20673
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iuR13AqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfFEGNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 02:13:41 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58514 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfFEGNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:13:41 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x556DZ2X069763;
        Wed, 5 Jun 2019 01:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559715215;
        bh=rdyTlwtVkqWcf1wxy9yGAqYRQwMjmBu/dJqDSVxUhhI=;
        h=From:To:CC:Subject:Date;
        b=iuR13AqWknkLIvC2v8Q5XKNC4T75v5Z0uMnPkg7p9vX5fp/tsPTUndp648Dx2PXYb
         oz6ut8bhp8O/7r6+vkyBZ4arRnC/T0AxoAbCiO/mDdLt7UYaVf56yXQgms8zQc8l5B
         O/6iIgYit/dG+KGFqkLXEGJGJ5hYc1N+DTVTUtwU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x556DZ7G069839
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Jun 2019 01:13:35 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 5 Jun
 2019 01:13:35 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 5 Jun 2019 01:13:35 -0500
Received: from a0393675ula.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x556DWYt032504;
        Wed, 5 Jun 2019 01:13:32 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <will.deacon@arm.com>, <catalin.marinas@arm.com>,
        <shawnguo@kernel.org>
CC:     <lokeshvutla@ti.com>, <t-kristo@ti.com>, <nm@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <j-keerthy@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: configs: Enable GPIO_DAVINCI
Date:   Wed, 5 Jun 2019 11:44:01 +0530
Message-ID: <20190605061401.25806-1-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable GPIO_DAVINCI and related configs for TI K3 AM6 platforms.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d1b72f99e2f4..57d7a4c207bd 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -385,6 +385,9 @@ CONFIG_PINCTRL_QCS404=y
 CONFIG_PINCTRL_QDF2XXX=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
 CONFIG_PINCTRL_SDM845=y
+CONFIG_DEBUG_GPIO=y
+CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_DAVINCI=y
 CONFIG_GPIO_DWAPB=y
 CONFIG_GPIO_MB86S7X=y
 CONFIG_GPIO_PL061=y
-- 
2.17.1

