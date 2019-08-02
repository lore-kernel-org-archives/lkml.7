Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDF5C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 04:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94FB2086A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 04:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="onz3slll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbfHBEHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 00:07:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55078 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725787AbfHBEHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 00:07:01 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x7246nSN008250
        for <linux-kernel@vger.kernel.org>; Thu, 1 Aug 2019 21:06:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=/JGpj5xaIqABlRNKSRJRUdgMyRc4OpMWr0QtO1VevWQ=;
 b=onz3slllYo8MESWYShIb/EGwAuE4C4aWnH+fyHBGBapjltSy7YoxSa8z5rf6gRRJE3JW
 SkKrUxBXtMO/JQ50ispRMGhUgS/sjQ42mYx05jsGGcFtmX3sFKhBK0WvduuJCJMnTP9z
 EPLNGLe0EsPG9E0S+ZJ1zI/rzrl2xMRn0Ic= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2u449ghw4y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 21:06:56 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 1 Aug 2019 21:06:54 -0700
Received: by devvm24792.prn1.facebook.com (Postfix, from userid 150176)
        id E273C1888669A; Thu,  1 Aug 2019 21:06:52 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Tao Ren <taoren@fb.com>
Smtp-Origin-Hostname: devvm24792.prn1.facebook.com
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>
CC:     Tao Ren <taoren@fb.com>
Smtp-Origin-Cluster: prn1c35
Subject: [PATCH v2] ARM: dts: aspeed: Add Facebook Wedge40 BMC
Date:   Thu, 1 Aug 2019 21:06:50 -0700
Message-ID: <20190802040650.1224903-1-taoren@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020042
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial version of device tree for Facebook Wedge40 AST2400 BMC
platform.

Signed-off-by: Tao Ren <taoren@fb.com>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 Changes in v2:
 - remove "debug" from bootargs.

 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/aspeed-bmc-facebook-wedge40.dts  | 141 ++++++++++++++++++
 2 files changed, 142 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 39a05a10a2a2..dfc1011eb3f2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1273,6 +1273,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-cmm.dtb \
 	aspeed-bmc-facebook-minipack.dtb \
 	aspeed-bmc-facebook-tiogapass.dtb \
+	aspeed-bmc-facebook-wedge40.dtb \
 	aspeed-bmc-facebook-yamp.dtb \
 	aspeed-bmc-intel-s2600wf.dtb \
 	aspeed-bmc-inspur-fp5280g2.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
new file mode 100644
index 000000000000..aaa77a597d1a
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2018 Facebook Inc.
+/dts-v1/;
+
+#include "aspeed-g4.dtsi"
+
+/ {
+	model = "Facebook Wedge 40 BMC";
+	compatible = "facebook,wedge40-bmc", "aspeed,ast2400";
+
+	aliases {
+		/*
+		 * Override the default uart aliases to avoid breaking
+		 * the legacy applications.
+		 */
+		serial0 = &uart5;
+		serial1 = &uart1;
+		serial2 = &uart3;
+		serial3 = &uart4;
+	};
+
+	chosen {
+		stdout-path = &uart3;
+		bootargs = "console=ttyS2,9600n8 root=/dev/ram rw";
+	};
+
+	memory@40000000 {
+		reg = <0x40000000 0x20000000>;
+	};
+};
+
+&wdt1 {
+	status = "okay";
+	aspeed,reset-type = "system";
+};
+
+&wdt2 {
+	status = "disabled";
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "fmc0";
+#include "facebook-bmc-flash-layout.dtsi"
+	};
+};
+
+&uart1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd1_default
+		     &pinctrl_rxd1_default>;
+};
+
+&uart3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd3_default
+		     &pinctrl_rxd3_default>;
+};
+
+&uart4 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd4_default
+		     &pinctrl_rxd4_default>;
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&mac1 {
+	status = "okay";
+	no-hw-checksum;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+};
+
+&i2c7 {
+	status = "okay";
+};
+
+&i2c8 {
+	status = "okay";
+};
+
+&i2c9 {
+	status = "okay";
+};
+
+&i2c10 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+};
+
+&i2c12 {
+	status = "okay";
+};
+
+&i2c13 {
+	status = "okay";
+};
+
+&vhub {
+	status = "okay";
+};
-- 
2.17.1

