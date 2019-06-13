Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A469C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466DE20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eO8vvTb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732924AbfFMPAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:00:40 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4724 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732578AbfFMOnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:43:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0261040001>; Thu, 13 Jun 2019 07:43:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 13 Jun 2019 07:43:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 13 Jun 2019 07:43:16 -0700
Received: from [10.25.72.199] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 13 Jun
 2019 14:43:14 +0000
Subject: Re: [PATCH v5 1/2] arm64: tegra: add ACONNECT, ADMA and AGIC nodes
To:     Jon Hunter <jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <mkumard@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1560422477-11242-1-git-send-email-spujar@nvidia.com>
 <3f1ebc62-1498-f26c-9044-8634242fc61e@nvidia.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <9c5dbfc5-122b-2049-fdad-7ffeab6a9ec9@nvidia.com>
Date:   Thu, 13 Jun 2019 20:13:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <3f1ebc62-1498-f26c-9044-8634242fc61e@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560436996; bh=hNIQsfMLZu+COVCghcSuyQtUpapt6Btw4JX8rvc61l4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=eO8vvTb2YqRtiYn5g3Obv4jO+rdW+4EAkDouo95TxtH2os2CC9scIOm4UR4jrUAw0
         DTqVojSxjkbs/DO6FuVah0rCotb6MOkqqffayirBLxbbKLsaxFToIwiHj8DgY+IWwj
         YuIRQVLRmaVVSbIMr29WiAx9q6+aQ9Qz2rr68cZ9RjUQvBnuWlTnR2RoGeCs9jE8Ne
         I9mmRjHq4eoEiROIDcuFQ66aHjncXhVoLdGgxhKm+NZXIqi1cKsw+kWQ1ZGEnHR4P+
         GzAtuksOHcVdA8Bu4SxZIWvyA4Nw/gPY1kdnht2n4heZTgSIXMwGvzltoWjBtmZr4x
         xJhfqfhSZfZJA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/13/2019 7:39 PM, Jon Hunter wrote:
> On 13/06/2019 11:41, Sameer Pujar wrote:
>> Add DT nodes for following devices on Tegra186 and Tegra194
>>   * ACONNECT
>>   * ADMA
>>   * AGIC
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> ---
>>   changes from previous revision
>>    * fixed size value for ranges property in aconnect
>>
>>   arch/arm64/boot/dts/nvidia/tegra186.dtsi | 67 ++++++++++++++++++++++++=
++++++++
>>   arch/arm64/boot/dts/nvidia/tegra194.dtsi | 67 ++++++++++++++++++++++++=
++++++++
>>   2 files changed, 134 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/=
dts/nvidia/tegra186.dtsi
>> index 426ac0b..5e9fe7e 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>> @@ -1295,4 +1295,71 @@
>>   				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>>   		interrupt-parent =3D <&gic>;
>>   	};
>> +
>> +	aconnect {
>> +		compatible =3D "nvidia,tegra210-aconnect";
>> +		clocks =3D <&bpmp TEGRA186_CLK_APE>,
>> +			 <&bpmp TEGRA186_CLK_APB2APE>;
>> +		clock-names =3D "ape", "apb2ape";
>> +		power-domains =3D <&bpmp TEGRA186_POWER_DOMAIN_AUD>;
>> +		#address-cells =3D <1>;
>> +		#size-cells =3D <1>;
>> +		ranges =3D <0x02900000 0x0 0x02900000 0x200000>;
>> +		status =3D "disabled";
>> +
>> +		dma-controller@2930000 {
>> +			compatible =3D "nvidia,tegra186-adma";
>> +			reg =3D <0x02930000 0x50000>;
> Sorry but I have been double checking these register addresses and I
> wonder if this should be a length of 0x10000. The 0x50000 includes all
> the ranges where the registers are paged, so I don't think that this is
> correct including these.
Is it because we don't have virtualization support yet?
and isn't the range 0x10000 covers only global register space, don't we
want to include page1 ADMA channel registers. In that case it would be
0x20000.
>
>> +			interrupt-parent =3D <&agic>;
>> +			interrupts =3D  <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
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
>> +			#dma-cells =3D <1>;
>> +			clocks =3D <&bpmp TEGRA186_CLK_AHUB>;
>> +			clock-names =3D "d_audio";
>> +			status =3D "disabled";
>> +		};
>> +
>> +		agic: interrupt-controller@2a41000 {
> I think that this should be 2a40000 but otherwise looks correct.
 =C2=A0done.
> Sorry but you are too quick for me to keep up!
>
> Cheers
> Jon
>
