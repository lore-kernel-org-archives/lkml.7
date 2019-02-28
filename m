Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0D3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AEAC2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367986;
	bh=3KMSoKF2lXxLtF/xHMQLLdK0xqwETA/iRrw+b8YAq4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tWGhk4l8jZtueJyG5dDhKa4QO0jm0bO7+iMoPluoH64Rtt8XkU/Ty7reQ0794FqMY
	 sICNZztWUx/AsiZOun5og7mKzAO2H9GULxW0WaY8vTDiDQwPAIJDznIbio5bjdMzb5
	 ZfWlPOjr+4OQu1ZHItlVWp9Hsvq8rf1mXaT4GXxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388183AbfB1PdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:33:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733133AbfB1PIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:08:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E5D0218E0;
        Thu, 28 Feb 2019 15:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366528;
        bh=3KMSoKF2lXxLtF/xHMQLLdK0xqwETA/iRrw+b8YAq4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EOGwbtlQ8nxR486CuaZU+fyBMxnRJ1Jpn9hFwK5QO60kJVe5kGanrCpx76vhb78w1
         CbMjvDJ/Pb1v47HTxbQRCCr7uuLGFDFJua+cEDjUEOuU7ak9j2jBKbZ8fYRMOXKq2J
         ED+u349RBeRMLQ4phmyZLUCeXErcr2BlDYlkkbpM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 22/81] arm64: dts: add msm8996 compatible to gicv3
Date:   Thu, 28 Feb 2019 10:07:14 -0500
Message-Id: <20190228150813.10256-22-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit 2a81efb0de0e33f2d2c83154af0bd3ce389b3269 ]

Add compatible to gicv3 node to enable quirk required to restrict writing
to GICR_WAKER register which is restricted on msm8996 SoC in Hypervisor.

With this quirk MSM8996 can at least boot out of mainline, which can help
community to work with boards based on MSM8996.

Without this patch Qualcomm DB820c board reboots on mainline.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index b29fe80d72883..461612a5ab5e4 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -397,7 +397,7 @@
 		};
 
 		intc: interrupt-controller@9bc0000 {
-			compatible = "arm,gic-v3";
+			compatible = "qcom,msm8996-gic-v3", "arm,gic-v3";
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			#redistributor-regions = <1>;
-- 
2.19.1

