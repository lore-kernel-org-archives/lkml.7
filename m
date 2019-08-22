Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9CFC3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A198E23400
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566493625;
	bh=oN3Ury37sY82D5BeAB9tobRew6eqydmgK1etyuwpiRs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Py7ydFmBCzMMifdyfF1erMVlwqmxJM1CLZH4JzTwtAnLxqj1D7IDsVLWKosowD8Bh
	 obF5qHD4VH1/dJUmtdd95pp5D6DW3wVTuExnCa9sIxS5yKfm1epqA0A4d1jANmZqHk
	 KgsNr0apAXyjQUcE5h+osHhUV+3zGSGVAf50z8oI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388768AbfHVRHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:07:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387423AbfHVRHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:07:04 -0400
Received: from localhost.localdomain (unknown [171.61.89.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F58B20870;
        Thu, 22 Aug 2019 17:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566493623;
        bh=oN3Ury37sY82D5BeAB9tobRew6eqydmgK1etyuwpiRs=;
        h=From:To:Cc:Subject:Date:From;
        b=v7oI7Sw64DCHb0u8sGCmdf/6AWDj8b9Bt5pqLtLAVKwDx4ZoZ1Jsvc7AiCTSNeg9N
         CNiXep9anH/zsBA0fIk3vDHdId0Lifa7rBi2pdD3VxZtogE3rh0yWrI7IM0HM66Sh/
         WHWy4GUHcXG8S9SmZctv8SsoO7CT6M2axn3iiOaY=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sm8150: Update parent clock for rpmhcc
Date:   Thu, 22 Aug 2019 22:35:33 +0530
Message-Id: <20190822170533.8056-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since rphmcc expects the parent clock name as 'xo_board', update the
parent clock name.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 379c40b9a52f..f92c590fd3dc 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -650,7 +650,7 @@
 			rpmhcc: clock-controller {
 				compatible = "qcom,sm8150-rpmh-clk";
 				#clock-cells = <1>;
-				clock-names = "xo";
+				clock-names = "xo_board";
 				clocks = <&xo_board>;
 			};
 		};
-- 
2.20.1

