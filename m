Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32485C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06526218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfLRHAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 02:00:33 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:48539 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfLRHAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 02:00:33 -0500
Received: from [10.28.39.99] (10.28.39.99) by mail-sz.amlogic.com (10.28.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 18 Dec
 2019 15:00:53 +0800
Subject: Re: [PATCH v4 5/6] dt-bindings: clock: meson: add A1 peripheral clock
 controller bindings
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Kevin Hilman <khilman@baylibre.com>, Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20191206074052.15557-1-jian.hu@amlogic.com>
 <20191206074052.15557-6-jian.hu@amlogic.com>
 <1ja77xlv9c.fsf@starbuckisacylon.baylibre.com>
From:   Jian Hu <jian.hu@amlogic.com>
Message-ID: <1538849d-34eb-c5bc-0663-a3e4fded3bc7@amlogic.com>
Date:   Wed, 18 Dec 2019 15:00:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1ja77xlv9c.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.39.99]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/12/12 17:59, Jerome Brunet wrote:
> 
> On Fri 06 Dec 2019 at 08:40, Jian Hu <jian.hu@amlogic.com> wrote:
> 
>> Add the documentation to support Amlogic A1 peripheral clock driver,
>> and add A1 peripheral clock controller bindings.
>>
>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>> ---
>>   .../bindings/clock/amlogic,a1-clkc.yaml       | 70 +++++++++++++
>>   include/dt-bindings/clock/a1-clkc.h           | 98 +++++++++++++++++++
>>   2 files changed, 168 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
>>   create mode 100644 include/dt-bindings/clock/a1-clkc.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
>> new file mode 100644
>> index 000000000000..dd3ce071834e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
>> @@ -0,0 +1,70 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> 
> Same Here, Either take Rob's suggestion from v1 or reply to his comment.
> 
OK, I will change it.
>> +/*
>> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>> + */
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/clock/amlogic,a1-clkc.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: Amlogic Meson A/C serials Peripheral Clock Control Unit Device Tree Bindings
>> +
>> +maintainers:
>> +  - Neil Armstrong <narmstrong@baylibre.com>
>> +  - Jerome Brunet <jbrunet@baylibre.com>
>> +  - Jian Hu <jian.hu@jian.hu.com>
>> +
>> +properties:
>> +  "#clock-cells":
>> +    const: 1
>> +  compatible:
>> +    - enum:
>> +        - amlogic,a1-periphs-clkc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    minItems: 6
>> +    maxItems: 6
>> +    items:
>> +      - description: Input fixed pll div2
>> +      - description: Input fixed pll div3
>> +      - description: Input fixed pll div5
>> +      - description: Input fixed pll div7
>> +      - description: HIFI PLL
>> +      - description: Input Oscillator (usually at 24MHz)
>> +
>> +  clock-names:
>> +    minItems: 6
>> +    maxItems: 6
>> +    items:
>> +      - const: fclk_div2
>> +      - const: fclk_div3
>> +      - const: fclk_div5
>> +      - const: fclk_div7
>> +      - const: hifi_pll
>> +      - const: xtal
>> +
>> +required:
>> +  - "#clock-cells"
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +
>> +examples:
>> +  - |
>> +    clkc_periphs: periphs-clock-controller {
>> +        compatible = "amlogic,a1-periphs-clkc";
>> +        reg = <0 0x800 0 0x104>;
>> +        #clock-cells = <1>;
>> +        clocks = <&clkc_pll CLKID_FCLK_DIV2>,
>> +                <&clkc_pll CLKID_FCLK_DIV3>,
>> +                <&clkc_pll CLKID_FCLK_DIV5>,
>> +                <&clkc_pll CLKID_FCLK_DIV7>,
>> +                <&clkc_pll CLKID_HIFI_PLL>,
>> +                <&xtal>;
>> +        clock-names = "fclk_div2", "fclk_div3", "fclk_div5",
>> +                      "fclk_div7", "hifi_pll", "xtal";
>> +   };
>> diff --git a/include/dt-bindings/clock/a1-clkc.h b/include/dt-bindings/clock/a1-clkc.h
>> new file mode 100644
>> index 000000000000..1ba01122457c
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/a1-clkc.h
>> @@ -0,0 +1,98 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>> +/*
>> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>> + */
>> +
>> +#ifndef __A1_CLKC_H
>> +#define __A1_CLKC_H
>> +
>> +#define CLKID_XTAL_FIXPLL			1
>> +#define CLKID_XTAL_USB_PHY			2
>> +#define CLKID_XTAL_USB_CTRL			3
>> +#define CLKID_XTAL_HIFIPLL			4
>> +#define CLKID_XTAL_SYSPLL			5
>> +#define CLKID_XTAL_DDS				6
>> +#define CLKID_SYS_CLK				7
>> +#define CLKID_CLKTREE				8
>> +#define CLKID_RESET_CTRL			9
>> +#define CLKID_ANALOG_CTRL			10
>> +#define CLKID_PWR_CTRL				11
>> +#define CLKID_PAD_CTRL				12
>> +#define CLKID_SYS_CTRL				13
>> +#define CLKID_TEMP_SENSOR			14
>> +#define CLKID_AM2AXI_DIV			15
>> +#define CLKID_SPICC_B				16
>> +#define CLKID_SPICC_A				17
>> +#define CLKID_CLK_MSR				18
>> +#define CLKID_AUDIO				19
>> +#define CLKID_JTAG_CTRL				20
>> +#define CLKID_SARADC				21
>> +#define CLKID_PWM_EF				22
>> +#define CLKID_PWM_CD				23
>> +#define CLKID_PWM_AB				24
>> +#define CLKID_CEC				25
>> +#define CLKID_I2C_S				26
>> +#define CLKID_IR_CTRL				27
>> +#define CLKID_I2C_M_D				28
>> +#define CLKID_I2C_M_C				29
>> +#define CLKID_I2C_M_B				30
>> +#define CLKID_I2C_M_A				31
>> +#define CLKID_ACODEC				32
>> +#define CLKID_OTP				33
>> +#define CLKID_SD_EMMC_A				34
>> +#define CLKID_USB_PHY				35
>> +#define CLKID_USB_CTRL				36
>> +#define CLKID_SYS_DSPB				37
>> +#define CLKID_SYS_DSPA				38
>> +#define CLKID_DMA				39
>> +#define CLKID_IRQ_CTRL				40
>> +#define CLKID_NIC				41
>> +#define CLKID_GIC				42
>> +#define CLKID_UART_C				43
>> +#define CLKID_UART_B				44
>> +#define CLKID_UART_A				45
>> +#define CLKID_SYS_PSRAM				46
>> +#define CLKID_RSA				47
>> +#define CLKID_CORESIGHT				48
>> +#define CLKID_AM2AXI_VAD			49
>> +#define CLKID_AUDIO_VAD				50
>> +#define CLKID_AXI_DMC				51
>> +#define CLKID_AXI_PSRAM				52
>> +#define CLKID_RAMB				53
>> +#define CLKID_RAMA				54
>> +#define CLKID_AXI_SPIFC				55
>> +#define CLKID_AXI_NIC				56
>> +#define CLKID_AXI_DMA				57
>> +#define CLKID_CPU_CTRL				58
>> +#define CLKID_ROM				59
>> +#define CLKID_PROC_I2C				60
>> +#define CLKID_DSPA_SEL				61
>> +#define CLKID_DSPB_SEL				62
>> +#define CLKID_DSPA_EN_DSPA			63
>> +#define CLKID_DSPA_EN_NIC			64
>> +#define CLKID_DSPB_EN_DSPB			65
>> +#define CLKID_DSPB_EN_NIC			66
>> +#define CLKID_RTC_CLK				67
>> +#define CLKID_CECA_32K				68
>> +#define CLKID_CECB_32K				69
>> +#define CLKID_24M				70
>> +#define CLKID_12M				71
>> +#define CLKID_FCLK_DIV2_DIVN			72
>> +#define CLKID_GEN				73
>> +#define CLKID_SARADC_SEL			74
>> +#define CLKID_SARADC_CLK			75
>> +#define CLKID_PWM_A				76
>> +#define CLKID_PWM_B				77
>> +#define CLKID_PWM_C				78
>> +#define CLKID_PWM_D				79
>> +#define CLKID_PWM_E				80
>> +#define CLKID_PWM_F				81
>> +#define CLKID_SPICC				82
>> +#define CLKID_TS				83
>> +#define CLKID_SPIFC				84
>> +#define CLKID_USB_BUS				85
>> +#define CLKID_SD_EMMC				86
>> +#define CLKID_PSRAM				87
>> +#define CLKID_DMC				88
>> +
>> +#endif /* __A1_CLKC_H */
> 
> .
> 
