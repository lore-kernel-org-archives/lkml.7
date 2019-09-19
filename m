Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB7DC4CEC9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 02:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADDC21BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 02:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbfISCd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 22:33:59 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:42135 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731394AbfISCd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 22:33:59 -0400
Received: from [10.28.19.63] (10.28.19.63) by mail-sz.amlogic.com (10.28.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Thu, 19 Sep
 2019 10:34:49 +0800
Subject: Re: [PATCH 2/3] dt-bindings: reset: add bindings for the Meson-A1 SoC
 Reset Controller
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1568808746-1153-1-git-send-email-xingyu.chen@amlogic.com>
 <1568808746-1153-3-git-send-email-xingyu.chen@amlogic.com>
 <d99786ec-7635-67e5-3e47-738ce131b634@baylibre.com>
From:   Xingyu Chen <xingyu.chen@amlogic.com>
Message-ID: <b6d7ad13-1bb4-5aea-ed13-3d695e8218e1@amlogic.com>
Date:   Thu, 19 Sep 2019 10:34:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d99786ec-7635-67e5-3e47-738ce131b634@baylibre.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.19.63]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Neil
Thanks for your review

On 2019/9/18 20:39, Neil Armstrong wrote:
> Hi,
> 
> On 18/09/2019 14:12, Xingyu Chen wrote:
>> Add DT bindings for the Meson-A1 SoC Reset Controller include file,
>> and also slightly update documentation.
>>
>> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> ---
>>   .../bindings/reset/amlogic,meson-reset.txt         |  4 +-
> 
> The reset bindings has been moved to yaml, either rebase on linux-next or wait for v5.4-rc1 :
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next/+/refs/tags/next-20190917/Documentation/devicetree/bindings/reset/amlogic%2Cmeson-reset.yaml
> 
> NeilI will fix it in next version.
> 
>>   include/dt-bindings/reset/amlogic,meson-a1-reset.h | 59 ++++++++++++++++++++++
>>   2 files changed, 61 insertions(+), 2 deletions(-)
>>   create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-reset.h
>>
>> diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt
>> index 28ef6c2..011151a 100644
>> --- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt
>> +++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt
>> @@ -5,8 +5,8 @@ Please also refer to reset.txt in this directory for common reset
>>   controller binding usage.
>>   
>>   Required properties:
>> -- compatible: Should be "amlogic,meson8b-reset", "amlogic,meson-gxbb-reset" or
>> -	"amlogic,meson-axg-reset".
>> +- compatible: Should be "amlogic,meson8b-reset", "amlogic,meson-gxbb-reset",
>> +	"amlogic,meson-axg-reset" or "amlogic,meson-a1-reset".
>>   - reg: should contain the register address base
>>   - #reset-cells: 1, see below
>>   
>> diff --git a/include/dt-bindings/reset/amlogic,meson-a1-reset.h b/include/dt-bindings/reset/amlogic,meson-a1-reset.h
>> new file mode 100644
>> index 00000000..8d76a47
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/amlogic,meson-a1-reset.h
>> @@ -0,0 +1,59 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> + *
>> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>> + * Author: Xingyu Chen <xingyu.chen@amlogic.com>
>> + *
>> + */
>> +
>> +#ifndef _DT_BINDINGS_AMLOGIC_MESON_A1_RESET_H
>> +#define _DT_BINDINGS_AMLOGIC_MESON_A1_RESET_H
>> +
>> +/* RESET0 */
>> +#define RESET_AM2AXI_VAD		1
>> +#define RESET_PSRAM			4
>> +#define RESET_PAD_CTRL			5
>> +#define RESET_TEMP_SENSOR		7
>> +#define RESET_AM2AXI_DEV		8
>> +#define RESET_SPICC_A			10
>> +#define RESET_MSR_CLK			11
>> +#define RESET_AUDIO			12
>> +#define RESET_ANALOG_CTRL		13
>> +#define RESET_SAR_ADC			14
>> +#define RESET_AUDIO_VAD			15
>> +#define RESET_CEC			16
>> +#define RESET_PWM_EF			17
>> +#define RESET_PWM_CD			18
>> +#define RESET_PWM_AB			19
>> +#define RESET_IR_CTRL			21
>> +#define RESET_I2C_S_A			22
>> +#define RESET_I2C_M_D			24
>> +#define RESET_I2C_M_C			25
>> +#define RESET_I2C_M_B			26
>> +#define RESET_I2C_M_A			27
>> +#define RESET_I2C_PROD_AHB		28
>> +#define RESET_I2C_PROD			29
>> +
>> +/* RESET1 */
>> +#define RESET_ACODEC			32
>> +#define RESET_DMA			33
>> +#define RESET_SD_EMMC_A			34
>> +#define RESET_USBCTRL			36
>> +#define RESET_USBPHY			38
>> +#define RESET_RSA			42
>> +#define RESET_DMC			43
>> +#define RESET_IRQ_CTRL			45
>> +#define RESET_NIC_VAD			47
>> +#define RESET_NIC_AXI			48
>> +#define RESET_RAMA			49
>> +#define RESET_RAMB			50
>> +#define RESET_ROM			53
>> +#define RESET_SPIFC			54
>> +#define RESET_GIC			55
>> +#define RESET_UART_C			56
>> +#define RESET_UART_B			57
>> +#define RESET_UART_A			58
>> +#define RESET_OSC_RING			59
>> +
>> +/* RESET2 Reserved */
>> +
>> +#endif
>>
> 
> .
> 
