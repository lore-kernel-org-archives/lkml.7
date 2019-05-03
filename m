Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEC3C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 09:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D492075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 09:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="QctHJ7Yx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfECJBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 05:01:20 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11260 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725885AbfECJBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 05:01:20 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x438s4Bo024751;
        Fri, 3 May 2019 11:01:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=NJcBfDIXc6aq0TUQaHd3aj5WEWDAnTUBKckNqR/0Asc=;
 b=QctHJ7Yxj6KjskcUX1gU22VDKHjRXWpUI2QH8biFHaUN1tdXm0NCeKEv2iRTuisjgzzE
 JPy6ShpzSN2I/DSwqVfaj1QH7A3TOv0UijRJe5ykENgc7GZheX/ZmUJ7aP7jBtSu4eMm
 p8xT98pwukB9PtxINZbYYBjHMbNtGWpH5LP6Tk7aUbuIcCtyNQdgQjkjJsMujT/awbd6
 QJQImbii0ktPw9IANXiKUM8Iq6vZI7ZDFHui4LDax1mGzYR1zbMKze8aqx4eR70VLO+C
 RwlsNfmcrMfwnKKRa3dzQAKN+CY8YLVKWM4p0gI0OqJAp4uoGZQY3aUhhkgANDJ+rsP0 VA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2s6xhbnas9-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 03 May 2019 11:01:03 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6AAD638;
        Fri,  3 May 2019 09:01:02 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1C721159E;
        Fri,  3 May 2019 09:01:02 +0000 (GMT)
Received: from [10.48.0.204] (10.75.127.49) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 3 May
 2019 11:01:01 +0200
Subject: Re: [PATCH 3/3] ARM: dts: Add Avenger96 devicetree support based on
 STM32MP157A
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <mcoquelin.stm32@gmail.com>, <robh+dt@kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <loic.pallardy@st.com>
References: <20190503053123.6828-1-manivannan.sadhasivam@linaro.org>
 <20190503053123.6828-4-manivannan.sadhasivam@linaro.org>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <7e693155-d1d4-b12d-74fd-0236d9d52257@st.com>
Date:   Fri, 3 May 2019 11:01:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503053123.6828-4-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-03_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani

On 5/3/19 7:31 AM, Manivannan Sadhasivam wrote:
> Add devicetree support for Avenger96 board based on STM32MP157A MPU
> from ST Micro. This board is one of the 96Boards Consumer Edition board
> from Arrow Electronics and has the following features:
> 
> SoC: STM32MP157AAC
> PMIC: STPMIC1A
> RAM: 1024 Mbyte @ 533MHz
> Storage: eMMC v4.51: 8 Gbyte
>           microSD Socket: UHS-1 v3.01
> Ethernet Port: 10/100/1000 Mbit/s, IEEE 802.3 Compliant
> Wireless: WiFi 5 GHz & 2.4GHz IEEE 802.11a/b/g/n/ac
>            Bluetooth®v4.2 (BR/EDR/BLE)
> USB: 2x Type A (USB 2.0) Host and 1x Micro B (USB 2.0) OTG
> Display: HDMI: WXGA (1366x768)@ 60 fps, HDMI 1.4
> LED: 4x User LED, 1x WiFi LED, 1x BT LED
> 
> More information about this board can be found in 96Boards website:
> https://www.96boards.org/product/avenger96/
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   arch/arm/boot/dts/Makefile                  |   1 +
>   arch/arm/boot/dts/stm32mp157a-avenger96.dts | 320 ++++++++++++++++++++
>   2 files changed, 321 insertions(+)
>   create mode 100644 arch/arm/boot/dts/stm32mp157a-avenger96.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 8a1d0b3f55dd..f1d2f0bfa7c2 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -965,6 +965,7 @@ dtb-$(CONFIG_ARCH_STM32) += \
>   	stm32h743i-eval.dtb \
>   	stm32h743i-disco.dtb \
>   	stm32mp157a-dk1.dtb \
> +	stm32mp157a-avenger96.dtb \

follow alphabetic order please.

