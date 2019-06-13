Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4598C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3460208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lgD4LhRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbfFMPni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:43:38 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17385 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731835AbfFMJrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:47:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d021b9d0001>; Thu, 13 Jun 2019 02:47:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 13 Jun 2019 02:47:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 13 Jun 2019 02:47:09 -0700
Received: from [10.25.72.199] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 13 Jun
 2019 09:47:06 +0000
Subject: Re: [PATCH v3 1/2] arm64: tegra: add ACONNECT, ADMA and AGIC nodes
To:     Jon Hunter <jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <mkumard@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1560417053-2966-1-git-send-email-spujar@nvidia.com>
 <8a71e670-7943-6bce-ba61-3f020fd9450d@nvidia.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <6a4b5fac-68cd-542a-a907-0d80713f9d82@nvidia.com>
Date:   Thu, 13 Jun 2019 15:17:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <8a71e670-7943-6bce-ba61-3f020fd9450d@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560419230; bh=YU12ByuLCH7tZ1jS2msDQtEv9owNHhqfDpUOtnT0e+w=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=lgD4LhRd5386YjyITaBcYVW7w+koRR5FhTSRvhJkhUtDceodU4cowkY/Rj6o8pzXr
         uEJ8gzziTbeCtV4wcPmDTNyGukE9dAAANUIC9dPv9uiLDuhudhoE6VWmRxR8/3rFMQ
         2s5ha6EoUSkxbLpz0Hfsq7arNlTBJscLFmaCFIBL/ewCGIcdBJtJ2RSuStLr9R6Adu
         R/DqwY5zX2uhUMGkEqHiV/XhM1lKDufOmkI7V+MnX0zbVKpYW8hmP76QfZIuykiy2P
         fV4O+i3hGYojK3N1JdF6KIL1C2lnIo4wMwAEOPizdMq3fdm9JZXUXSi+c0pjW7W4PY
         nug4WV+hXY0BQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/13/2019 3:12 PM, Jon Hunter wrote:
> On 13/06/2019 10:10, Sameer Pujar wrote:
>> Add DT nodes for following devices on Tegra186 and Tegra194
>>   * ACONNECT
>>   * ADMA
>>   * AGIC
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> ---
>>   changes in current revision
>>    * use single address range for all APE modules
>>    * fix address range for agic
>>
>>   arch/arm64/boot/dts/nvidia/tegra186.dtsi | 67 ++++++++++++++++++++++++++++++++
>>   arch/arm64/boot/dts/nvidia/tegra194.dtsi | 67 ++++++++++++++++++++++++++++++++
>>   2 files changed, 134 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>> index 426ac0b..b4d735e 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>> @@ -1295,4 +1295,71 @@
>>   				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>>   		interrupt-parent = <&gic>;
>>   	};
>> +
>> +	aconnect@2a41000 {
> This address does not look correct. This appears to be the address of
> the AGIC. I think it should be 2900000, however, I also wonder if we
> should even bother with an address for the aconnect as this is just a
> bus and we don't specific a 'reg' property.
Do you mean, should be ok to just mention "aconnect {"?
>
>> +		compatible = "nvidia,tegra210-aconnect";
>> +		clocks = <&bpmp TEGRA186_CLK_APE>,
>> +			 <&bpmp TEGRA186_CLK_APB2APE>;
>> +		clock-names = "ape", "apb2ape";
>> +		power-domains = <&bpmp TEGRA186_POWER_DOMAIN_AUD>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x02900000 0x0 0x02900000 0x1FFFFF>;
> This should be 0x1fffff.
done
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
> I think that this should also be "agic: interrupt-controller@xxxx" to
> conform with standard names. Sorry the Tegra210 version is not the best
> reference!
will change
> Cheers
> Jon
>
