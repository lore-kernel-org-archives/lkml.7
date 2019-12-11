Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB816C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7FD214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbfLKNPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:15:44 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:12596 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbfLKNPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:15:44 -0500
Received: from [10.28.39.99] (10.28.39.99) by mail-sz.amlogic.com (10.28.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 11 Dec
 2019 21:16:13 +0800
Subject: Re: [PATCH] arm64: dts: meson: add A1 periphs and PLL clock nodes
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
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20191211070835.83489-1-jian.hu@amlogic.com>
 <1jimmnkxj5.fsf@starbuckisacylon.baylibre.com>
From:   Jian Hu <jian.hu@amlogic.com>
Message-ID: <a171b388-7f92-17cd-8b9a-dcb1c846b6f7@amlogic.com>
Date:   Wed, 11 Dec 2019 21:16:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1jimmnkxj5.fsf@starbuckisacylon.baylibre.com>
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



On 2019/12/11 17:43, Jerome Brunet wrote:
> 
> On Wed 11 Dec 2019 at 08:08, Jian Hu <jian.hu@amlogic.com> wrote:
> 
>> Add A1 periphs and PLL clock controller nodes, Some clocks
>> in periphs controller are the parents of PLL clocks, Meanwhile
>> some clocks in PLL controller are those of periphs clocks.
>> They rely on each other.
> 
>> Compared with the previous series,
>> the register region is only for the clock. So syscon is not
>> used in A1.
> 
> Again, while this is valuable information for the maintainer to keep up,
> it is not something that should appear in the commit description.
> 
> The evolution of your commit should be described after the '---'
> 
OK, I will put the compared message after the '---'
> Also, this obviously depends on another series. It should be mentioned
> accordingly
OK, I will add the dependent clock patchset.
> 
>>
>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>> ---
>>   arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 26 +++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
>> index 7210ad049d1d..de43a010fa6e 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
>> @@ -5,6 +5,8 @@
>>   
>>   #include <dt-bindings/interrupt-controller/irq.h>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/clock/a1-pll-clkc.h>
>> +#include <dt-bindings/clock/a1-clkc.h>
> 
> When possible, please order the includes alpha-numerically
> 
OK, I will reorder it.
>>   
>>   / {
>>   	compatible = "amlogic,a1";
>> @@ -74,6 +76,30 @@
>>   			#size-cells = <2>;
>>   			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x1000000>;
>>   
>> +			clkc_periphs: periphs-clock-controller@800 {
>                                               ^
>>From DT spec: "The name of a node should be somewhat generic, reflecting
> the function of the device and not its precise programming model."
> 
> Here, an appropriate node name would be "clock-controller", not
> "periphs-clock-controller"
OK, I will change the node name.
> 
>> +				compatible = "amlogic,a1-periphs-clkc";
>> +				#clock-cells = <1>;
>> +				reg = <0 0x800 0 0x104>;
>> +				clocks = <&clkc_pll CLKID_FCLK_DIV2>,
>> +					<&clkc_pll CLKID_FCLK_DIV3>,
>> +					<&clkc_pll CLKID_FCLK_DIV5>,
>> +					<&clkc_pll CLKID_FCLK_DIV7>,
>> +					<&clkc_pll CLKID_HIFI_PLL>,
>> +					<&xtal>;
>> +				clock-names = "fclk_div2", "fclk_div3",
>> +					"fclk_div5", "fclk_div7",
>> +					"hifi_pll", "xtal";
>> +			};
>> +
>> +			clkc_pll: pll-clock-controller@7c80 {
> 
> Please order nodes by address when they have one.
> This clock controller should appear after the uarts
OK, I will reorder it.
> 
>> +				compatible = "amlogic,a1-pll-clkc";
>> +				#clock-cells = <1>;
>> +				reg = <0 0x7c80 0 0x21c>;
>> +				clocks = <&clkc_periphs CLKID_XTAL_FIXPLL>,
>> +					<&clkc_periphs CLKID_XTAL_HIFIPLL>;
>> +				clock-names = "xtal_fixpll", "xtal_hifipll";
>> +			};
>> +
>>   			uart_AO: serial@1c00 {
>>   				compatible = "amlogic,meson-gx-uart",
>>   					     "amlogic,meson-ao-uart";
> 
> .
> 
