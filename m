Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B91C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6792220872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="NfvtPKfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfFFHHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 03:07:02 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14164 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFHHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 03:07:02 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf8bb930000>; Thu, 06 Jun 2019 00:06:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 06 Jun 2019 00:07:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 06 Jun 2019 00:07:01 -0700
Received: from [10.26.11.84] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Jun
 2019 07:06:59 +0000
Subject: Re: [PATCH 1/2] arm64: tegra: add ACONNECT, ADMA and AGIC nodes
To:     Sameer Pujar <spujar@nvidia.com>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1557143908-5850-1-git-send-email-spujar@nvidia.com>
 <9f9962fc-a261-aecc-b4c5-408a75ebcb5f@nvidia.com>
 <490b81d9-2734-bb93-303b-94bb20a4f6a5@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <3b19a2bb-20a0-c650-49b7-d966585b5ba9@nvidia.com>
Date:   Thu, 6 Jun 2019 08:06:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <490b81d9-2734-bb93-303b-94bb20a4f6a5@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559804819; bh=Qogml3uZUkadmLM0Z3jsCr7L/168NFfO/EMbeCDrj+I=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=NfvtPKfrIyF4L1qHT1vMGT8m3zkSeuEAgZGRrBpEhYAlyfXdTajamdTupH7UWsAGS
         EkK7pM5bYmycH5N4sLbfJ2DW4PPjXl795g4lCNznXmRH5AHb9TK0N13zmLtUQSBwxP
         uA8wokpa+EvmKXXsT+7kWuqjGmeiffJ+4ZkT0nxk0iFWLEoOfrchB5fitolsw4J8t0
         IJLwgiDvRjn+z+d3PeT6I1r21eatgJj1GMVvCYQRVjpF7/4JGXJiyv3+gqafloI2q5
         GiCqN6P6GzbWTH/CAPmZIujCbSqKz7yiD4KxUVf5AzD6nE3sRywqtwtmp/g7iHR1z9
         u2lu8VhygfM/w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/06/2019 06:58, Sameer Pujar wrote:
>=20
> On 6/4/2019 2:37 PM, Jon Hunter wrote:
>> On 06/05/2019 12:58, Sameer Pujar wrote:
>>> Add DT nodes for following devices on Tegra186 and Tegra194
>>> =C2=A0 * ACONNECT
>>> =C2=A0 * ADMA
>>> =C2=A0 * AGIC
>>>
>>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>>> ---
>>> =C2=A0 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 67
>>> ++++++++++++++++++++++++++++++++
>>> =C2=A0 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 67
>>> ++++++++++++++++++++++++++++++++
>>> =C2=A0 2 files changed, 134 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>>> b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>>> index 6e2b6ce..2c432c9 100644
>>> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>>> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
>>> @@ -1153,4 +1153,71 @@
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_=
LOW)>;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupt-parent=
 =3D <&gic>;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0 aconnect@2a41000 {
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
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <2>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <2>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ranges;
>> My recollection is that non-empty range is preferred from what Rob told
>> me in the past. See the Tegra210 binding.
> I see at various places empty ranges property is used. From DT spec, it
> means
> there is no translation in the address space between parent/child.

Yes that is correct, but this is what Rob told me in the past ...

"Use of non-empty ranges is preferred though there is not much benefit
if the parent and child sizes are the same. However, it does also
limit what is a valid address for those child nodes."

So I think it is best to be consistent.

> Also I looked at Tegra210 binding,
> ranges =3D <0x702c0000 0x0 0x702c0000 0x00040000>;
> Should it be encoded as a triplet(child addr, parent addr, length)?
Right but remember the parent address is 2 cells, hence the 4 values.

Jon

--=20
nvpublic
