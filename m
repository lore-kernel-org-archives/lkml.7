Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33FBC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5BE206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565787144;
	bh=GuUKwJX45IQZpMPvL/7FpSDUMkebqsknhrExHJ8k8fQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SQSxX+4zQL4bCF11kCXM4TVxg7WP8N2vnRyA/iymCLAT5Xa1wPzowjAFeiqScKo4J
	 u/iqftdmeJI7VSLHo6cgchBruO671rXZLW5PHRgiMXCVZvPgrwEDChzSRMmoI07Ull
	 kUpAwxhZAyV2cCSVyptnxYJp+jHnGVm8pWwEPSus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfHNMwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:52:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfHNMwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:52:22 -0400
Received: from localhost.localdomain (unknown [171.76.115.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A4B5206C2;
        Wed, 14 Aug 2019 12:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565787141;
        bh=GuUKwJX45IQZpMPvL/7FpSDUMkebqsknhrExHJ8k8fQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XqrsaOSNVwUjyQsEwsPfvKEDqQpWrqSR1Es9CavYJBlddXwxxRWsIvw+iQ9Z7EM8I
         kwj4EJAQTgGt/5XM9/8wgfGkQ6B6aEUCqopLb97FeaH9jYSdey0k4cKHPBbO6fJh9g
         a3szZuv9aCFHQXgz2vWKIAWNQsGiZcG815KEGwcE=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        sibis@codeaurora.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/22] arm64: dts: qcom: pm8150b: Add Base DTS file
Date:   Wed, 14 Aug 2019 18:19:59 +0530
Message-Id: <20190814125012.8700-10-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814125012.8700-1-vkoul@kernel.org>
References: <20190814125012.8700-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMIC pm8150b is a slave pmic and this adds base DTS file for pm8150b

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/pm8150b.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8150b.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm8150b.dtsi b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
new file mode 100644
index 000000000000..c0a678b0f159
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: BSD-3-Clause
+// Copyright (c) 2017-2019, The Linux Foundation. All rights reserved.
+// Copyright (c) 2019, Linaro Limited
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+	pm8150@2 {
+		compatible = "qcom,spmi-pmic";
+		reg = <0x2 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	qcom,pm8150@3 {
+		compatible ="qcom,spmi-pmic";
+		reg = <0x3 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
-- 
2.20.1

