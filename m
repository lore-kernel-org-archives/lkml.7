Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66964C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D8D207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="vtGNWWKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfLDPX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:23:27 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:20620 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727828AbfLDPX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:23:27 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB4FM5wl026203;
        Wed, 4 Dec 2019 16:23:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=8BM+BgH6USRwz0DXxL6nJffx2+O6Ux7FvCH6ofepeP4=;
 b=vtGNWWKDWVVqMkFqQY9rewo2iWybFK9AfvQ/W/Xm69QL0FsoyROikRZES5lgkuvUgKb2
 CvhGu/DNWjvwjB7C9TmuRnkyVQhh0w7kEaNAl1ay3xQSCMI0TxRNpso8xOSqtmbZ6P2U
 YbpD+aE7jLDpCEwhx50GMAAh/t3Mje0ShPBmY6gpA09oUCBCd5caUHGu32Faj3LwuL+4
 jdNTSEiNtNtUIfXuJ8uC7CrzRU2n9TSPz3M+tdswwAaVYk0FKDpouSe3u/Ya9sAsqKCZ
 naOCPPea+wqmLcVe2o6xQcfTXy47FIOGl1rq8xF9MFmZ2C3QpPxUs3c50+9MZv+ImJo2 Yg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wkeea645g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 16:23:17 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BF840100034;
        Wed,  4 Dec 2019 16:23:16 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ABE802C1AC8;
        Wed,  4 Dec 2019 16:23:16 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.45) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 4 Dec
 2019 16:23:15 +0100
Subject: Re: [PATCH] ARM: dts: stm32: remove "@" from stm32f7 pinmux groups
To:     Benjamin Gaignard <benjamin.gaignard@st.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20191125121244.19591-1-benjamin.gaignard@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <f277b73f-716c-0746-73b8-45a8096d0bff@st.com>
Date:   Wed, 4 Dec 2019 16:23:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191125121244.19591-1-benjamin.gaignard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_03:2019-12-04,2019-12-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin

On 11/25/19 1:12 PM, Benjamin Gaignard wrote:
> Replace all "@" by "_" in pinmux groups for stm32f7 family.
> This avoid errors when using yaml to check the bindings.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>   arch/arm/boot/dts/stm32f7-pinctrl.dtsi | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32f7-pinctrl.dtsi b/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
> index 9314128df185..5271df1017cb 100644
> --- a/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
> @@ -127,7 +127,7 @@
>   				st,bank-name = "GPIOK";
>   			};
>   
> -			cec_pins_a: cec@0 {
> +			cec_pins_a: cec_0 {

You fix a warning by adding a new one. Please use "cec-0" instead of 
"cec_0". To be done for all changes in this file.

regards
Alex


>   				pins {
>   					pinmux = <STM32_PINMUX('A', 15, AF4)>; /* HDMI CEC */
>   					slew-rate = <0>;
> @@ -136,7 +136,7 @@
>   				};
>   			};
>   
> -			usart1_pins_a: usart1@0 {
> +			usart1_pins_a: usart1_0 {
>   				pins1 {
>   					pinmux = <STM32_PINMUX('A', 9, AF7)>; /* USART1_TX */
>   					bias-disable;
> @@ -149,7 +149,7 @@
>   				};
>   			};
>   
> -			usart1_pins_b: usart1@1 {
> +			usart1_pins_b: usart1_1 {
>   				pins1 {
>   					pinmux = <STM32_PINMUX('A', 9, AF7)>; /* USART1_TX */
>   					bias-disable;
> @@ -162,7 +162,7 @@
>   				};
>   			};
>   
> -			i2c1_pins_b: i2c1@0 {
> +			i2c1_pins_b: i2c1_0 {
>   				pins {
>   					pinmux = <STM32_PINMUX('B', 9, AF4)>, /* I2C1 SDA */
>   						 <STM32_PINMUX('B', 8, AF4)>; /* I2C1 SCL */
> @@ -172,7 +172,7 @@
>   				};
>   			};
>   
> -			usbotg_hs_pins_a: usbotg-hs@0 {
> +			usbotg_hs_pins_a: usbotg-hs_0 {
>   				pins {
>   					pinmux = <STM32_PINMUX('H', 4, AF10)>, /* OTG_HS_ULPI_NXT */
>   						 <STM32_PINMUX('I', 11, AF10)>, /* OTG_HS_ULPI_DIR */
> @@ -192,7 +192,7 @@
>   				};
>   			};
>   
> -			usbotg_hs_pins_b: usbotg-hs@1 {
> +			usbotg_hs_pins_b: usbotg-hs_1 {
>   				pins {
>   					pinmux = <STM32_PINMUX('H', 4, AF10)>, /* OTG_HS_ULPI_NXT */
>   						 <STM32_PINMUX('C', 2, AF10)>, /* OTG_HS_ULPI_DIR */
> @@ -212,7 +212,7 @@
>   				};
>   			};
>   
> -			usbotg_fs_pins_a: usbotg-fs@0 {
> +			usbotg_fs_pins_a: usbotg-fs_0 {
>   				pins {
>   					pinmux = <STM32_PINMUX('A', 10, AF10)>, /* OTG_FS_ID */
>   						 <STM32_PINMUX('A', 11, AF10)>, /* OTG_FS_DM */
> @@ -223,7 +223,7 @@
>   				};
>   			};
>   
> -			sdio_pins_a: sdio_pins_a@0 {
> +			sdio_pins_a: sdio_pins_a_0 {
>   				pins {
>   					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1 D0 */
>   						 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1 D1 */
> @@ -236,7 +236,7 @@
>   				};
>   			};
>   
> -			sdio_pins_od_a: sdio_pins_od_a@0 {
> +			sdio_pins_od_a: sdio_pins_od_a_0 {
>   				pins1 {
>   					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1 D0 */
>   						 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1 D1 */
> @@ -254,7 +254,7 @@
>   				};
>   			};
>   
> -			sdio_pins_b: sdio_pins_b@0 {
> +			sdio_pins_b: sdio_pins_b_0 {
>   				pins {
>   					pinmux = <STM32_PINMUX('G', 9, AF11)>, /* SDMMC2 D0 */
>   						 <STM32_PINMUX('G', 10, AF11)>, /* SDMMC2 D1 */
> @@ -267,7 +267,7 @@
>   				};
>   			};
>   
> -			sdio_pins_od_b: sdio_pins_od_b@0 {
> +			sdio_pins_od_b: sdio_pins_od_b_0 {
>   				pins1 {
>   					pinmux = <STM32_PINMUX('G', 9, AF11)>, /* SDMMC2 D0 */
>   						 <STM32_PINMUX('G', 10, AF11)>, /* SDMMC2 D1 */
> 
