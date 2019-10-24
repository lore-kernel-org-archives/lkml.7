Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC526CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD86021872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571903327;
	bh=yxBzuY5vQ1qSryK6IQg7fvOnrKcvDa+SSEeBRqhkPxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MY7RLCcTTOq0CUDP43mYHc2V9RW4xDRmuVygeDaue91Us1n8lBYvdHkKJeB94mmjX
	 ZcoAx5/KXkD8p6cOvoHNVfTf4vDwC5ifjWV7mLS3pyF8rbRLOzZlw6Htk/gysmqVm8
	 d0Lby4W2/J9zbYOERkQJK3MYgx3V6wZtfxtNnHNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408733AbfJXHsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 03:48:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404701AbfJXHsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 03:48:45 -0400
Received: from localhost.localdomain (unknown [122.181.210.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7662E2084C;
        Thu, 24 Oct 2019 07:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571903324;
        bh=yxBzuY5vQ1qSryK6IQg7fvOnrKcvDa+SSEeBRqhkPxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pF2kgEu9XntoVcWKyu8gAlTtFColK9gK1fB7ANdbn7GNLfZjh0V85EZwEDBY12puM
         /SYx3sBcdxLVtsrrfxEvzg03JeUisxhA783KqrJv7FAyBeCSxzHJWfh4DhuXp+0qib
         NqPkybYe+qwnHVFMrKDiPGDCBR04nBqjyh8gKhIA=
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/3] dt-bindings: phy-qcom-qmp: Add sm8150 UFS phy compatible string
Date:   Thu, 24 Oct 2019 13:18:01 +0530
Message-Id: <20191024074802.26526-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024074802.26526-1-vkoul@kernel.org>
References: <20191024074802.26526-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document "qcom,sdm845-qmp-ufs-phy" compatible string for QMP UFS PHY
found on SM8150.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
index 085fbd676cfc..eac9ad3cbbc8 100644
--- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
+++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
@@ -14,7 +14,8 @@ Required properties:
 	       "qcom,msm8998-qmp-pcie-phy" for PCIe QMP phy on msm8998,
 	       "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
 	       "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845,
-	       "qcom,sdm845-qmp-ufs-phy" for UFS QMP phy on sdm845.
+	       "qcom,sdm845-qmp-ufs-phy" for UFS QMP phy on sdm845,
+	       "qcom,sm8150-qmp-ufs-phy" for UFS QMP phy on sm8150.
 
 - reg:
   - index 0: address and length of register set for PHY's common
@@ -57,6 +58,8 @@ Required properties:
 			"aux", "cfg_ahb", "ref", "com_aux".
 		For "qcom,sdm845-qmp-ufs-phy" must contain:
 			"ref", "ref_aux".
+		For "qcom,sm8150-qmp-ufs-phy" must contain:
+			"ref", "ref_aux".
 
  - resets: a list of phandles and reset controller specifier pairs,
 	   one for each entry in reset-names.
@@ -83,6 +86,8 @@ Required properties:
 			"phy", "common".
 		For "qcom,sdm845-qmp-ufs-phy": must contain:
 			"ufsphy".
+		For "qcom,sm8150-qmp-ufs-phy": must contain:
+			"ufsphy".
 
  - vdda-phy-supply: Phandle to a regulator supply to PHY core block.
  - vdda-pll-supply: Phandle to 1.8V regulator supply to PHY refclk pll block.
-- 
2.20.1

