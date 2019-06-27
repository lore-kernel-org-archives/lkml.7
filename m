Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3558C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994E32083B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561595436;
	bh=4ls0OFPOHs1mtvkhCaigyk9MntHVov4YldsHgH1u9fA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d9mdlOJAgr0Ht7BSktTt4UilQ1euIh/crfB2ty/kZKUstVb6OE6ShkjbcU2RU5xij
	 1I9GRIqnu/04+rCOqjeMgCs4tJXd/D8cdaaTnDtKloF/NVQhNHfckeKcus8Viklh/M
	 nRMnuyh5fouAADN+tgte6383qaVKcVLToa/XIoSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfF0Aae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:30:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbfF0Aad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:30:33 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF60E21738;
        Thu, 27 Jun 2019 00:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595432;
        bh=4ls0OFPOHs1mtvkhCaigyk9MntHVov4YldsHgH1u9fA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=05iasPO6oaTJJS7NE1xOAKWjpcK9MbOfeacLef5YjQ1DggC8DUKPsnD4J8db2F8Z/
         U/Wx4V5enowd5Arab5HxH99LWm7c98NCmIAKw9owyW1GQtGmQmOyoedgcjdq2nk9Q6
         dMdSxDCZ9Ygt9eqqmu8+7lgohpNgA/fFuUJBz830=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Keerthy <j-keerthy@ti.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 03/95] ARM: dts: dra71x: Disable rtc target module
Date:   Wed, 26 Jun 2019 20:28:48 -0400
Message-Id: <20190627003021.19867-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003021.19867-1-sashal@kernel.org>
References: <20190627003021.19867-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keerthy <j-keerthy@ti.com>

[ Upstream commit fe9edfe648ac444150ec95da1fb10e2728cc9789 ]

Introduce dra71x.dtsi to include dra71x specific changes.
rtc is fused out on dra71 and accessing target module
register is causing a boot crash hence disable it.

Fixes: 549fce068a3112 ("ARM: dts: dra7: Add l4 interconnect hierarchy and ti-sysc data")
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/dra71-evm.dts |  2 +-
 arch/arm/boot/dts/dra71x.dtsi   | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/dra71x.dtsi

diff --git a/arch/arm/boot/dts/dra71-evm.dts b/arch/arm/boot/dts/dra71-evm.dts
index 82cc7ec37af0..c496ae83e27e 100644
--- a/arch/arm/boot/dts/dra71-evm.dts
+++ b/arch/arm/boot/dts/dra71-evm.dts
@@ -6,7 +6,7 @@
  * published by the Free Software Foundation.
  */
 
-#include "dra72-evm-common.dtsi"
+#include "dra71x.dtsi"
 #include "dra7-mmc-iodelay.dtsi"
 #include "dra72x-mmc-iodelay.dtsi"
 #include <dt-bindings/net/ti-dp83867.h>
diff --git a/arch/arm/boot/dts/dra71x.dtsi b/arch/arm/boot/dts/dra71x.dtsi
new file mode 100644
index 000000000000..aad7394902a6
--- /dev/null
+++ b/arch/arm/boot/dts/dra71x.dtsi
@@ -0,0 +1,13 @@
+/*
+ * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "dra72-evm-common.dtsi"
+
+&rtctarget {
+	status = "disabled";
+};
-- 
2.20.1

