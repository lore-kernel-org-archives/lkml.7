Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED599CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AB42086D
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ckF0tQsv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbfJUTtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 15:49:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44570 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730192AbfJUTtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 15:49:50 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9LJnDtS008602
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 12:49:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=jWT5CrWJkxGUb7ij8uZJ7HivALz8abhbTyR6lISUR8E=;
 b=ckF0tQsv6NQadBD+cCGD/EtAcF4mPP73P/DOt5ORagmY0/8VtP7LdNoILbT6rmudmIpS
 RbRJai0AnRDda6h+4w/+S8P9Hin0Tq7B8T7ZYHIwKwqx1DePfaeIqXszbEhm6Z8DiGzl
 7A0bZMzUqB14dLEpJlpxp1i/gLT4eiW2ucc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vshwr8bpw-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 12:49:48 -0700
Received: from 2401:db00:2120:80e1:face:0:29:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 21 Oct 2019 12:49:20 -0700
Received: by devvm1794.vll1.facebook.com (Postfix, from userid 150176)
        id 0A3E164C3CBA; Mon, 21 Oct 2019 12:49:20 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Tao Ren <taoren@fb.com>
Smtp-Origin-Hostname: devvm1794.vll1.facebook.com
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>
CC:     Tao Ren <taoren@fb.com>
Smtp-Origin-Cluster: vll1c12
Subject: [PATCH 4/4] ARM: dts: aspeed: yamp: include dtsi for common network BMC devices
Date:   Mon, 21 Oct 2019 12:48:20 -0700
Message-ID: <20191021194820.293556-5-taoren@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021194820.293556-1-taoren@fb.com>
References: <20191021194820.293556-1-taoren@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-21_05:2019-10-21,2019-10-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910210190
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch simplifies Yamp device tree by including dtsi to define
devices which are common to Facebook AST2500 Network BMC platforms.

Below is the summary of changes comparing with previous dts version:
  - enabling the second firmware flash.
  - enabling the emmc device in slot #1.

Signed-off-by: Tao Ren <taoren@fb.com>
---
 .../arm/boot/dts/aspeed-bmc-facebook-yamp.dts | 62 ++-----------------
 1 file changed, 5 insertions(+), 57 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts
index 4e09a9cf32b7..b184fa1abb60 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts
@@ -2,7 +2,7 @@
 // Copyright (c) 2018 Facebook Inc.
 /dts-v1/;
 
-#include "aspeed-g5.dtsi"
+#include "facebook-netbmc-ast2500-common.dtsi"
 
 / {
 	model = "Facebook YAMP 100 BMC";
@@ -23,47 +23,6 @@
 		stdout-path = &uart5;
 		bootargs = "console=ttyS0,9600n8 root=/dev/ram rw";
 	};
-
-	memory@80000000 {
-		reg = <0x80000000 0x20000000>;
-	};
-};
-
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
-/*
- * Update reset type to "system" (full chip) to fix warm reboot hang issue
- * when reset type is set to default ("soc", gated by reset mask registers).
- */
-&wdt1 {
-	status = "okay";
-	aspeed,reset-type = "system";
-};
-
-/*
- * wdt2 is not used by Yamp.
- */
-&wdt2 {
-	status = "disabled";
-};
-
-&fmc {
-	status = "okay";
-	flash@0 {
-		status = "okay";
-		m25p,fast-read;
-		label = "bmc";
-#include "facebook-bmc-flash-layout.dtsi"
-	};
-};
-
-&uart1 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_txd1_default
-		     &pinctrl_rxd1_default>;
 };
 
 &uart2 {
@@ -73,17 +32,6 @@
 		     &pinctrl_rxd2_default>;
 };
 
-&uart3 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_txd3_default
-		     &pinctrl_rxd3_default>;
-};
-
-&uart5 {
-	status = "okay";
-};
-
 &mac0 {
 	status = "okay";
 	use-ncsi;
@@ -92,6 +40,10 @@
 	pinctrl-0 = <&pinctrl_rmii1_default>;
 };
 
+&mac1 {
+	status = "disabled";
+};
+
 &i2c0 {
 	status = "okay";
 };
@@ -154,7 +106,3 @@
 &i2c13 {
 	status = "okay";
 };
-
-&vhub {
-	status = "okay";
-};
-- 
2.17.1

