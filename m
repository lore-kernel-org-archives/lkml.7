Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B895C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B3E2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565787196;
	bh=ozSvUfuy0tlEOLeLXY303hhvAHSOWvlhS6BaeKgVStU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l15ld16Py2MAsONxKxV3CHlAnv/VxnaSvRLxUMltzx4CGlWw/VKbyDm3++/mv6U6M
	 BaqM0eaio7MX07Uvoq2LD+L45iGKyThO4DRO6JHzAlLwfXFneg3YNWrGaLfcxveKI/
	 rjlpfQGnYQ16hWe+w2yRY64sVEX3ZfNvwkiJnjH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfHNMxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:53:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbfHNMxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:53:12 -0400
Received: from localhost.localdomain (unknown [171.76.115.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5E9520679;
        Wed, 14 Aug 2019 12:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565787192;
        bh=ozSvUfuy0tlEOLeLXY303hhvAHSOWvlhS6BaeKgVStU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eXEkDRz5zqT5G5aV+1O9GdR5OPrgNlzGc5ad9clKYpLXLI/8gHQcxfPhFehS2Fpjd
         ddFFUuAtEjalEx2hyeB8zlioqAvmeeAqW/23RhuoiHJM64L0ByHiwU1jNlUMfZR8hd
         xstVadxH8stsCxNY0EtdFwa0JPSv0kZDk7X95V10=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        sibis@codeaurora.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 22/22] arm64: dts: qcom: sm8150: Add APSS shared mailbox
Date:   Wed, 14 Aug 2019 18:20:12 +0530
Message-Id: <20190814125012.8700-23-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814125012.8700-1-vkoul@kernel.org>
References: <20190814125012.8700-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sibi Sankar <sibis@codeaurora.org>

Add APSS shared mailbox support to SM8150 SoC.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 5df3f335272a..88cbab4a9297 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -5,6 +5,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-sm8150.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/clock/qcom,rpmh.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -338,6 +339,16 @@
 			#interrupt-cells = <2>;
 		};
 
+		aoss_qmp: qmp@c300000 {
+			compatible = "qcom,sm8150-aoss-qmp";
+			reg = <0x0c300000 0x100000>;
+			interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
+			mboxes = <&apss_shared 0>;
+
+			#clock-cells = <0>;
+			#power-domain-cells = <1>;
+		};
+
 		intc: interrupt-controller@17a00000 {
 			compatible = "arm,gic-v3";
 			interrupt-controller;
-- 
2.20.1

