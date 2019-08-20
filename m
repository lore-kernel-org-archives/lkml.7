Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631C8C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1978422CEC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfHTCfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 22:35:18 -0400
Received: from regular1.263xmail.com ([211.150.70.199]:35848 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbfHTCfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 22:35:17 -0400
Received: from zhangzj?rock-chips.com (unknown [192.168.167.12])
        by regular1.263xmail.com (Postfix) with ESMTP id 16B86446;
        Tue, 20 Aug 2019 10:35:04 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.9.224] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P5320T140225617577728S1566268502189058_;
        Tue, 20 Aug 2019 10:35:03 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <5a8a9d461a75589e0333678f1fd331d6>
X-RL-SENDER: zhangzj@rock-chips.com
X-SENDER: zhangzj@rock-chips.com
X-LOGIN-NAME: zhangzj@rock-chips.com
X-FST-TO: devicetree@vger.kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH v2 1/1] arm64: dts: rockchip: Add support for TB-96AI
 board
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     heiko@sntech.de, mark.rutland@arm.com, robh+dt@kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20190805015755.26017-1-zhangzj@rock-chips.com>
 <20190805112810.GA19736@mani>
From:   Elon Zhang <zhangzj@rock-chips.com>
Message-ID: <f10c42dd-abdb-80b1-0a28-40dd1c1aca9a@rock-chips.com>
Date:   Tue, 20 Aug 2019 10:35:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805112810.GA19736@mani>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

Thanks for your review. Please see comments inline.

在 8/5/2019 19:28, Manivannan Sadhasivam 写道:
> Hi Elon,
>
> Thanks for the v2. Still the DT needs to be cleaned up a bit. I have tested this
> patch on TB96-AI SOM/Carrier board and found that the USB ports are not working
> at all! Do we need to change any switch settings?

Yes. The USB ports can not work. I have already added all USB related 
setting. I tried

rockchip internel rk3399.dtsi and the USB ports can work, so I think the 
cause is SoC related

setting difference in mainline kernel.

I can not figure it out for now, should I remove the usb related node in 
this patch?

