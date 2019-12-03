Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E088C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708422068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FPFsJSgr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfLCX1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 18:27:51 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:16586 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfLCX1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 18:27:51 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5de6ef660000>; Tue, 03 Dec 2019 15:27:34 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 03 Dec 2019 15:27:49 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 03 Dec 2019 15:27:49 -0800
Received: from [10.2.160.125] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Dec
 2019 23:27:47 +0000
Subject: Re: [PATCH v1 15/17] dt-bindings: tegra186-pmc: Add Tegra PMC clock
 bindings
To:     Rob Herring <robh@kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <tglx@linutronix.de>, <mark.rutland@arm.com>,
        <allison@lohutok.net>, <pdeschrijver@nvidia.com>,
        <pgaikwad@nvidia.com>, <mturquette@baylibre.com>,
        <horms+renesas@verge.net.au>, <Jisheng.Zhang@synaptics.com>,
        <krzk@kernel.org>, <arnd@arndb.de>, <spujar@nvidia.com>,
        <josephl@nvidia.com>, <vidyas@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1574146234-3871-1-git-send-email-skomatineni@nvidia.com>
 <1574146234-3871-16-git-send-email-skomatineni@nvidia.com>
 <20191203221137.GC22716@bogus>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <5445c579-4a85-ca36-69c9-7fe86dbf1fa9@nvidia.com>
Date:   Tue, 3 Dec 2019 15:28:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191203221137.GC22716@bogus>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575415654; bh=vfVKzdkXztCZYuLAwJxHEwseHcXT4COainOIa886LgM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=FPFsJSgr2Xl5lXJiwp7y1kI1MbZpwU1cAbH96ysURG+n0SHopySY23mHtinpTJtFY
         m0ezg6GXZlHqMZFN9l2kGU1AEfslA76swmaNFrQyvBZMa4vSxLCDJ2R+oSLffxhK47
         hq1HRC+K1eVnbYC6gT+b87qkds0w8AS/uBYUMocpTVALujVMKsFFcKxN/hGbo7WYdM
         gLk+erJmzs0gbfpbmGQ1Lr/1vwMlyLmMotm69g6n6hkSbi7Ve5wEW4s/H3RfEDzXAW
         IIe90r+SdLqcaagrCdTDx6RZMb7vg+u8sd5dwcxHN95/Me59xUbDt9I57mIb7fJZpV
         FJqa7SmdFmLsg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/3/19 2:11 PM, Rob Herring wrote:
> On Mon, Nov 18, 2019 at 10:50:32PM -0800, Sowjanya Komatineni wrote:
>> Document clock bindings for pmc clocks clk_out_1, clk_out_2 and clk_out_3.
>> These clocks are part of Tegra PMC block and pmc node is the provider for
>> these clocks.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     | 44 ++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
>> index 2d89cdc39eb0..4576de92e4cc 100644
>> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
>> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
>> @@ -12,6 +12,10 @@ Required properties:
>>     - "aotag"
>>     - "scratch"
>>     - "misc" (Only for Tegra194)
>> +- #clock-cells : Should be 1 for Tegra30 and higher.
>> +  In clock consumers, this cell represents the PMC clock ID.
>> +  The assignments may be found in header file
>> +  <dt-bindings/soc/tegra-pmc.h>.
> Kind of strange the header is shared, but the binding doc is not.

v2 has this patch removed. Tegra186 does not have pmc clocks. They were 
accidentally added in v1 and this is fixed in v2.

>
>>   
>>   Optional properties:
>>   - nvidia,invert-interrupt: If present, inverts the PMU interrupt signal.
>> @@ -130,3 +134,43 @@ Pinctrl client example:
>>   		pinctrl-1 = <&hdmi_on>;
>>   		pinctrl-names = "hdmi-on", "hdmi-off";
>>   	};
>> +
>> +== Clock Control ==
>> +
>> +Tegra PMC has 3 clocks clk_1, clk_2 and clk_3. Each of these clocks has
>> +source selection and enable/disable gate.
>> +Parent/source for these clocks can be either of clk_m, clk_m_div2, clk_m_div4,
>> +or extern clock from Tegra CAR module.
>> +
>> +Clock configuration example:
>> +	pmc: pmc@7000e400 {
>> +		compatible = "nvidia,tegra186-pmc";
>> +		reg = <0 0x0c360000 0 0x10000>,
>> +		      <0 0x0c370000 0 0x10000>,
>> +		      <0 0x0c380000 0 0x10000>,
>> +		      <0 0x0c390000 0 0x10000>;
>> +		reg-names = "pmc", "wake", "aotag", "scratch";
>> +		...
>> +		#clock-cells = <1>;
>> +		...
> Once converted to schema, the examples have to compile and this won't.
> They also have to be complete enough to pass validation checks.
ok, will go thru and run the validation checks.
>> +	};
>> +
>> +Clock consumer example:
>> +	host1x@50000000 {
>> +		...
>> +		vi@54080000 {
>> +		...
>> +		assigned-clocks = <&pmc TEGRA_PMC_CLK_OUT_3_MUX>;
>> +		assigned-clock-parents = <&tegra_car TEGRA210_CLK_EXTERN3>;
> Indentation is wrong.
>
>> +		};
>> +		...
>> +	};
>> +	...
>> +	i2c@7000c500 {
>> +		cam_sensor {
>> +		...
>> +		clocks = <&pmc TEGRA_PMC_CLK_OUT_3>;
>> +		clock-names = "mclk";
> Same here.
>
>> +		...
>> +		};
>> +	};
>> -- 
>> 2.7.4
>>
