Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52D4C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB453218CA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="VnsqGIJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbfGELyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 07:54:22 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:28664 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728186AbfGELyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 07:54:22 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x65Bp2ve022719;
        Fri, 5 Jul 2019 13:53:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=eSNOE8LcuBwBrzx3QG6juaa+hRCbqowv2ukbBye9kmw=;
 b=VnsqGIJmzTsOl5wvhOacnXOauRz+BhRB8crrhe1L/E6dtLpca8LVKMKvmhCBfuF7Wcuw
 CBzJVyYxGLRJD8Pk05vm+b4eOiYykwKBx0FRVpPkqIj5EE+1/vgRSyZSIzO5ChzpPZYM
 HXEFFyiyaBxHyzQDvCrlc7U0GDKArv9G3fMroiIdeZYNOX3E1/6HWOJABcsceo+lLr1s
 kLJ6fL1E1xIHG7NEyEFmf8Ibf/vuO+M8w9c1FkW3bxPVAiwNRy0+iVccB4VimoZFzhE+
 gxooDv1x/Vs85HcFXXayvY2lJYoVdsxtgQBGxUVdZVADeiaYxycENDWWYryLSrGmk814 ZQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2tgx0qx0pu-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 05 Jul 2019 13:53:05 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 35B3E3A;
        Fri,  5 Jul 2019 11:53:04 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DCF0B2BC8;
        Fri,  5 Jul 2019 11:53:03 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 5 Jul 2019
 13:53:04 +0200
Received: from localhost (10.201.23.16) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 5 Jul 2019 13:53:03
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <linux-stm32@st-md-mailman.stormreply.com>,
        <alexandre.torgue@st.com>, <robh@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>
Subject: [PATCH] ARM: dts: stm32: add audio codec support on stm32mp157a-dk1 board
Date:   Fri, 5 Jul 2019 13:53:00 +0200
Message-ID: <1562327580-19647-1-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-05_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support of Cirrus cs42l51 audio codec on stm32mp157a-dk1 board.
Configuration overview:
- SAI2A is the CPU interface used for the codec audio playback
- SAI2B is the CPU interface used for the codec audio record
- SAI2A is configured as a clock provider for the audio codec
- SAI2A&B are configured as slave of the audio codec
- SAI2A&B share the same interface of the audio codec

Note:
In master mode, cs42l51 audio codec provides a bitclock
at 64 x FS, regardless of data width. This means that
slot width is always 32 bits.
Set slot width to 32 bits and slot number to 2
in SAI2A&B endpoint nodes, to match this constraint.
dai-tdm-slot-num and dai-tdm-slot-width properties are used here,
assuming that i2s is a special case of tdm, where slot number is 2.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 arch/arm/boot/dts/stm32mp157a-dk1.dts | 89 +++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157a-dk1.dts b/arch/arm/boot/dts/stm32mp157a-dk1.dts
index f3f0e37aad4d..0f5b3c77153d 100644
--- a/arch/arm/boot/dts/stm32mp157a-dk1.dts
+++ b/arch/arm/boot/dts/stm32mp157a-dk1.dts
@@ -48,6 +48,17 @@
 			default-state = "off";
 		};
 	};
+
+	sound {
+		compatible = "audio-graph-card";
+		label = "STM32MP1-DK";
+		routing =
+			"Playback" , "MCLK",
+			"Capture" , "MCLK",
+			"MICL" , "Mic Bias";
+		dais = <&sai2a_port &sai2b_port>;
+		status = "okay";
+	};
 };
 
 &cec {
@@ -116,6 +127,39 @@
 			};
 		};
 	};
+
+	cs42l51: cs42l51@4a {
+		compatible = "cirrus,cs42l51";
+		reg = <0x4a>;
+		#sound-dai-cells = <0>;
+		VL-supply = <&v3v3>;
+		VD-supply = <&v1v8_audio>;
+		VA-supply = <&v1v8_audio>;
+		VAHP-supply = <&v1v8_audio>;
+		reset-gpios = <&gpiog 9 GPIO_ACTIVE_LOW>;
+		clocks = <&sai2a>;
+		clock-names = "MCLK";
+		status = "okay";
+
+		cs42l51_port: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cs42l51_tx_endpoint: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&sai2a_endpoint>;
+				frame-master;
+				bitclock-master;
+			};
+
+			cs42l51_rx_endpoint: endpoint@1 {
+				reg = <1>;
+				remote-endpoint = <&sai2b_endpoint>;
+				frame-master;
+				bitclock-master;
+			};
+		};
+	};
 };
 
 &i2c4 {
@@ -297,6 +341,51 @@
 	status = "okay";
 };
 
+&sai2 {
+	clocks = <&rcc SAI2>, <&rcc PLL3_Q>, <&rcc PLL3_R>;
+	clock-names = "pclk", "x8k", "x11k";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sai2a_pins_a>, <&sai2b_pins_b>;
+	pinctrl-1 = <&sai2a_sleep_pins_a>, <&sai2b_sleep_pins_b>;
+	status = "okay";
+
+	sai2a: audio-controller@4400b004 {
+		#clock-cells = <0>;
+		dma-names = "tx";
+		clocks = <&rcc SAI2_K>;
+		clock-names = "sai_ck";
+		status = "okay";
+
+		sai2a_port: port {
+			sai2a_endpoint: endpoint {
+				remote-endpoint = <&cs42l51_tx_endpoint>;
+				format = "i2s";
+				mclk-fs = <256>;
+				dai-tdm-slot-num = <2>;
+				dai-tdm-slot-width = <32>;
+			};
+		};
+	};
+
+	sai2b: audio-controller@4400b024 {
+		dma-names = "rx";
+		st,sync = <&sai2a 2>;
+		clocks = <&rcc SAI2_K>, <&sai2a>;
+		clock-names = "sai_ck", "MCLK";
+		status = "okay";
+
+		sai2b_port: port {
+			sai2b_endpoint: endpoint {
+				remote-endpoint = <&cs42l51_rx_endpoint>;
+				format = "i2s";
+				mclk-fs = <256>;
+				dai-tdm-slot-num = <2>;
+				dai-tdm-slot-width = <32>;
+			};
+		};
+	};
+};
+
 &sdmmc1 {
 	pinctrl-names = "default", "opendrain", "sleep";
 	pinctrl-0 = <&sdmmc1_b4_pins_a>;
-- 
2.7.4

