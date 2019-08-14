Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89442C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5709921851
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565787157;
	bh=7WQuUjVMmL4PBTu7P4cZtXz6D1Ii+nE4BtX+Ncjxxqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CRMR0C/Q10zeYjzx1IqUQ1b7nBpMI2UMKx+o9yOKwwSn66NORWNx0rCXz/oEFPqfS
	 GZp87sa2C6ss16/OBYyT/iq8lHEvcHKRZLjbe6+z1Lwx2KABYpAsi2re9Xzf8DAXJL
	 IhjZYk9P9seww0VCCY01+CBShAf8MkCoNeSD9wlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbfHNMwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:52:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727687AbfHNMwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:52:33 -0400
Received: from localhost.localdomain (unknown [171.76.115.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC6522173E;
        Wed, 14 Aug 2019 12:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565787153;
        bh=7WQuUjVMmL4PBTu7P4cZtXz6D1Ii+nE4BtX+Ncjxxqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LxP/3/7SL9w3z7zyDrqh/C/7pgsHhqtbiCEcHUfedA5/26mkWlstb02IItY6pmrJq
         /47VQPKeE3xlNfJBbOgvFNm9pzX5C9wv3a3dxQBNe1kXUzCMy5Bag204bBZSrQ1UNg
         1a/t6PPrvVttR3SYF41VjXngoTJCgDXyX/oAtPHc=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        sibis@codeaurora.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/22] arm64: dts: qcom: pm8150l: Add Base DTS file
Date:   Wed, 14 Aug 2019 18:20:02 +0530
Message-Id: <20190814125012.8700-13-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814125012.8700-1-vkoul@kernel.org>
References: <20190814125012.8700-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMIC pm8150l is a slave pmic and this adds base DTS file for pm8150l

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/pm8150l.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8150l.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm8150l.dtsi b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
new file mode 100644
index 000000000000..e61ae6c6dab5
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: BSD-3-Clause
+// Copyright (c) 2017-2019, The Linux Foundation. All rights reserved.
+// Copyright (c) 2019, Linaro Limited
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+	qcom,pm8150@4 {
+		compatible = "qcom,spmi-pmic";
+		reg = <0x4 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	qcom,pm8150@5 {
+		compatible ="qcom,spmi-pmic";
+		reg = <0x5 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
-- 
2.20.1

