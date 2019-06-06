Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF14C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 05:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF73820673
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 05:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EgRoybTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfFFF6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 01:58:11 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10498 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFF6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 01:58:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf8ab700000>; Wed, 05 Jun 2019 22:58:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 05 Jun 2019 22:58:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 05 Jun 2019 22:58:09 -0700
Received: from [10.24.45.153] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Jun
 2019 05:58:07 +0000
Subject: Re: [PATCH 1/2] arm64: tegra: add ACONNECT, ADMA and AGIC nodes
To:     Jon Hunter <jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1557143908-5850-1-git-send-email-spujar@nvidia.com>
 <9f9962fc-a261-aecc-b4c5-408a75ebcb5f@nvidia.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <490b81d9-2734-bb93-303b-94bb20a4f6a5@nvidia.com>
Date:   Thu, 6 Jun 2019 11:28:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9f9962fc-a261-aecc-b4c5-408a75ebcb5f@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559800688; bh=x5UYDkq9uzn4vHTOQOT/dowrMC88Ekd21dXparatcy0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=EgRoybTaitAEaJWVEpA68tEwXD/xRE3ZbMp77ryS4Boi3fbRxMNwp87W4AWiUWBKH
         O/7kvrHq5eO2VOj8wc+jaw32OPUHhjgwvJQsRGq/1j1oybiLe2ghh9rxMUIgl8PV5k
         ODVjK1n32cQYTRnj7OF8JdWile0QPmlWLjpyvK1LMee7q18dxxbPEmiIZixe15DsYE
         fhTs5oRppHtv8CkJG6N2JPhz4xzdxwO+HvH9F86OLpK0GwgzgjAXbnbFUkYQuCZzej
         Sx3cmIGkaRQadOogbs/7us4g2K2FQBhf0uhd2GSQZuVkYxC6cL41DtTluV1nYyPyP8
         wFnw80h2RU6CA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/4/2019 2:37 PM, Jon Hunter wrote:
> On 06/05/2019 12:58, Sameer Pujar wrote:
>> Add DT nodes for following devices on Tegra186 and Tegra194
>>   * ACONNECT
>>   * ADMA
>>   * AGIC
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> ---
>>   arch/arm64/boot/dts/nvidia/tegra186.dtsi | 67 ++++++++++++++++++++++++++++++++
>>   arch/arm64/boot/dts/nvidia/tegra194.dtsi | 67 ++++++++++++++++++++++++++++++++
>>   2 files changed, 134 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>> index 6e2b6ce..2c432c9 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>> @@ -1153,4 +1153,71 @@
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
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
> My recollection is that non-empty range is preferred from what Rob told
> me in the past. See the Tegra210 binding.
I see at various places empty ranges property is used. From DT spec, it 
means
there is no translation in the address space between parent/child.

Also I looked at Tegra210 binding,
ranges = <0x702c0000 0x0 0x702c0000 0x00040000>;
Should it be encoded as a triplet(child addr, parent addr, length)?
>
>> +		status = "disabled";
>> +
>> +		dma@2930000 {
> Although I did not do this for Tegra210, I think that the preferred
> convention is 'dma-controller@xxxxxxxxx'.
done.
>> +			compatible = "nvidia,tegra186-adma";
>> +			reg = <0x0 0x02930000 0x0 0x50000>;
>> +			interrupt-parent = <&agic>;
>> +			interrupts =  <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH 0>;
>> +			#dma-cells = <1>;
>> +			clocks = <&bpmp TEGRA186_CLK_AHUB>;
>> +			clock-names = "d_audio";
>> +			status = "disabled";
>> +		};
>> +
>> +		agic: agic@2a41000 {
>> +			compatible = "nvidia,tegra210-agic";
>> +			#interrupt-cells = <4>;
> Why 4? This does not match the binding document for the arm-gic.
will fix.
>> +			interrupt-controller;
>> +			reg = <0x0 0x02a41000 0x0 0x1000>,
>> +			      <0x0 0x02a42000 0x0 0x1000>;
> I believe that the 2nd address range should have size 0x2000 for the CPU
> interfaces.
done
>> +			interrupts = <GIC_SPI 145 (GIC_CPU_MASK_SIMPLE(4) |
>> +					IRQ_TYPE_LEVEL_HIGH)>;
>> +			clocks = <&bpmp TEGRA186_CLK_APE>;
>> +			clock-names = "clk";
>> +			status = "disabled";
>> +		};
>> +	};
>>   };
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> index c77ca21..dcab504 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> @@ -1054,4 +1054,71 @@
>>   				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>>   		interrupt-parent = <&gic>;
>>   	};
>> +
>> +	aconnect@2a41000 {
>> +		compatible = "nvidia,tegra210-aconnect";
>> +		clocks = <&bpmp TEGRA194_CLK_APE>,
>> +			 <&bpmp TEGRA194_CLK_APB2APE>;
>> +		clock-names = "ape", "apb2ape";
>> +		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_AUD>;
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
> Same as above.
>
>> +		status = "disabled";
>> +
>> +		dma@2930000 {
> Same as above.
>
>> +			compatible = "nvidia,tegra186-adma";
>> +			reg = <0x0 0x02930000 0x0 0x50000>;
>> +			interrupt-parent = <&agic>;
>> +			interrupts =  <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH 0>,
>> +				      <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH 0>;
>> +			#dma-cells = <1>;
>> +			clocks = <&bpmp TEGRA194_CLK_AHUB>;
>> +			clock-names = "d_audio";
>> +			status = "disabled";
>> +		};
>> +
>> +		agic: agic@2a41000 {
>> +			compatible = "nvidia,tegra210-agic";
>> +			#interrupt-cells = <4>;
> Same as above.
>
>> +			interrupt-controller;
>> +			reg = <0x0 0x02a41000 0x0 0x1000>,
>> +			      <0x0 0x02a42000 0x0 0x1000>;
> Same as above.
>
>> +			interrupts = <GIC_SPI 145 (GIC_CPU_MASK_SIMPLE(4) |
>> +					IRQ_TYPE_LEVEL_HIGH)>;
>> +			clocks = <&bpmp TEGRA194_CLK_APE>;
>> +			clock-names = "clk";
>> +			status = "disabled";
>> +		};
>> +	};
>>   };
>>
> Cheers
> Jon
>
