Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D48C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3143D2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="UAlxy9vN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbfDJKCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:02:53 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:39576 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729200AbfDJKCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:02:46 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3A9pE2p021997;
        Wed, 10 Apr 2019 12:02:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=khjS2R2nmPFjF18UlwbWNS8oKt8MGfK2JdwVwOgpfX8=;
 b=UAlxy9vNnu4px7u4+DdmQ9tELqr/SY4KR9EZQ4xVEbAope0DKItbTFJeMt5c8npDCQpO
 EqNq/dtOFVDBoYgDPTcIyISSY95wjldWvcCOdLvjIcCCsZsNOf2a5gkDewyn+hFnIzAS
 YMwGaMY8F7V3qr3vcnga1eyVMdmDpDKqJ9ibzHWePju80BTYwvgWtJltVZ66obta3nYr
 iWXJ8RAMEJh+GTKaACPVUcIZLSaA7dBVAmaKIeNI878QeKRIDWSsRspFCeXV+8u1ylLY
 BD/TYclH6mxn0p4IGjSjipTpQ+4OAfEYyCIk/TCFfGXgTJ3jC1s01LPdmNhW/MNmxsD1 GQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rprcp64t6-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 10 Apr 2019 12:02:33 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7F06738;
        Wed, 10 Apr 2019 10:02:32 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 63D6E1393;
        Wed, 10 Apr 2019 10:02:32 +0000 (GMT)
Received: from localhost (10.75.127.44) by SFHDAG5NODE2.st.com (10.75.127.14)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 10 Apr 2019 12:02:31
 +0200
From:   Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v2 2/3] ARM: dts: stm32: enable Vivante GPU support on stm32mp157c-ed1 board
Date:   Wed, 10 Apr 2019 12:02:27 +0200
Message-ID: <1554890548-24448-3-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554890548-24448-1-git-send-email-pierre-yves.mordret@st.com>
References: <1554890548-24448-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Vivante GPU driver for stm32mp157c-ed1 board.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v2:
       * move GPU reserved memeory out of bottom DDR to let free this area for
         U-Boot
    v1:
       * Initial
---
---
 arch/arm/boot/dts/stm32mp157c-ed1.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index 9fd7943..7bcc122 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -22,6 +22,17 @@
 		reg = <0xC0000000 0x40000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		gpu_reserved: gpu@e8000000 {
+			reg = <0xe8000000 0x8000000>;
+			no-map;
+		};
+	};
+
 	aliases {
 		serial0 = &uart4;
 	};
@@ -76,6 +87,11 @@
 	status = "okay";
 };
 
+&gpu {
+	contiguous-area = <&gpu_reserved>;
+	status = "okay";
+};
+
 &i2c4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c4_pins_a>;
-- 
2.7.4

