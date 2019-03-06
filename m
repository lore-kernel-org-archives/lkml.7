Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646BDC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6CE20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfCFPMN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:12:13 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:11617 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727760AbfCFPMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 10:12:13 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x26F8arC023739;
        Wed, 6 Mar 2019 16:11:53 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qygfxrqtq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 06 Mar 2019 16:11:53 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 36A1D3D;
        Wed,  6 Mar 2019 15:11:52 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 00E324E52;
        Wed,  6 Mar 2019 15:11:51 +0000 (GMT)
Received: from SFHDAG3NODE1.st.com (10.75.127.7) by SFHDAG5NODE2.st.com
 (10.75.127.14) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 6 Mar
 2019 16:11:51 +0100
Received: from SFHDAG3NODE1.st.com ([fe80::1166:1abb:aad4:5f86]) by
 SFHDAG3NODE1.st.com ([fe80::1166:1abb:aad4:5f86%20]) with mapi id
 15.00.1347.000; Wed, 6 Mar 2019 16:11:51 +0100
From:   Bich HEMON <bich.hemon@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Pierre Yves MORDRET <pierre-yves.mordret@st.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bich HEMON <bich.hemon@st.com>
Subject: [PATCH 2/2] dt-bindings: i2c-stm32: update optional properties for
 stm32h7/stm32mp1
Thread-Topic: [PATCH 2/2] dt-bindings: i2c-stm32: update optional properties
 for stm32h7/stm32mp1
Thread-Index: AQHU1C7td8a/ZnsI70O8L4kXA+AJGg==
Date:   Wed, 6 Mar 2019 15:11:51 +0000
Message-ID: <1551885100-22207-3-git-send-email-bich.hemon@st.com>
References: <1551885100-22207-1-git-send-email-bich.hemon@st.com>
In-Reply-To: <1551885100-22207-1-git-send-email-bich.hemon@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-06_10:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add STM32H7 and STM32MP1 in the list of compatible socs for each
optional property.

Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 Documentation/devicetree/bindings/i2c/i2c-stm32.txt | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-stm32.txt b/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
index 7d054f1..f334738 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
@@ -19,18 +19,19 @@ Optional properties:
   the default 100 kHz frequency will be used.
   For STM32F4 SoC Standard-mode and Fast-mode are supported, possible values are
   100000 and 400000.
-  For STM32F7 SoC, Standard-mode, Fast-mode and Fast-mode Plus are supported,
-  possible values are 100000, 400000 and 1000000.
-- i2c-scl-rising-time-ns: Only for STM32F7, I2C SCL Rising time for the board
-  (default: 25)
-- i2c-scl-falling-time-ns: Only for STM32F7, I2C SCL Falling time for the board
-  (default: 10)
+  For STM32F7, STM32H7 and STM32MP1 SoCs, Standard-mode, Fast-mode and Fast-mode
+  Plus are supported, possible values are 100000, 400000 and 1000000.
+- i2c-scl-rising-time-ns: I2C SCL Rising time for the board (default: 25)
+  For STM32F7, STM32H7 and STM32MP1 only.
+- i2c-scl-falling-time-ns: I2C SCL Falling time for the board (default: 10)
+  For STM32F7, STM32H7 and STM32MP1 only.
   I2C Timings are derived from these 2 values
-- st,syscfg-fmp: Only for STM32F7, use to set Fast Mode Plus bit within SYSCFG
-  whether Fast Mode Plus speed is selected by slave.
+- st,syscfg-fmp: Use to set Fast Mode Plus bit within SYSCFG when Fast Mode
+  Plus speed is selected by slave.
 	1st cell: phandle to syscfg
 	2nd cell: register offset within SYSCFG
 	3rd cell: register bitmask for FMP bit
+  For STM32F7, STM32H7 and STM32MP1 only.
 
 Example:
 
-- 
1.9.1
