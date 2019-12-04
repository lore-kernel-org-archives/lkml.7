Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F93C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C385D207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ckQmYgBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfLDPYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:24:53 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:21076 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727828AbfLDPYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:24:53 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB4FM64a026212;
        Wed, 4 Dec 2019 16:24:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=GJUZvh1kGK/ZWmYptY9ufLGZpRTGP8Bz+9TxwpoDvDg=;
 b=ckQmYgBS0CcNVg/V3qNup+iCos72Iz/fhARwZEWGN42JALvh+t9auQwfZqBdUS8oiebf
 qmsUTSerFZatjyL/XTZORNO21l18xCrDJK+8tp5tERLluKY2qnG9j2V2++CUviG2flHG
 Y/stXHFH8bZONU27yh3qeofvuxA+zB/Ap+hxmAoGcg6SG8pPCyjpEqrChDcGtpaIDnhc
 jM26PZTBSQm0e1syvbmhPrsN3NY3X8UNt23pGQJd2eEoyu/JQm+NH0YEcBzoibc0tzln
 rronJSsDPcoRvpvfqI8mG49p/YvDLp/AZlUE4oKWj8JgUkA4b7qrxKfWtIrBnWM50D9f hA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wkeea64c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 16:24:42 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8C85B10002A;
        Wed,  4 Dec 2019 16:24:40 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7E0252C1AD8;
        Wed,  4 Dec 2019 16:24:40 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.44) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 4 Dec
 2019 16:24:39 +0100
Subject: Re: [PATCH] ARM: dts: stm32: remove "@" from stm32f4 pinmux groups
To:     Benjamin Gaignard <benjamin.gaignard@st.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20191125121244.19591-1-benjamin.gaignard@st.com>
 <20191125121244.19591-2-benjamin.gaignard@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <ebba0ecf-2e18-83f7-3cbb-0ba6f98169b1@st.com>
Date:   Wed, 4 Dec 2019 16:24:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191125121244.19591-2-benjamin.gaignard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_03:2019-12-04,2019-12-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi benjamin

