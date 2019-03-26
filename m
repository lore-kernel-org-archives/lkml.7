Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6710AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4054521741
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbfCZGdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:33:03 -0400
Received: from mx.socionext.com ([202.248.49.38]:11569 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730755AbfCZGdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:33:01 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 26 Mar 2019 15:32:59 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 5806D180BD4;
        Tue, 26 Mar 2019 15:32:59 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 26 Mar 2019 15:32:59 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 0404D1A15B7;
        Tue, 26 Mar 2019 15:32:59 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id DB677120487;
        Tue, 26 Mar 2019 15:32:58 +0900 (JST)
From:   Shinji Kanematsu <kanematsu.shinji@socionext.com>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, masami.hiramatsu@linaro.org,
        jaswinder.singh@linaro.org, orito.takao@socionext.com,
        sugaya.taichi@socionext.com, kasai.kazuhiro@socionext.com,
        kanematsu.shinji@socionext.com
Subject: [PATCH 1/2] dt-bindings: iio: counter: Add Milbeaut Updown Counter
Date:   Tue, 26 Mar 2019 15:33:09 +0900
Message-Id: <1553581989-13525-1-git-send-email-kanematsu.shinji@socionext.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for Milbeaut Updown Counter device
quadrature encoder and counter binding.

Signed-off-by: Shinji Kanematsu <kanematsu.shinji@socionext.com>
---
 .../bindings/iio/counter/milbeaut-updown_cnt.txt   | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/counter/milbeaut-updown_cnt.txt

diff --git a/Documentation/devicetree/bindings/iio/counter/milbeaut-updown_cnt.txt b/Documentation/devicetree/bindings/iio/counter/milbeaut-updown_cnt.txt
new file mode 100644
index 0000000..6771567
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/counter/milbeaut-updown_cnt.txt
@@ -0,0 +1,22 @@
+SOCIONEXT Milbeaut Updown counter
+
+Required properties:
+- compatible:       Must be "socionext,milbeaut-updown-counter".
+- reg:              Offset and length of the device's register set.
+- clocks:           Phandle to the clock used by the Updown counter module.
+- clock-names:      Must be "mux".
+- interrupts:       SPI number of the device's set.
+- cms_type:         connected_device
+                     1: updown button  (updown counter mode)
+                     2: rotary encoder (phase difference counter mode)
+
+Example:
+
+	updown0: updown@1e002000 {
+		compatible = "socionext,milbeaut-updown-counter";
+		reg = <0x1e002000 0x20>;
+		clocks = <&clk 4>;
+		clock-names = "mux";
+		interrupts = <0 104 0x4>;
+		cms_type = <1>;
+	};
-- 
1.9.1

