Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7570EC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B2E7207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SjLLkrxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733137AbfFMPCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:02:02 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6732 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733035AbfFMPCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:02:00 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0265670002>; Thu, 13 Jun 2019 08:01:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 13 Jun 2019 08:01:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 13 Jun 2019 08:01:59 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 13 Jun
 2019 15:01:57 +0000
Subject: Re: [PATCH v5 1/2] arm64: tegra: add ACONNECT, ADMA and AGIC nodes
To:     Sameer Pujar <spujar@nvidia.com>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <mkumard@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1560422477-11242-1-git-send-email-spujar@nvidia.com>
 <3f1ebc62-1498-f26c-9044-8634242fc61e@nvidia.com>
 <9c5dbfc5-122b-2049-fdad-7ffeab6a9ec9@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <97303572-48d5-3da6-6e60-51056c82b7fd@nvidia.com>
Date:   Thu, 13 Jun 2019 16:01:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9c5dbfc5-122b-2049-fdad-7ffeab6a9ec9@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560438119; bh=gAeYNrokAD9Q2kca+yWScB3sbyQIxjUJco5GbiuobI8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=SjLLkrxl12fk5dLATa9X7QQSsJB3mKzVLXzocYLZAsRb8Ujbfjn/O4TUsCommW+Kx
         0YUlZl0V+wMcHqzns4QKM7Iq138xtW0mMSSNcpkv208Ar6pPe38/av3wWkNPr0WEAn
         n1MYFRryF3pRteSTg2InXvl7Kh5VGLDdEKdTx0RYDrfRxlI89kdh1RxkxipItU0xHY
         Cl1zvUWTOpp3Yn212zxZbVEiaK84V2oiciohoeLcQ5MbgjxKPqQAT1Mvw2S2Lp0OEG
         dfMe6sGJ4dpo/6uJtrqt3GGEsxDMM6JWdaiXqNc1/YmeS4hxFuk+By6vz45gQuzhWI
         OletykY5rHcIQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/06/2019 15:43, Sameer Pujar wrote:
>=20
> On 6/13/2019 7:39 PM, Jon Hunter wrote:
>> On 13/06/2019 11:41, Sameer Pujar wrote:
>>> Add DT nodes for following devices on Tegra186 and Tegra194
>>> =C2=A0 * ACONNECT
>>> =C2=A0 * ADMA
>>> =C2=A0 * AGIC
>>>
>>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>>> ---
>>> =C2=A0 changes from previous revision
>>> =C2=A0=C2=A0 * fixed size value for ranges property in aconnect
>>>
>>> =C2=A0 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 67
>>> ++++++++++++++++++++++++++++++++
>>> =C2=A0 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 67
>>> ++++++++++++++++++++++++++++++++
>>> =C2=A0 2 files changed, 134 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>>> b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>>> index 426ac0b..5e9fe7e 100644
>>> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>>> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>>> @@ -1295,4 +1295,71 @@
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_=
LOW)>;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupt-parent=
 =3D <&gic>;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0 aconnect {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "nvidia,tegr=
a210-aconnect";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&bpmp TEGRA186_=
CLK_APE>,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 <&bpmp TEGRA186_CLK_APB2APE>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names =3D "ape", "apb=
2ape";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 power-domains =3D <&bpmp TE=
GRA186_POWER_DOMAIN_AUD>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <1>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ranges =3D <0x02900000 0x0 =
0x02900000 0x200000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "disabled";
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma-controller@2930000 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 com=
patible =3D "nvidia,tegra186-adma";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg=
 =3D <0x02930000 0x50000>;
>> Sorry but I have been double checking these register addresses and I
>> wonder if this should be a length of 0x10000. The 0x50000 includes all
>> the ranges where the registers are paged, so I don't think that this is
>> correct including these.
> Is it because we don't have virtualization support yet?

Yes those are for virtulisation, but I don't believe we need them here.

> and isn't the range 0x10000 covers only global register space, don't we
> want to include page1 ADMA channel registers. In that case it would be
> 0x20000.

Yes, 0x20000 is correct indeed

Cheers
Jon

--=20
nvpublic
