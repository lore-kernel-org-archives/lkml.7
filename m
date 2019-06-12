Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90C6C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B0F20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MERg7/4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439342AbfFLM7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:59:25 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11483 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbfFLM7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:59:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d00f72c0000>; Wed, 12 Jun 2019 05:59:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 12 Jun 2019 05:59:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 12 Jun 2019 05:59:24 -0700
Received: from [10.25.72.203] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 12 Jun
 2019 12:59:20 +0000
Subject: Re: [PATCH v2 1/2] arm64: tegra: add ACONNECT, ADMA and AGIC nodes
To:     Jon Hunter <jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <mkumard@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1560243406-2535-1-git-send-email-spujar@nvidia.com>
 <1f2020ae-12f3-2ad1-c844-b4b7885d41f9@nvidia.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <ad169cb8-733c-96d4-5eee-1131c53320b6@nvidia.com>
Date:   Wed, 12 Jun 2019 18:29:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1f2020ae-12f3-2ad1-c844-b4b7885d41f9@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560344364; bh=PxIsfwb57+HaLFo01hW98b87Q1GeaYcpfwvv//9lWUQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=MERg7/4wgAxVM9YsKDXA3sGLIGuPSWq9Y5tF3OIQNvV8nw51zq/K2Xx8zNybi3h4U
         9d2gYLJvtpsZ8opwHysCdUqaTq01CtjluPLCz/mqHebmSMtQM5sSBZN/iKzvVmN0++
         MgJGdcruFhIKqOngNye4NVOfz1vCfhW8RSnUdur/41q1Z5Yo1gdDkZ33DvWWu2Qc3R
         yC0mFlwjELvG4VorYWkIgrX/nL3FOuAhZ1PZyltPM46HREQZLsD9aCGBDVZxmjfNPU
         iAQiAsmebzYPny5G26uGTddXYFj19qfUKEoQcpfikI6l6zyhIdIsa8JBwJohv3Z1gU
         Pz6Ely34dTK+Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/12/2019 6:06 PM, Jon Hunter wrote:
> On 11/06/2019 09:56, Sameer Pujar wrote:
>> Add DT nodes for following devices on Tegra186 and Tegra194
>>   * ACONNECT
>>   * ADMA
>>   * AGIC
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> ---
>>   arch/arm64/boot/dts/nvidia/tegra186.dtsi | 68 ++++++++++++++++++++++++++++++++
>>   arch/arm64/boot/dts/nvidia/tegra194.dtsi | 68 ++++++++++++++++++++++++++++++++
>>   2 files changed, 136 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>> index 426ac0b..ccd902b 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>> @@ -1295,4 +1295,72 @@
>>   				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>>   		interrupt-parent = <&gic>;
>>   	};
>> +
>> +	aconnect@2a41000 {
>> +		compatible = "nvidia,tegra210-aconnect";
>> +		clocks = <&bpmp TEGRA186_CLK_APE>,
>> +			 <&bpmp TEGRA186_CLK_APB2APE>;
>> +		clock-names = "ape", "apb2ape";
>> +		power-domains = <&bpmp TEGRA186_POWER_DOMAIN_AUD>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x02930000 0x0 0x02930000 0x50000
>> +			  0x02a41000 0x0 0x02a41000 0x3000>;
> We only need one address range here that covers the entire APE.
will update.
>
>> +		status = "disabled";
>> +
>> +		dma-controller@2930000 {
>> +			compatible = "nvidia,tegra186-adma";
>> +			reg = <0x02930000 0x50000>;
>> +			interrupt-parent = <&agic>;
>> +			interrupts =  <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
>> +				      <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
>> +			#dma-cells = <1>;
>> +			clocks = <&bpmp TEGRA186_CLK_AHUB>;
>> +			clock-names = "d_audio";
>> +			status = "disabled";
>> +		};
>> +
>> +		agic: agic@2a41000 {
>> +			compatible = "nvidia,tegra210-agic";
>> +			#interrupt-cells = <3>;
>> +			interrupt-controller;
>> +			reg = <0x02a41000 0x1000>,
>> +			      <0x02a41000 0x2000>;
> These addresses should not overlap.
typo! will fix, Thanks.
>
> Cheers
> Jon
>
