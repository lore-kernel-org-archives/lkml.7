Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975EBC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70225218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564062823;
	bh=cMJeU4U6fEFwQnuGwpkwTm19pQ/sRMZ+XMah9GBSiCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Iq2rVfPbxR0zKTQpZNDqOr3VRx+pE6D8hlRaS/pRtXblzxvttliTnS8FPfV7sk9i4
	 rY03izW+vhl6eA2wPZyaYRgUjyE0sf+zgKRLr1XBwsNI+95JyQTsK8tbaBH9VH4yeU
	 jSclqwSVnDiqteafkQLWGviSIDbquK1YYhT/UdUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403959AbfGYNxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:53:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403804AbfGYNxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:53:40 -0400
Received: from localhost.localdomain (unknown [106.200.241.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E205F218F0;
        Thu, 25 Jul 2019 13:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564062819;
        bh=cMJeU4U6fEFwQnuGwpkwTm19pQ/sRMZ+XMah9GBSiCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cmCJwuqKo1PLsRqleRDCC9jT2cFuhJAbqrH0AfMSsL/pGfgjksARVgr4fsNDugDeR
         q8BfWZwKzhelsOokumBWXDg/DECyGFM9jp0Cd5T28a2x5FSlBu3/YLvgEshsjIIRWG
         XBmRcS71hoexbBf5qDtAvZve+8GEFCft5glL45vw=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: qcom: pms405: remove reduandant properties
Date:   Thu, 25 Jul 2019 19:21:49 +0530
Message-Id: <20190725135150.9972-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725135150.9972-1-vkoul@kernel.org>
References: <20190725135150.9972-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pms405@1 nodes specified unnecessary #address-cells/#size-cells but the
subnodes dont have "ranges" or "reg" so remove it

arch/arm64/boot/dts/qcom/pms405.dtsi:141.21-150.4: Warning (avoid_unnecessary_addr_size): /soc@0/spmi@200f000/pms405@1: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/pms405.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
index 3c10cf04d26e..32678f7ce90d 100644
--- a/arch/arm64/boot/dts/qcom/pms405.dtsi
+++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
@@ -141,8 +141,6 @@
 	pms405_1: pms405@1 {
 		compatible = "qcom,spmi-pmic";
 		reg = <0x1 SPMI_USID>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		pms405_spmi_regulators: regulators {
 			compatible = "qcom,pms405-regulators";
-- 
2.20.1