>   	stm32mp157c-dk2.dtb \
>   	stm32mp157c-ed1.dtb \
>   	stm32mp157c-ev1.dtb
> diff --git a/arch/arm/boot/dts/stm32mp157a-avenger96.dts b/arch/arm/boot/dts/stm32mp157a-avenger96.dts
> new file mode 100644
> index 000000000000..a3b8af82ac70
> --- /dev/null
> +++ b/arch/arm/boot/dts/stm32mp157a-avenger96.dts
> @@ -0,0 +1,320 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +/*
> + * Copyright (C) Linaro Ltd 2019 - All Rights Reserved
> + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> + */
> +
> +/dts-v1/;
> +
> +#include "stm32mp157c.dtsi"
> +#include "stm32mp157-pinctrl.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/mfd/st,stpmic1.h>
> +
> +/ {
> +	model = "Arrow Electronics STM32MP157A Avenger96 board";
> +	compatible = "arrow,stm32mp157a-avenger96", "st,stm32mp157";
> +
> +	aliases {
> +		ethernet0 = &ethernet0;
> +		mmc0 = &sdmmc1;
> +		serial0 = &uart4;
> +		serial1 = &uart7;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@c0000000 {
> +		reg = <0xc0000000 0x40000000>;

you could add device_type = "memory";

> +	};
> +
> +	led {
> +		compatible = "gpio-leds";
> +		led1 {
> +			label = "green:user1";
> +			gpios = <&gpioz 7 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +			default-state = "off";
> +		};
> +
> +		led2 {
> +			label = "green:user2";
> +			gpios = <&gpiof 3 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "mmc0";
> +			default-state = "off";
> +		};
> +
> +		led3 {
> +			label = "green:user3";
> +			gpios = <&gpiog 0 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "mmc1";
> +			default-state = "off";
> +		};
> +
> +		led4 {
> +			label = "green:user3";
> +			gpios = <&gpiog 1 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "none";
> +			default-state = "off";
> +			panic-indicator;
> +		};
> +
> +		led5 {
> +			label = "yellow:wifi";
> +			gpios = <&gpioz 3 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "phy0tx";
> +			default-state = "off";
> +		};
> +
> +		led6 {
> +			label = "blue:bt";
> +			gpios = <&gpioz 6 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "bluetooth-power";
> +			default-state = "off";
> +		};
> +	};
> +};
> +
> +&ethernet0 {
> +	status = "okay";
> +	pinctrl-0 = <&ethernet0_rgmii_pins_a>;
> +	pinctrl-1 = <&ethernet0_rgmii_pins_sleep_a>;
> +	pinctrl-names = "default", "sleep";
> +	phy-mode = "rgmii";
> +	max-speed = <1000>;
> +	phy-handle = <&phy0>;
> +
> +	mdio0 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "snps,dwmac-mdio";
> +		phy0: ethernet-phy@7 {
> +			reg = <7>;
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins_b>;
> +	i2c-scl-rising-time-ns = <185>;
> +	i2c-scl-falling-time-ns = <20>;
> +	status = "okay";
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pins_b>;
> +	i2c-scl-rising-time-ns = <185>;
> +	i2c-scl-falling-time-ns = <20>;
> +	status = "okay";
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +};
> +
> +&i2c4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c4_pins_a>;
> +	i2c-scl-rising-time-ns = <185>;
> +	i2c-scl-falling-time-ns = <20>;
> +	status = "okay";
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +
> +	pmic: stpmic@33 {
> +		compatible = "st,stpmic1";
> +		reg = <0x33>;
> +		interrupts-extended = <&exti 55 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		status = "okay";
> +
> +		st,main-control-register = <0x04>;
> +		st,vin-control-register = <0xc0>;
> +		st,usb-control-register = <0x30>;
> +
> +		regulators {
> +			compatible = "st,stpmic1-regulators";
> +
> +			ldo1-supply = <&v3v3>;
> +			ldo2-supply = <&v3v3>;
> +			ldo3-supply = <&vdd_ddr>;
> +			ldo5-supply = <&v3v3>;
> +			ldo6-supply = <&v3v3>;
> +			pwr_sw1-supply = <&bst_out>;
> +			pwr_sw2-supply = <&bst_out>;
> +
> +			vddcore: buck1 {
> +				regulator-name = "vddcore";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-always-on;
> +				regulator-initial-mode = <0>;
> +				regulator-over-current-protection;
> +			};
> +
> +			vdd_ddr: buck2 {
> +				regulator-name = "vdd_ddr";
> +				regulator-min-microvolt = <1350000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-always-on;
> +				regulator-initial-mode = <0>;
> +				regulator-over-current-protection;
> +			};
> +
> +			vdd: buck3 {
> +				regulator-name = "vdd";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				st,mask_reset;
> +				regulator-initial-mode = <0>;
> +				regulator-over-current-protection;
> +			};
> +
> +			v3v3: buck4 {
> +				regulator-name = "v3v3";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				regulator-over-current-protection;
> +				regulator-initial-mode = <0>;
> +			};
> +
> +			vdda: ldo1 {
> +				regulator-name = "vdda";
> +				regulator-min-microvolt = <2900000>;
> +				regulator-max-microvolt = <2900000>;
> +				interrupts = <IT_CURLIM_LDO1 0>;
> +				interrupt-parent = <&pmic>;
> +			};
> +
> +			v2v8: ldo2 {
> +				regulator-name = "v2v8";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				interrupts = <IT_CURLIM_LDO2 0>;
> +				interrupt-parent = <&pmic>;
> +			};
> +
> +			vtt_ddr: ldo3 {
> +				regulator-name = "vtt_ddr";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <750000>;
> +				regulator-always-on;
> +				regulator-over-current-protection;
> +			};
> +
> +			vdd_usb: ldo4 {
> +				regulator-name = "vdd_usb";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				interrupts = <IT_CURLIM_LDO4 0>;
> +				interrupt-parent = <&pmic>;
> +			};
> +
> +			vdd_sd: ldo5 {
> +				regulator-name = "vdd_sd";
> +				regulator-min-microvolt = <2900000>;
> +				regulator-max-microvolt = <2900000>;
> +				interrupts = <IT_CURLIM_LDO5 0>;
> +				interrupt-parent = <&pmic>;
> +				regulator-boot-on;
> +			};
> +
> +			v1v8: ldo6 {
> +				regulator-name = "v1v8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				interrupts = <IT_CURLIM_LDO6 0>;
> +				interrupt-parent = <&pmic>;
> +				regulator-enable-ramp-delay = <300000>;
> +			};
> +
> +			vref_ddr: vref_ddr {
> +				regulator-name = "vref_ddr";
> +				regulator-always-on;
> +				regulator-over-current-protection;
> +			};
> +
> +			bst_out: boost {
> +				regulator-name = "bst_out";
> +				interrupts = <IT_OCP_BOOST 0>;
> +				interrupt-parent = <&pmic>;
> +			};
> +
> +			vbus_otg: pwr_sw1 {
> +				regulator-name = "vbus_otg";
> +				interrupts = <IT_OCP_OTG 0>;
> +				interrupt-parent = <&pmic>;
> +				regulator-active-discharge;
> +			};
> +
> +			vbus_sw: pwr_sw2 {
> +				regulator-name = "vbus_sw";
> +				interrupts = <IT_OCP_SWOUT 0>;
> +				interrupt-parent = <&pmic>;
> +				regulator-active-discharge;
> +			};
> +		};
> +
> +		onkey {
> +			compatible = "st,stpmic1-onkey";
> +			interrupts = <IT_PONKEY_F 0>, <IT_PONKEY_R 1>;
> +			interrupt-names = "onkey-falling", "onkey-rising";
> +			status = "okay";
> +		};
> +
> +		watchdog {
> +			compatible = "st,stpmic1-wdt";
> +			status = "disabled";
> +		};
> +	};
> +};
> +
> +&iwdg2 {
> +	timeout-sec = <32>;
> +	status = "okay";
> +};
> +
> +&rng1 {
> +	status = "okay";
> +};
> +
> +&rtc {
> +	status = "okay";
> +};
> +
> +&sdmmc1 {
> +	pinctrl-names = "default", "opendrain", "sleep";
> +	pinctrl-0 = <&sdmmc1_b4_pins_a &sdmmc1_dir_pins_a>;
> +	pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
> +	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
> +	broken-cd;
> +	st,sig-dir;
> +	st,neg-edge;
> +	st,use-ckin;
> +	bus-width = <4>;
> +	vmmc-supply = <&vdd_sd>;
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	/* On Low speed expansion header */
> +	label = "LS-UART1";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart4_pins_b>;
> +	status = "okay";
> +};
> +
> +&uart7 {
> +	/* On Low speed expansion header */
> +	label = "LS-UART0";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart7_pins_a>;
> +	status = "okay";
> +};
> 
