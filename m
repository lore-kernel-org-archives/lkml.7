Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569D1C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C89424650
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="hXAjJ5R7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfLRNWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 08:22:47 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:59368 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727031AbfLRNWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 08:22:44 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576675363; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=m6ttDN+G5Ey1zh5xz/1rJtNZVDUN54jDpguHBQQNlKY=; b=hXAjJ5R7YId3lRL8VmEuLHps41TOA0e+CoLjbhuIVduU+W6SU/6O5L7TiImoApNO0hydOXzk
 VMt8Ujv67f56uareRBe1HhO41YanUzDPyBnolhQfO+byLEbM02pS/NV3pPug33id95qVVNXq
 lTMN4+QOSYtrXn5SoFlkHuiP0/M=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa281f.7f3cce59c768-smtp-out-n01;
 Wed, 18 Dec 2019 13:22:39 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 01866C43383; Wed, 18 Dec 2019 13:22:38 +0000 (UTC)
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F0CB1C4479D;
        Wed, 18 Dec 2019 13:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F0CB1C4479D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, jhugo@codeaurora.org,
        robh+dt@kernel.org
Cc:     ohad@wizery.com, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, Sibi Sankar <sibis@codeaurora.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/5] dt-bindings: remoteproc: qcom: Add ADSP and SLPI support for MSM8998 SoC
Date:   Wed, 18 Dec 2019 18:52:14 +0530
Message-Id: <20191218132217.28141-3-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20191218132217.28141-1-sibis@codeaurora.org>
References: <20191218132217.28141-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ADSP and SLPI compatibles for MSM8998 SoC.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
index a54465d938f64..9938918b2fea3 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
@@ -10,6 +10,8 @@ on the Qualcomm ADSP Hexagon core.
 		    "qcom,msm8974-adsp-pil"
 		    "qcom,msm8996-adsp-pil"
 		    "qcom,msm8996-slpi-pil"
+		    "qcom,msm8998-adsp-pas"
+		    "qcom,msm8998-slpi-pas"
 		    "qcom,qcs404-adsp-pas"
 		    "qcom,qcs404-cdsp-pas"
 		    "qcom,qcs404-wcss-pas"
@@ -33,6 +35,8 @@ on the Qualcomm ADSP Hexagon core.
 	qcom,msm8974-adsp-pil:
 	qcom,msm8996-adsp-pil:
 	qcom,msm8996-slpi-pil:
+	qcom,msm8998-adsp-pas:
+	qcom,msm8998-slpi-pas:
 	qcom,qcs404-adsp-pas:
 	qcom,qcs404-cdsp-pas:
 	qcom,sdm845-adsp-pas:
@@ -86,9 +90,12 @@ on the Qualcomm ADSP Hexagon core.
 	Definition: The power-domains needed depend on the compatible string:
 	qcom,msm8974-adsp-pil:
 	qcom,msm8996-adsp-pil:
+	qcom,msm8998-adsp-pas:
 		    must be "cx"
 	qcom,msm8996-slpi-pil:
 		    must be "ss_cx"
+	qcom,msm8998-slpi-pas:
+		    must be "ssc_cx"
 	qcom,qcs404-adsp-pas:
 		    must be "lpi_cx"
 	qcom,qcs404-cdsp-pas:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
