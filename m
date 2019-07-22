Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1535EC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D892221926
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563798961;
	bh=++3i5O/gh2yq9WCX9ipIlQvrO6+JP2lB2LqaOilGmHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NzSMdQuginP2AhXyK+MvgcCyJ3Djy9wmgVB+rlai3SCwbZ4kdzHzPlO1BTlKvF/VE
	 s/1e4+rOEh0t9dmUTKLRHE22UV95q2wpRLYZQjqyAEYNCOF63Fq9WZPD0up8qOyB3Z
	 2107/DQ62RhSvVN8V98ggiLfoBFxvmQidAAp2zd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbfGVMgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:36:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728062AbfGVMf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:35:59 -0400
Received: from localhost.localdomain (unknown [223.226.98.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DA8821926;
        Mon, 22 Jul 2019 12:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563798958;
        bh=++3i5O/gh2yq9WCX9ipIlQvrO6+JP2lB2LqaOilGmHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l2fF1ZsVJJSdqoZpYjYhZVw0htrT+05Jh31IgdgiAvnljQVoDADbBB4Px/SJc2exd
         npPGpaHxN9a9MBJ14M5+CYPim2IKyPszF27Kq2Kw21+3JZxHrUFHi34Hdgl6heOlzb
         66OZZwuiEYX74cNeXYjRrcTA5T8jMP1xwicfH0uA=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] arm64: dts: qcom: sdm845: remove unnecessary properties for dsi nodes
Date:   Mon, 22 Jul 2019 18:04:19 +0530
Message-Id: <20190722123422.4571-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722123422.4571-1-vkoul@kernel.org>
References: <20190722123422.4571-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get a warning about unnecessary properties of

arch/arm64/boot/dts/qcom/sdm845.dtsi:2211.22-2257.6: Warning (avoid_unnecessary_addr_size): /soc/mdss@ae00000/dsi@ae94000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
arch/arm64/boot/dts/qcom/sdm845.dtsi:2278.22-2324.6: Warning (avoid_unnecessary_addr_size): /soc/mdss@ae00000/dsi@ae96000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

So, remove these properties

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index e81f4a6d08ce..2985df032179 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2234,9 +2234,6 @@
 
 				status = "disabled";
 
-				#address-cells = <1>;
-				#size-cells = <0>;
-
 				ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
@@ -2301,9 +2298,6 @@
 
 				status = "disabled";
 
-				#address-cells = <1>;
-				#size-cells = <0>;
-
 				ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
-- 
2.20.1

