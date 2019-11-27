Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398ACC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11ED620674
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfK0PNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:13:35 -0500
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:48549 "EHLO
        alexa-out-blr-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726984AbfK0PNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 10:13:33 -0500
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr-02.qualcomm.com with ESMTP/TLS/AES256-SHA; 27 Nov 2019 20:43:25 +0530
IronPort-SDR: 4spPvObFyNU5G2WR8swjaJC+AbOWsfJZt/E0sJxnLN8DW+2uNQ2F/L2uT4miSfxBWCbnv5kF7l
 mQqtqgn620ugCUdZuddHN5nCnTrsyeWrD2pwcMKR1B9d2sSzG/ggfNBbNe03iH3kGJc04TNZk2
 PKpWRXx1YSSTJ8yi5jqqHoD7S5suB0O6yYgPcWr+nFeQcAy3poBYjWqHRZv/B5kJLAJJ+M1RI5
 E7xCljJXUJrCrU4JvG9usKUy4Fe0ONhpOeXbyYOmz93f022T4rhzDcUbYWleKBCsI4rGa7evZl
 RAmrgez5OtduujDLuPNw1HOu
Received: from gokulsri-linux.qualcomm.com ([10.201.2.207])
  by ironmsg01-blr.qualcomm.com with ESMTP; 27 Nov 2019 20:42:58 +0530
Received: by gokulsri-linux.qualcomm.com (Postfix, from userid 432570)
        id D67F0398C; Wed, 27 Nov 2019 20:42:55 +0530 (IST)
From:   Gokul Sriram Palanisamy <gokulsri@codeaurora.org>
To:     gokulsri@codeaurora.org, sboyd@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, david.brown@linaro.org,
        devicetree@vger.kernel.org, jassisinghbrar@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, ohad@wizery.com,
        robh+dt@kernel.org, sricharan@codeaurora.org,
        nprakash@codeaurora.org
Subject: [PATCH V3 08/10] dt-bindings: firmware: qcom: Add compatible for IPQ8074 SoC
Date:   Wed, 27 Nov 2019 20:42:52 +0530
Message-Id: <1574867574-2216-9-git-send-email-gokulsri@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1574867574-2216-1-git-send-email-gokulsri@codeaurora.org>
References: <1574867574-2216-1-git-send-email-gokulsri@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for IPQ8074 support.
This does not need clocks for scm calls.

Signed-off-by: Gokul Sriram Palanisamy <gokulsri@codeaurora.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
index 3f29ea0..3c5d37c 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
@@ -10,6 +10,7 @@ Required properties:
  * "qcom,scm-apq8064"
  * "qcom,scm-apq8084"
  * "qcom,scm-ipq4019"
+ * "qcom,scm-ipq8074"
  * "qcom,scm-msm8660"
  * "qcom,scm-msm8916"
  * "qcom,scm-msm8960"
-- 
1.9.1