On 11/25/19 1:12 PM, Benjamin Gaignard wrote:
> Replace all "@" by "_" in pinmux groups for stm32f4 family.
> This avoid errors when using yaml to check the bindings.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>   arch/arm/boot/dts/stm32f4-pinctrl.dtsi | 28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
> index 35202896c093..722598cdf3b7 100644
> --- a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
> @@ -163,7 +163,7 @@
>   				st,bank-name = "GPIOK";
>   			};
>   
> -			usart1_pins_a: usart1@0 {
> +			usart1_pins_a: usart1_0 {

You fix a warning by adding a new one. Please use "usart1-0" instead of 
"usart1_0". To be done for all changes in this file.

regards
Alex


>   				pins1 {
>   					pinmux = <STM32_PINMUX('A', 9, AF7)>; /* USART1_TX */
>   					bias-disable;
> @@ -176,7 +176,7 @@
>   				};
>   			};
>   
> -			usart3_pins_a: usart3@0 {
> +			usart3_pins_a: usart3_0 {
>   				pins1 {
>   					pinmux = <STM32_PINMUX('B', 10, AF7)>; /* USART3_TX */
>   					bias-disable;
> @@ -189,7 +189,7 @@
>   				};
>   			};
>   
> -			usbotg_fs_pins_a: usbotg_fs@0 {
> +			usbotg_fs_pins_a: usbotg_fs_0 {
>   				pins {
>   					pinmux = <STM32_PINMUX('A', 10, AF10)>, /* OTG_FS_ID */
>   						 <STM32_PINMUX('A', 11, AF10)>, /* OTG_FS_DM */
> @@ -200,7 +200,7 @@
>   				};
>   			};
>   
> -			usbotg_fs_pins_b: usbotg_fs@1 {
> +			usbotg_fs_pins_b: usbotg_fs_1 {
>   				pins {
>   					pinmux = <STM32_PINMUX('B', 12, AF12)>, /* OTG_HS_ID */
>   						 <STM32_PINMUX('B', 14, AF12)>, /* OTG_HS_DM */
> @@ -211,7 +211,7 @@
>   				};
>   			};
>   
> -			usbotg_hs_pins_a: usbotg_hs@0 {
> +			usbotg_hs_pins_a: usbotg_hs_0 {
>   				pins {
>   					pinmux = <STM32_PINMUX('H', 4, AF10)>, /* OTG_HS_ULPI_NXT*/
>   						 <STM32_PINMUX('I', 11, AF10)>, /* OTG_HS_ULPI_DIR */
> @@ -231,7 +231,7 @@
>   				};
>   			};
>   
> -			ethernet_mii: mii@0 {
> +			ethernet_mii: mii_0 {
>   				pins {
>   					pinmux = <STM32_PINMUX('G', 13, AF11)>, /* ETH_MII_TXD0_ETH_RMII_TXD0 */
>   						 <STM32_PINMUX('G', 14, AF11)>, /* ETH_MII_TXD1_ETH_RMII_TXD1 */
> @@ -251,13 +251,13 @@
>   				};
>   			};
>   
> -			adc3_in8_pin: adc@200 {
> +			adc3_in8_pin: adc_200 {
>   				pins {
>   					pinmux = <STM32_PINMUX('F', 10, ANALOG)>;
>   				};
>   			};
>   
> -			pwm1_pins: pwm@1 {
> +			pwm1_pins: pwm_1 {
>   				pins {
>   					pinmux = <STM32_PINMUX('A', 8, AF1)>, /* TIM1_CH1 */
>   						 <STM32_PINMUX('B', 13, AF1)>, /* TIM1_CH1N */
> @@ -265,14 +265,14 @@
>   				};
>   			};
>   
> -			pwm3_pins: pwm@3 {
> +			pwm3_pins: pwm_3 {
>   				pins {
>   					pinmux = <STM32_PINMUX('B', 4, AF2)>, /* TIM3_CH1 */
>   						 <STM32_PINMUX('B', 5, AF2)>; /* TIM3_CH2 */
>   				};
>   			};
>   
> -			i2c1_pins: i2c1@0 {
> +			i2c1_pins: i2c1_0 {
>   				pins {
>   					pinmux = <STM32_PINMUX('B', 9, AF4)>, /* I2C1_SDA */
>   						 <STM32_PINMUX('B', 6, AF4)>; /* I2C1_SCL */
> @@ -282,7 +282,7 @@
>   				};
>   			};
>   
> -			ltdc_pins: ltdc@0 {
> +			ltdc_pins: ltdc_0 {
>   				pins {
>   					pinmux = <STM32_PINMUX('I', 12, AF14)>, /* LCD_HSYNC */
>   						 <STM32_PINMUX('I', 13, AF14)>, /* LCD_VSYNC */
> @@ -316,7 +316,7 @@
>   				};
>   			};
>   
> -			dcmi_pins: dcmi@0 {
> +			dcmi_pins: dcmi_0 {
>   				pins {
>   					pinmux = <STM32_PINMUX('A', 4, AF13)>, /* DCMI_HSYNC */
>   						 <STM32_PINMUX('B', 7, AF13)>, /* DCMI_VSYNC */
> @@ -339,7 +339,7 @@
>   				};
>   			};
>   
> -			sdio_pins: sdio_pins@0 {
> +			sdio_pins: sdio_pins_0 {
>   				pins {
>   					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDIO_D0 */
>   						 <STM32_PINMUX('C', 9, AF12)>, /* SDIO_D1 */
> @@ -352,7 +352,7 @@
>   				};
>   			};
>   
> -			sdio_pins_od: sdio_pins_od@0 {
> +			sdio_pins_od: sdio_pins_od_0 {
>   				pins1 {
>   					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDIO_D0 */
>   						 <STM32_PINMUX('C', 9, AF12)>, /* SDIO_D1 */
> 
