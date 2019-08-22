Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB8EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686EA23404
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566493397;
	bh=hnznFt9S7TVw1/KfY6zUnuJXYTwixNogOEE40VUowrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rnJwVnhqbBJBQXA0baHpO4i5e4Qve4P57meMDhTiSowWZI9LSNtwZWMSwJ5rLtWz0
	 B1Nd9g96lufu062g6R3wBjyQVofizqfKCCT2UHe1YWNsXs1HcglNGfiF+FIJVEd0uj
	 ehS6kiIX1rDA09QS86MnEKqZImnpc44GCQa898w8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388706AbfHVRDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:03:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729506AbfHVRDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:03:15 -0400
Received: from localhost.localdomain (unknown [171.61.89.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 687B123402;
        Thu, 22 Aug 2019 17:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566493395;
        bh=hnznFt9S7TVw1/KfY6zUnuJXYTwixNogOEE40VUowrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EW1fqkENZQU4BenZGhzb+7Fa/dOlhEeE6BT/8K2N1+hMXZ5qvUk09TGaKoS6Yj9nz
         93uBdl8y617hbqQi6QrWyL5Tb3seXPnfqJNdGSMcAgGcWSz6Y6h3J5+BcUBhdtnjwP
         1L8e0UEsCV8CyU32sRPK/5KWFEGNNkqGOTXIiosk=
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] dt-bindings: clock: Document SM8150 rpmh-clock compatible
Date:   Thu, 22 Aug 2019 22:31:39 +0530
Message-Id: <20190822170140.7615-4-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822170140.7615-1-vkoul@kernel.org>
References: <20190822170140.7615-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the SM8150 rpmh-clock compatible for rpmh clock controller
found on SM8150 platforms.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/clock/qcom,rpmh-clk.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmh-clk.txt b/Documentation/devicetree/bindings/clock/qcom,rpmh-clk.txt
index 8b97968f9c88..365bbde599b1 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmh-clk.txt
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmh-clk.txt
@@ -6,7 +6,9 @@ some Qualcomm Technologies Inc. SoCs. It accepts clock requests from
 other hardware subsystems via RSC to control clocks.
 
 Required properties :
-- compatible : shall contain "qcom,sdm845-rpmh-clk"
+- compatible : must be one of:
+	       "qcom,sdm845-rpmh-clk"
+	       "qcom,sm8150-rpmh-clk"
 
 - #clock-cells : must contain 1
 - clocks: a list of phandles and clock-specifier pairs,
-- 
2.20.1

