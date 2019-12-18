Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA63FC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8032D227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ABnd9Usq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfLRNXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 08:23:00 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:36043 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727120AbfLRNW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 08:22:56 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576675375; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=YKKr2rMQN+7c/EIXv+84oUVSQ/Za4jjnWilPcRHWye4=; b=ABnd9UsqQVl0Stin2XUdHPmVNfVw2X6vEPJ76xLiLTk9jcmgk9o9B+kNBUO1zLI8Ca0x3pfK
 4YDo+Ohc2oPjR5aMfmAe7hO5jtYg/+BZ1hx5E86d+LpIbJbHknrfwY0l7+5XelaevrvmHsrD
 bzlXmT02scRz3oGPSFlCChGfMMg=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa2827.7fcf7e9a1848-smtp-out-n03;
 Wed, 18 Dec 2019 13:22:47 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1E12EC447A3; Wed, 18 Dec 2019 13:22:47 +0000 (UTC)
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C58E1C447A0;
        Wed, 18 Dec 2019 13:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C58E1C447A0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, jhugo@codeaurora.org,
        robh+dt@kernel.org
Cc:     ohad@wizery.com, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 4/5] arm64: dts: qcom: msm8998: Update reserved memory map
Date:   Wed, 18 Dec 2019 18:52:16 +0530
Message-Id: <20191218132217.28141-5-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20191218132217.28141-1-sibis@codeaurora.org>
References: <20191218132217.28141-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update existing and add missing regions to the reserved memory map, as
described in version 7.1

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 70 ++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 873912c19f6ed..8d799e868a5d3 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -29,8 +29,13 @@
 		#size-cells = <2>;
 		ranges;
 
-		memory@85800000 {
-			reg = <0x0 0x85800000 0x0 0x800000>;
+		hyp_mem: memory@85800000 {
+			reg = <0x0 0x85800000 0x0 0x600000>;
+			no-map;
+		};
+
+		xbl_mem: memory@85e00000 {
+			reg = <0x0 0x85e00000 0x0 0x100000>;
 			no-map;
 		};
 
@@ -39,25 +44,68 @@
 			no-map;
 		};
 
-		memory@86200000 {
+		tz_mem: memory@86200000 {
 			reg = <0x0 0x86200000 0x0 0x2d00000>;
 			no-map;
 		};
 
-		wlan_msa_mem: memory@95700000 {
-			reg = <0x0 0x95700000 0x0 0x100000>;
+		rmtfs_mem: memory@88f00000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0 0x88f00000 0x0 0x200000>;
 			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
 		};
 
-		rmtfs {
-			compatible = "qcom,rmtfs-mem";
+		spss_mem: memory@8ab00000 {
+			reg = <0x0 0x8ab00000 0x0 0x700000>;
+			no-map;
+		};
 
-			size = <0x0 0x200000>;
-			alloc-ranges = <0x0 0xa0000000 0x0 0x2000000>;
+		adsp_mem: memory@8b200000 {
+			reg = <0x0 0x8b200000 0x0 0x1a00000>;
 			no-map;
+		};
 
-			qcom,client-id = <1>;
-			qcom,vmid = <15>;
+		mpss_mem: memory@8cc00000 {
+			reg = <0x0 0x8cc00000 0x0 0x7000000>;
+			no-map;
+		};
+
+		venus_mem: memory@93c00000 {
+			reg = <0x0 0x93c00000 0x0 0x500000>;
+			no-map;
+		};
+
+		mba_mem: memory@94100000 {
+			reg = <0x0 0x94100000 0x0 0x200000>;
+			no-map;
+		};
+
+		slpi_mem: memory@94300000 {
+			reg = <0x0 0x94300000 0x0 0xf00000>;
+			no-map;
+		};
+
+		ipa_fw_mem: memory@95200000 {
+			reg = <0x0 0x95200000 0x0 0x10000>;
+			no-map;
+		};
+
+		ipa_gsi_mem: memory@95210000 {
+			reg = <0x0 0x95210000 0x0 0x5000>;
+			no-map;
+		};
+
+		gpu_mem: memory@95600000 {
+			reg = <0x0 0x95600000 0x0 0x100000>;
+			no-map;
+		};
+
+		wlan_msa_mem: memory@95700000 {
+			reg = <0x0 0x95700000 0x0 0x100000>;
+			no-map;
 		};
 	};
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
