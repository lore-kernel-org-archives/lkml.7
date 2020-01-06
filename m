Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FB7C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8021021775
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578294529;
	bh=sqos0TyJ+0+0Ds+tEst1M9K4B3tyrzj2cQ2w0TirDlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vX20tnaEAuA4vvG4uujOodev9i8E/GNAxQSUr9p+uPkcCmPF2Fp6jO8/Md2f+EbPw
	 MWLWaoH4KM+5jmse1pXrUnjXoZ4msx/Z7WfD2dakNgI5U7x9tnyB5ck+gEaUWKu+Ld
	 XiBIl/oZvH89v5tJTlPMsccl0jYugPeYV/aR9aq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgAFHIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 02:08:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:42248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbgAFHIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 02:08:46 -0500
Received: from localhost.localdomain (unknown [117.99.94.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 534A7218AC;
        Mon,  6 Jan 2020 07:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578294526;
        bh=sqos0TyJ+0+0Ds+tEst1M9K4B3tyrzj2cQ2w0TirDlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gs192sWq35V84boAEPcES6snA8yLS0j18rLeRANU4rvYaSs8cCmrErswywuz+xgbf
         frhWgwCOH1A3jDqwZlrnvVUOduGRwicRj1qtkfpEEh+yvBOE/6vx7jMZAgNq6GnFQG
         Nd4H34uFceHb7RdB7bUlitf/rrCBNEsCch/bJGk8=
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Can Guo <cang@codeaurora.org>
Subject: [PATCH 2/3] arm64: dts: qcom: sm8150: Fix UFS phy register size
Date:   Mon,  6 Jan 2020 12:38:25 +0530
Message-Id: <20200106070826.147064-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106070826.147064-1-vkoul@kernel.org>
References: <20200106070826.147064-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UFS phy register space size is 0x1c0. so update it

Reported-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index f36d621a53e2..f92b92866ae0 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -553,7 +553,7 @@ ufs_mem_hc: ufshc@1d84000 {
 
 		ufs_mem_phy: phy@1d87000 {
 			compatible = "qcom,sm8150-qmp-ufs-phy";
-			reg = <0 0x01d87000 0 0x18c>;
+			reg = <0 0x01d87000 0 0x1c0>;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
-- 
2.24.1