>
> Comments are inline.
>
> On Mon, Aug 05, 2019 at 09:57:55AM +0800, Elon Zhang wrote:
>> Add devicetree support for RK3399Pro TB-96AI board, one of
>> the 96Boards family.
>>
>> The TB-96AI board is a 96Boards Compute SOM design, launched
>> by Linaro, Rockchip and Beiqicloud.
>>
>> More information can be obtained from the following websites:
>> 1.https://www.96boards.org/product/tb-96ai/
>> 2.http://t.rock-chips.com/
>> 3.http://www.beiqicloud.com/
>>
>> This patch add basic node for the board and support booting up
>> to Fedora.
>>
>> Signed-off-by: Elon Zhang <zhangzj@rock-chips.com>
>> ---
>> changes since v1:
>> - remove needless node
>> - using a standard LED formats for 96Boards
>>
>>   arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>>   .../boot/dts/rockchip/rk3399pro-tb-96ai.dts   | 560 ++++++++++++++++++
>>   2 files changed, 561 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3399pro-tb-96ai.dts
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
>> index 5f2687acbf94..3d6c8d4363b5 100644
>> --- a/arch/arm64/boot/dts/rockchip/Makefile
>> +++ b/arch/arm64/boot/dts/rockchip/Makefile
>> @@ -27,3 +27,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
>> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-tb-96ai.dtb
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-tb-96ai.dts b/arch/arm64/boot/dts/rockchip/rk3399pro-tb-96ai.dts
>> new file mode 100644
>> index 000000000000..767b37b854ba
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399pro-tb-96ai.dts
>> @@ -0,0 +1,560 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd.
>> + */
>> +
>> +/dts-v1/;
>> +#include "rk3399pro.dtsi"
>> +#include "rk3399-opp.dtsi"
>> +
>> +/ {
>> +	compatible = "beiqi,rk3399pro-tb-96ai", "rockchip,rk3399pro";
>> +
>> +	chosen {
>> +		stdout-path = "serial2:1500000n8";
>> +	};
>> +
>> +	xin32k: xin32k {
>> +		compatible = "fixed-clock";
>> +		clock-frequency = <32768>;
>> +		clock-output-names = "xin32k";
>> +		#clock-cells = <0>;
>> +	};
>> +
>> +	vcc5v0_sys: vccsys {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc5v0_sys";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +	};
>> +
>> +	leds {
> Still the LEDs are not defined as per the format I shared before...

I am not very sure what the format exactly is. Is the LEDs format below 
right?

  49         leds {
  50                 compatible = "gpio-leds";
  51                 pinctrl-names = "default";
  52                 pinctrl-0 = <&user_led1>,<&user_led2>,<&user_led3>;
  53
  54                 user_led1 {
  55                         label = "green:user1";
  56                         gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>;
  57                         retain-state-suspended;
  58                 };
  59
  60                 user_led2 {
  61                         label = "green:user2";
  62                         gpios = <&gpio2 4 GPIO_ACTIVE_HIGH>;
  63                         retain-state-suspended;
  64                 };
  65
  66                 user_led3 {
  67                         label = "green:user3";
  68                         gpios = <&gpio2 3 GPIO_ACTIVE_HIGH>;
  69                         retain-state-suspended;
  70                 };
  71         };

>
>> +		compatible = "gpio-leds";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&work_led1>,<&work_led2>,<&work_led3>;
>> +
>> +		work_led1 {
>> +			gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>;
>> +			label = "system_work_led1";
>> +			retain-state-suspended;
>> +		};
>> +
>> +		work_led2 {
>> +			gpios = <&gpio2 4 GPIO_ACTIVE_HIGH>;
>> +			label = "system_work_led2";
>> +			retain-state-suspended;
>> +		};
>> +
>> +		work_led3 {
>> +			gpios = <&gpio2 3 GPIO_ACTIVE_HIGH>;
>> +			label = "system_work_led3";
>> +			retain-state-suspended;
>> +		};
>> +	};
>> +};
>> +
>> +&cpu_l0 {
>> +	cpu-supply = <&vdd_cpu_l>;
>> +};
>> +
>> +&cpu_l1 {
>> +	cpu-supply = <&vdd_cpu_l>;
>> +};
>> +
>> +&cpu_l2 {
>> +	cpu-supply = <&vdd_cpu_l>;
>> +};
>> +
>> +&cpu_l3 {
>> +	cpu-supply = <&vdd_cpu_l>;
>> +};
>> +
>> +&cpu_b0 {
>> +	cpu-supply = <&vdd_cpu_b>;
>> +};
>> +
>> +&cpu_b1 {
>> +	cpu-supply = <&vdd_cpu_b>;
>> +};
>> +
>> +&emmc_phy {
>> +	status = "okay";
>> +};
>> +
>> +&i2c0 {
>> +	status = "okay";
>> +	i2c-scl-rising-time-ns = <180>;
>> +	i2c-scl-falling-time-ns = <30>;
>> +	clock-frequency = <400000>;
>> +
>> +	rk809: pmic@20 {
>> +		compatible = "rockchip,rk809";
>> +		reg = <0x20>;
>> +		interrupt-parent = <&gpio1>;
>> +		interrupts = <RK_PC2 IRQ_TYPE_LEVEL_LOW>;
>> +		pinctrl-names = "default", "pmic-sleep",
>> +				"pmic-power-off", "pmic-reset";
> Does these pinctrl configs useful other than default?

These pinctrl configs are used for sleep/wake. Since mainline MFD and 
pinctrl driver

has no pinctrl support for RK809, these pinctrl configs will be removed 
other than default.

>
>> +		pinctrl-0 = <&pmic_int_l>;
>> +		pinctrl-1 = <&soc_slppin_slp>, <&rk809_slppin_slp>;
>> +		pinctrl-2 = <&soc_slppin_gpio>, <&rk809_slppin_pwrdn>;
>> +		pinctrl-3 = <&soc_slppin_gpio>,<&rk809_slppin_null>;
>> +		rockchip,system-power-controller;
>> +		pmic-reset-func = <1>;
>> +		wakeup-source;
>> +		#clock-cells = <1>;
>> +		clock-output-names = "rk808-clkout1", "rk808-clkout2";
>> +
>> +		vcc1-supply = <&vcc5v0_sys>;
>> +		vcc2-supply = <&vcc5v0_sys>;
>> +		vcc3-supply = <&vcc5v0_sys>;
>> +		vcc4-supply = <&vcc5v0_sys>;
>> +		vcc5-supply = <&vcc_buck5>;
>> +		vcc6-supply = <&vcc_buck5>;
>> +		vcc7-supply = <&vcc3v3_sys>;
>> +		vcc8-supply = <&vcc3v3_sys>;
>> +		vcc9-supply = <&vcc5v0_sys>;
>> +
>> +		pwrkey {
>> +			status = "okay";
> No compatible needed?
No compatible needed. It is RK809 internel implement.
>
>> +		};
>> +
>> +		rtc {
>> +			status = "okay";
> No compatible needed?
ditto.
>
>> +		};
>> +
>> +		pinctrl_rk8xx: pinctrl_rk8xx {
> Mainline MFD driver has no pinctrl support for RK809.

Yes. This node will be removed.

Thank,

Elon

>
>> +			gpio-controller;
>> +			#gpio-cells = <2>;
>> +
>> +			rk809_slppin_null: rk809_slppin_null {
>> +				pins = "gpio_slp";
>> +				function = "pin_fun0";
>> +			};
>> +
>> +			rk809_slppin_slp: rk809_slppin_slp {
>> +				pins = "gpio_slp";
>> +				function = "pin_fun1";
>> +			};
>> +
>> +			rk809_slppin_pwrdn: rk809_slppin_pwrdn {
>> +				pins = "gpio_slp";
>> +				function = "pin_fun2";
>> +			};
>> +
>> +			rk809_slppin_rst: rk809_slppin_rst {
>> +				pins = "gpio_slp";
>> +				function = "pin_fun3";
>> +			};
>> +		};
>> +
>> +		regulators {
>> +			vdd_center: DCDC_REG1 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <750000>;
>> +				regulator-max-microvolt = <1350000>;
>> +				regulator-initial-mode = <0x2>;
>> +				regulator-name = "vdd_center";
> Please match the regulator names with schematic.
>
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <900000>;
>> +				};
>> +			};
>> +
>> +			vdd_cpu_l: DCDC_REG2 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <750000>;
>> +				regulator-max-microvolt = <1350000>;
>> +				regulator-ramp-delay = <6001>;
>> +				regulator-initial-mode = <0x2>;
>> +				regulator-name = "vdd_cpu_l";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcc_ddr: DCDC_REG3 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-name = "vcc_ddr";
>> +				regulator-initial-mode = <0x2>;
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcc3v3_sys: DCDC_REG4 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <3300000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-initial-mode = <0x2>;
>> +				regulator-name = "vcc3v3_sys";
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <3300000>;
>> +				};
>> +			};
>> +
>> +			vcc_buck5: DCDC_REG5 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <2200000>;
>> +				regulator-max-microvolt = <2200000>;
>> +				regulator-name = "vcc_buck5";
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <2200000>;
>> +				};
>> +			};
>> +
>> +			vcca_0v9: LDO_REG1 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <900000>;
>> +				regulator-max-microvolt = <900000>;
>> +				regulator-name = "vcca_0v9";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcc_1v8: LDO_REG2 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +
>> +				regulator-name = "vcc_1v8";
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <1800000>;
>> +				};
>> +			};
>> +
>> +			vcc0v9_soc: LDO_REG3 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <900000>;
>> +				regulator-max-microvolt = <900000>;
>> +
>> +				regulator-name = "vcc0v9_soc";
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <900000>;
>> +				};
>> +			};
>> +
>> +			vcca_1v8: LDO_REG4 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +
>> +				regulator-name = "vcca_1v8";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdd1v5_dvp: LDO_REG5 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <1500000>;
>> +				regulator-max-microvolt = <1500000>;
>> +
>> +				regulator-name = "vdd1v5_dvp";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcc_1v5: LDO_REG6 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <1500000>;
>> +				regulator-max-microvolt = <1500000>;
>> +
>> +				regulator-name = "vcc_1v5";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcc_3v0: LDO_REG7 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <3000000>;
>> +				regulator-max-microvolt = <3000000>;
>> +
>> +				regulator-name = "vcc_3v0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vccio_sd: LDO_REG8 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <3300000>;
>> +
>> +				regulator-name = "vccio_sd";
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <3300000>;
>> +				};
>> +			};
>> +
>> +			vcc_sd: LDO_REG9 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <3300000>;
>> +				regulator-max-microvolt = <3300000>;
>> +
>> +				regulator-name = "vcc_sd";
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <3300000>;
>> +				};
>> +			};
>> +
>> +			vcc5v0_usb: SWITCH_REG1 {
>> +				regulator-min-microvolt = <5000000>;
>> +				regulator-max-microvolt = <5000000>;
>> +
>> +				regulator-name = "vcc5v0_usb";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vccio_3v3: SWITCH_REG2 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <3300000>;
>> +				regulator-max-microvolt = <3300000>;
>> +
>> +				regulator-name = "vccio_3v3";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +		};
>> +	};
>> +
>> +	vdd_cpu_b: regulator@1c {
>> +		compatible = "fcs,fan53555";
>> +		reg = <0x1c>;
>> +		vin-supply = <&vcc5v0_sys>;
>> +		pinctrl-0 = <&vsel1_gpio>;
>> +		vsel-gpios = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
>> +		regulator-name = "vdd_cpu_b";
>> +		regulator-min-microvolt = <712500>;
>> +		regulator-max-microvolt = <1500000>;
>> +		regulator-ramp-delay = <2300>;
>> +		fcs,suspend-voltage-selector = <1>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-initial-state = <3>;
>> +		regulator-state-mem {
>> +			regulator-off-in-suspend;
>> +		};
>> +	};
>> +
>> +	vdd_gpu: regulator@10 {
>> +		compatible = "fcs,fan53555";
>> +		status = "okay";
>> +		reg = <0x10>;
>> +		vin-supply = <&vcc5v0_sys>;
>> +		pinctrl-0 = <&vsel2_gpio>;
>> +		vsel-gpios = <&gpio1 RK_PB6 GPIO_ACTIVE_HIGH>;
>> +		regulator-name = "vdd_gpu";
>> +		regulator-min-microvolt = <735000>;
>> +		regulator-max-microvolt = <1400000>;
>> +		regulator-ramp-delay = <2300>;
>> +		fcs,suspend-voltage-selector = <1>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-state-mem {
>> +			regulator-off-in-suspend;
>> +		};
>> +	};
>> +};
>> +
>> +&i2c8 {
>> +	status = "okay";
>> +	i2c-scl-rising-time-ns = <345>;
>> +	i2c-scl-falling-time-ns = <11>;
>> +	clock-frequency = <100000>;
>> +};
>> +
>> +&io_domains {
>> +	status = "okay";
>> +	bt656-supply = <&vcca_1v8>; /* APIO2_VDD */
>> +	audio-supply = <&vcca_1v8>; /* APIO5_VDD */
>> +	sdmmc-supply = <&vccio_sd>; /* SDMMC0_VDD */
>> +	gpio1830-supply = <&vcc_1v8>; /* APIO4_VDD */
>> +};
>> +
>> +&pinctrl {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&npu_ref_clk>;
>> +
>> +	leds {
>> +		work_led1: work_led1 {
>> +			rockchip,pins =
>> +				<2 5 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +
>> +		work_led2: work_led2 {
>> +			rockchip,pins =
>> +				<2 4 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +
>> +		work_led3: work_led3 {
>> +			rockchip,pins =
>> +				<2 3 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +	};
>> +
>> +	npu_clk {
>> +		npu_ref_clk: npu-ref-clk {
>> +			rockchip,pins =
>> +				<0 RK_PA2 1 &pcfg_pull_none>;
>> +		};
>> +	};
>> +
>> +	pmic {
>> +		pmic_int_l: pmic-int-l {
>> +			rockchip,pins =
>> +				<1 RK_PC2 0 &pcfg_pull_up>;
>> +		};
>> +
>> +		soc_slppin_gpio: soc-slppin-gpio {
>> +			rockchip,pins =
>> +				<1 RK_PA5 0 &pcfg_output_low>;
>> +		};
>> +
>> +		soc_slppin_slp: soc-slppin-slp {
>> +			rockchip,pins =
>> +				<1 RK_PA5 1 &pcfg_pull_down>;
>> +		};
>> +
>> +		vsel1_gpio: vsel1-gpio {
>> +			rockchip,pins =
>> +				<1 RK_PC1 0 &pcfg_pull_down>;
>> +		};
>> +
>> +		vsel2_gpio: vsel2-gpio {
>> +			rockchip,pins =
>> +				<1 RK_PB6 0 &pcfg_pull_down>;
>> +		};
>> +	};
>> +
>> +	usb3 {
>> +		usb3_host_en: usb3-host-en {
>> +			rockchip,pins =
>> +				<2 RK_PA2 RK_FUNC_GPIO &pcfg_output_high>;
>> +		};
>> +	};
>> +};
>> +
>> +&pmu_io_domains {
>> +	status = "okay";
>> +	pmu1830-supply = <&vcc_1v8>;
>> +};
>> +
>> +&pwm0 {
>> +	status = "okay";
>> +};
>> +
>> +&pwm2 {
>> +	status = "okay";
>> +};
>> +
>> +&saradc {
>> +	status = "okay";
>> +	vref-supply = <&vcc_1v8>;
>> +};
>> +
>> +&sdhci {
>> +	bus-width = <8>;
>> +	mmc-hs400-1_8v;
>> +	non-removable;
>> +	keep-power-in-suspend;
>> +	mmc-hs400-enhanced-strobe;
>> +	status = "okay";
>> +};
>> +
>> +&tcphy1 {
> No tcphy0? I can see this used in schematics.
>
>> +	status = "okay";
>> +};
>> +
>> +&tsadc {
>> +	rockchip,hw-tshut-mode = <1>; /* tshut mode 0:CRU 1:GPIO */
>> +	rockchip,hw-tshut-polarity = <1>; /* tshut polarity 0:LOW 1:HIGH */
>> +	status = "okay";
>> +};
>> +
>> +&u2phy1 {
> No u2phy0?
>
>> +	status = "okay";
>> +
>> +	u2phy1_otg: otg-port {
>> +		status = "okay";
>> +	};
>> +
>> +	u2phy1_host: host-port {
>> +		phy-supply = <&vcc5v0_usb>;
>> +		status = "okay";
>> +	};
>> +};
>> +
>> +&uart0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart0_xfer &uart0_cts>;
>> +	status = "okay";
>> +};
>> +
>> +&uart2 {
>> +	status = "okay";
>> +};
>> +
>> +&uart4 {
>> +	status = "okay";
>> +};
>> +
>> +&usb_host0_ehci {
>> +	status = "okay";
>> +};
>> +
>> +&usb_host1_ehci {
>> +	status = "okay";
>> +};
>> +
>> +&usb_host0_ohci {
>> +	status = "okay";
>> +};
>> +
>> +&usb_host1_ohci {
>> +	status = "okay";
>> +};
>> +
>> +&usbdrd3_1 {
>> +	status = "okay";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&usb3_host_en>;
>> +};
>> +
>> +&usbdrd_dwc3_0 {
> No usbdrd3_0?
>
> Thanks,
> Mani
>
>> +	status = "okay";
>> +};
>> +
>> +&usbdrd_dwc3_1 {
>> +	snps,dis-u3-autosuspend-quirk;
>> +	status = "okay";
>> +};
>> +
>> -- 
>> 2.17.1
>>
>>
>>
>
>


