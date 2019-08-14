Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344F4C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17132084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565787118;
	bh=U9fFbuVzc4LEqqWOrNyEZ5ikhqBVDg7ffc0M2AFmXig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lb1AunpVmENYVrRlA1hOXnL4h7wmsaoDSAbUz9n/bYs/1pElIipja2sDeSN61CQgi
	 PlhvfrcdJJX3jL5MJoXkZ3pPAwBQFLFcqvw+4LQ0J55DgnedN4AXZoD06l38uA+5nO
	 CufDzxsyJX041Rdesxea10BC76RZP1SA+gimDQfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfHNMv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:51:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfHNMvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:51:55 -0400
Received: from localhost.localdomain (unknown [171.76.115.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04D0A20679;
        Wed, 14 Aug 2019 12:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565787114;
        bh=U9fFbuVzc4LEqqWOrNyEZ5ikhqBVDg7ffc0M2AFmXig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SKtONsbFspx+FR85885TpoP/PyvAWb9YgJaLsl/No6Q6z3JCO+AoijFhWm68uuI8W
         zEgfu65F6krw7VCWgdcQcxiUMFMe2j3DigTmGWpyZRQW4yplSbBFBoEa2P9TEKZHfk
         GsCQYvy1BKnOJFKRzt2oxPDlesaSne14tk7sfqA8=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        sibis@codeaurora.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/22] arm64: dts: qcom: sm8150-mtp: add base dts file
Date:   Wed, 14 Aug 2019 18:19:52 +0530
Message-Id: <20190814125012.8700-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814125012.8700-1-vkoul@kernel.org>
References: <20190814125012.8700-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add base DTS file for sm8150-mtp and enables
boot to console

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/Makefile       |  1 +
 arch/arm64/boot/dts/qcom/sm8150-mtp.dts | 28 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8150-mtp.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 0a7e5dfce6f7..1964dacaf19b 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -12,5 +12,6 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-db845c.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-mtp.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
new file mode 100644
index 000000000000..df08ee50510d
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: BSD-3-Clause
+// Copyright (c) 2017-2019, The Linux Foundation. All rights reserved.
+// Copyright (c) 2019, Linaro Limited
+
+/dts-v1/;
+
+#include "sm8150.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. SM8150 MTP";
+	compatible = "qcom,sm8150-mtp";
+
+	aliases {
+		serial0 = &uart2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&qupv3_id_1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
-- 
2.20.1

