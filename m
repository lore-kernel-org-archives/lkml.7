Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13EBC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 11:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C191221781
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 11:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfK1Ljo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 06:39:44 -0500
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:42513 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726670AbfK1Ljm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 06:39:42 -0500
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Nov 2019 06:39:40 EST
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 28 Nov 2019 17:03:32 +0530
IronPort-SDR: K08YTXR/j9WhCTvgCZWgAEPnFY17rVFk/lxj+crc66ef+AmFveKQMBBRHtmECy16DVCRdDJWsy
 XpOFcDrlGgwFQVOP3RK1TEH6UqGptdIk0uiM2zlI1PuhScrnYwoL8C1zhLdd0HAkZw9ouoVV+4
 uBzRfUZVrBw+Cmw16JgihhmLIEaSOXvY0x2zxla8jH5yC2CrDQqPkloJYynp5jqNIGiGuQNApM
 XGjSatqmJfTI8ijFhk1CQ0nEJDv8sE7T9QUb+y7WWr0OLyIXiIQegAzyrJO07xtyyX4dlkTYK5
 MAVN8Rm1CC/Jo36uiqlRsPFp
Received: from c-sanm-linux.qualcomm.com ([10.206.25.31])
  by ironmsg02-blr.qualcomm.com with ESMTP; 28 Nov 2019 17:03:14 +0530
Received: by c-sanm-linux.qualcomm.com (Postfix, from userid 2343233)
        id E1A8319C2; Thu, 28 Nov 2019 17:03:12 +0530 (IST)
From:   Sandeep Maheswaram <sanm@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandeep Maheswaram <sanm@codeaurora.org>
Subject: [PATCH v2 3/3] dt-bindings: usb: qcom,dwc3: Add compatible for SC7180
Date:   Thu, 28 Nov 2019 17:03:07 +0530
Message-Id: <1574940787-1004-4-git-send-email-sanm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574940787-1004-1-git-send-email-sanm@codeaurora.org>
References: <1574940787-1004-1-git-send-email-sanm@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for SC7180 in usb dwc3 bindings.

Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index 48ff9c5..3eab91a 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -15,6 +15,7 @@ properties:
       - enum:
           - qcom,msm8996-dwc3
           - qcom,msm8998-dwc3
+          - qcom,sc7180-dwc3
           - qcom,sdm845-dwc3
       - const: qcom,dwc3
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

