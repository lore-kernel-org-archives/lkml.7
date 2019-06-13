Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9FEC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6953206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Zsnuif08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733185AbfFMPff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:35:35 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2637 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbfFMKVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 06:21:51 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0223bf0000>; Thu, 13 Jun 2019 03:21:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 13 Jun 2019 03:21:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 13 Jun 2019 03:21:50 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 13 Jun
 2019 10:21:48 +0000
Subject: Re: [PATCH v3 1/2] arm64: tegra: add ACONNECT, ADMA and AGIC nodes
To:     Sameer Pujar <spujar@nvidia.com>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <mkumard@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1560417053-2966-1-git-send-email-spujar@nvidia.com>
 <8a71e670-7943-6bce-ba61-3f020fd9450d@nvidia.com>
 <6a4b5fac-68cd-542a-a907-0d80713f9d82@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <7a8426e9-a2c3-5cf6-9088-8ad81f558488@nvidia.com>
Date:   Thu, 13 Jun 2019 11:21:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <6a4b5fac-68cd-542a-a907-0d80713f9d82@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560421311; bh=iFkZqe5rMtibcofnVbf+47xZPC5Xxy4wl7HLwK+mfZk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Zsnuif08gCsNzH5xlIZ9xgBZY1smO8FcZDt9qpu5enC2fLBjVKg6i+TjlJWXSlRqz
         a8mu0jG635NLs8XlpkY3hbiVqvc3PVcZ0v4COg6LVIT5nEGBOBSkwnMgBHaoa7sWse
         b8TGwokYGGmfoaE5TnaLnAkA4Nj+hy2U+ZS8CEscrAyf2+E5dMiu89VXXnGzZ54TYn
         RNeDXyCpfUT4MyVSbCdbY8ActWGm3hAkZpjbriK1mdlyjda8G1zgPsyesPBFiHNA04
         o6CmARCA9WsLiswQT9PQRY7ApL9GlzfKrmYrqHyNqj0GM0LIgezfsK4iURc94+7nRG
         stcB3ppiWxQwg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/06/2019 10:47, Sameer Pujar wrote:
>=20
> On 6/13/2019 3:12 PM, Jon Hunter wrote:
>> On 13/06/2019 10:10, Sameer Pujar wrote:
>>> Add DT nodes for following devices on Tegra186 and Tegra194
>>> =C2=A0 * ACONNECT
>>> =C2=A0 * ADMA
>>> =C2=A0 * AGIC
>>>
>>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>>> ---
>>> =C2=A0 changes in current revision
>>> =C2=A0=C2=A0 * use single address range for all APE modules
>>> =C2=A0=C2=A0 * fix address range for agic
>>>
>>> =C2=A0 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 67
>>> ++++++++++++++++++++++++++++++++
>>> =C2=A0 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 67
>>> ++++++++++++++++++++++++++++++++
>>> =C2=A0 2 files changed, 134 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>>> b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>>> index 426ac0b..b4d735e 100644
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
>>> +=C2=A0=C2=A0=C2=A0 aconnect@2a41000 {
>> This address does not look correct. This appears to be the address of
>> the AGIC. I think it should be 2900000, however, I also wonder if we
>> should even bother with an address for the aconnect as this is just a
>> bus and we don't specific a 'reg' property.
> Do you mean, should be ok to just mention "aconnect {"?

I did a bit more reading and for Tegra186 there are no registers
implement for the aconnect (which is different from Tegra210) and so in
this case we should just have ...

	aconnect {
		...

>>
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
0x02900000 0x1FFFFF>;
>> This should be 0x1fffff.
> done

Sorry this should be 0x200000.

Cheers
Jon

--=20
nvpublic
