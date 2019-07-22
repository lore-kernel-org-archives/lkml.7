Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46A3C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7CA21926
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563798971;
	bh=GAx6Q3OY2wu5R+DpHESbk/0D0jjrWOl7Htf3MB2Iog4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EIrW7w665El8KmW7+b/ffLzrJ7ZI6pSWUw/SWFPmCPld/plYpkxBLo/phOnArsbZQ
	 xvYRRK9Xaar2AxoUOnr7K75fByGDE0BAQ6rXz1gFGNZApAI6G6u4nJ61A/pz93D+xZ
	 u9j1jY4hgHTX5/h9VNLT11CHR/CbSqwtiag3VusM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbfGVMgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:36:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbfGVMgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:36:06 -0400
Received: from localhost.localdomain (unknown [223.226.98.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0943C21985;
        Mon, 22 Jul 2019 12:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563798965;
        bh=GAx6Q3OY2wu5R+DpHESbk/0D0jjrWOl7Htf3MB2Iog4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m+zilTYM5e3FQQBCiwIMR++Qb1TD06n8Ipdr3VklZQ0YWcEq2BInXFBAJyVSQKo99
         b6I/De55BTsu5z/97aWLaVVfA/EccqE8/KpRyWHe19SIBUcdRlkok2vnUjt1+LVQTg
         Fp+Cxw4cxMe9T20yparAwqiefqNbGazD2SGGZmTY=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] arm64: dts: qcom: sdm845: remove macro from unit name
Date:   Mon, 22 Jul 2019 18:04:21 +0530
Message-Id: <20190722123422.4571-5-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722123422.4571-1-vkoul@kernel.org>
References: <20190722123422.4571-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unit name is supposed to be a number, using a macro with hex value is
not recommended, so add the value in unit name.

arch/arm64/boot/dts/qcom/pm8998.dtsi:81.18-84.6: Warning (unit_address_format): /soc/spmi@c440000/pmic@0/adc@3100/adc-chan@0x06: unit name should not have leading "0x"
arch/arm64/boot/dts/qcom/pm8998.dtsi:81.18-84.6: Warning (unit_address_format): /soc/spmi@c440000/pmic@0/adc@3100/adc-chan@0x06: unit name should not have leading 0s

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 051a52df80f9..d76c8377c224 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -78,7 +78,7 @@
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
 
-			adc-chan@ADC5_DIE_TEMP {
+			adc-chan@6{
 				reg = <ADC5_DIE_TEMP>;
 				label = "die_temp";
 			};
-- 
2.20.1

