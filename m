Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87930C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6924E21783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfKLIKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:10:39 -0500
Received: from regular1.263xmail.com ([211.150.70.205]:51744 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfKLIKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:10:39 -0500
X-Greylist: delayed 313 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Nov 2019 03:10:34 EST
Received: from localhost (unknown [192.168.165.103])
        by regular1.263xmail.com (Postfix) with ESMTP id 19ABB3F8;
        Tue, 12 Nov 2019 16:10:32 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.60.65] (unknown [103.29.142.67])
        by smtp.263.net (postfix) whith ESMTP id P28956T140214120982272S1573546217072329_;
        Tue, 12 Nov 2019 16:10:25 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <2dae6d66972adefe869be260d0fd7220>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH 2/3] arm64: dts: rk3399-rock960: add vdd_log
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     heiko@sntech.de, linux-rockchip@lists.infradead.org,
        Akash Gajjar <akash@openedev.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191111005158.25070-1-kever.yang@rock-chips.com>
 <20191111005158.25070-2-kever.yang@rock-chips.com>
 <20191111052232.GA2842@Mani-XPS-13-9360>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <3d129826-7705-819e-e68b-cc9080eb6c95@rock-chips.com>
Date:   Tue, 12 Nov 2019 16:10:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191111052232.GA2842@Mani-XPS-13-9360>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/11/11 下午1:22, Manivannan Sadhasivam wrote:
> Hi Kever,
>
> On Mon, Nov 11, 2019 at 08:51:57AM +0800, Kever Yang wrote:
>> Add vdd_log node according to rock960 schematic V13.
>>
>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>> ---
>>
>>   arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
>> index c7d48d41e184..73afee257115 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
>> @@ -76,6 +76,18 @@
>>   		regulator-always-on;
>>   		vin-supply = <&vcc5v0_sys>;
>>   	};
>> +
>> +	vdd_log: vdd-log {
>> +		compatible = "pwm-regulator";
>> +		pwms = <&pwm2 0 25000 1>;
>> +		regulator-name = "vdd_log";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = <800000>;
>> +		regulator-max-microvolt = <1400000>;
>> +		regulator-init-microvolt = <950000>;
> The default value seems to be 0.9v as per both Rock960 and Ficus schematics.


The default value is 0.9V when pwm-regulator is not enabled, and this 
'init-microvolt' suppose to set the

init value when pwm-regulator is enabled. I set this to 950mV because 
Peter report that he experience

the system hang during Fedora boot  up, and update the vdd_log to 950mV 
can fix the issue due to

engineer measure on another rk3399 board puma-Q7.


Thanks,

- Kever

>
> Other than that,
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> Thanks,
> Mani
>
>> +		vin-supply = <&vcc_sys>;
>> +	};
>>   };
>>   
>>   &cpu_l0 {
>> -- 
>> 2.17.1
>>


