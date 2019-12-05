Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA76C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 04:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F33E21835
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 04:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfLEEnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 23:43:31 -0500
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:23182 "EHLO
        alexa-out-blr-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728132AbfLEEna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 23:43:30 -0500
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-02.qualcomm.com with ESMTP/TLS/AES256-SHA; 05 Dec 2019 10:12:56 +0530
Received: from c-sanm-linux.qualcomm.com ([10.206.25.31])
  by ironmsg02-blr.qualcomm.com with ESMTP; 05 Dec 2019 10:12:35 +0530
Received: by c-sanm-linux.qualcomm.com (Postfix, from userid 2343233)
        id 6AAFF19B7; Thu,  5 Dec 2019 10:12:34 +0530 (IST)
From:   Sandeep Maheswaram <sanm@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
Subject: [PATCH v2 0/3] Add QUSB2 PHY support for SC7180
Date:   Thu,  5 Dec 2019 10:11:18 +0530
Message-Id: <1575520881-31458-1-git-send-email-sanm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added QUSB2 PHY support for SC7180.
Converting dt binding to yaml.
Adding compatible for SC7180 in dt bindings.

Changes in v2:
Sorted the compatible in driver.
Converted dt binding to yaml.
Added compatible in yaml.


Sandeep Maheswaram (3):
  phy: qcom-qusb2: Add QUSB2 PHY support for SC7180
  dt-bindings: phy: qcom-qusb2: Convert QUSB2 phy bindings to yaml
  dt-bindings: phy: qcom-qusb2: Add SC7180 QUSB2 phy support

 .../devicetree/bindings/phy/qcom-qusb2-phy.txt     |  68 -----------
 .../devicetree/bindings/phy/qcom-qusb2-phy.yaml    | 130 +++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qusb2.c              |  57 ++++++++-
 3 files changed, 186 insertions(+), 69 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/qcom-qusb2-phy.yaml

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

