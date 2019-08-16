Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E34C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 11:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD17D205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 11:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=phytec.de header.i=@phytec.de header.b="DizoyXM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfHPLmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 07:42:42 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:64174 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfHPLml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 07:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1565955758; x=1568547758;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pSkzGPKxkenyrVL7iwf9WIPGXIN45VKdIwMoSZ1ZEow=;
        b=DizoyXM5jFsjMnhIbuFjSj9BTIqIKYpaazEv96RIZsft9phL4Tmp1JZLjZ9/SNMp
        k4WAELJsWuG43tlfH/CxC+Gs5P4G14pFJmJPGjwTQLdn5NvhOmu6bsoHvpTQQ0pL
        eEU3Pw9vwjNJKZxqREgMcQPf/FOHZKiqvVD1YZZ110M=;
X-AuditID: c39127d2-e1bff70000001af2-3d-5d5696ae28a7
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id D1.6A.06898.EA6965D5; Fri, 16 Aug 2019 13:42:38 +0200 (CEST)
Received: from [172.16.23.108] ([172.16.23.108])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2019081613423816-80238 ;
          Fri, 16 Aug 2019 13:42:38 +0200 
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: Add PHYTEC i.MX6 UL/ULL
 devicetree bindings
To:     Rob Herring <robh@kernel.org>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Andrew Smirnov <andrew.smirnov@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>
References: <1563954573-370205-1-git-send-email-s.riedmueller@phytec.de>
 <20190813160448.GA27548@bogus>
 <073f9466-9dd3-a22c-e000-e9f4c60f90a0@phytec.de>
 <CAL_JsqJHfVDfpC9Yr7o3HO4wU7QR+sp0mxFLkxwVcGXXLeAyJw@mail.gmail.com>
From:   =?UTF-8?Q?Stefan_Riedm=c3=bcller?= <s.riedmueller@phytec.de>
Message-ID: <cda26fbd-c683-d285-dc52-825d5e16a9e1@phytec.de>
Date:   Fri, 16 Aug 2019 13:42:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJHfVDfpC9Yr7o3HO4wU7QR+sp0mxFLkxwVcGXXLeAyJw@mail.gmail.com>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 16.08.2019 13:42:38,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 16.08.2019 13:42:38
X-TNEFEvaluated: 1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42JZI8DApbtuWlisQdN/SYvmDluL+UfOsVo8
        vOpvsenxNVaLrl8rmS0u75rDZnG3pZPVYun1i0wW//fsYLf4u30Ti8WLLeIO3B5r5q1h9Ng5
        6y67x6ZVnWwed67tYfPYvKTeY+O7HUwe/X8NPD5vkgvgiOKySUnNySxLLdK3S+DKaHr7kLlg
        jljFj/ONbA2MTwS7GDk5JARMJG5fncbYxcjFISSwg1GibfEJJgjnNKPEnVWvWUGqhAViJd6t
        ns8CYosIKEr8bpvGClLELHCTWeLVjYUsEB2PGSVWLPnGBlLFJuAksfh8B5jNK2AjMe/qHPYu
        Rg4OFgFViQVrpUHCogIREod3zGKEKBGUODnzCdgCToFAiZUPN7CDzJQQuMIoMbHxOjvErUIS
        pxefZQaxmQXMJOZtfghli0vcejKfCcLWlli28DXzBEahWUjmzkLSMgtJyywkLQsYWVYxCuVm
        JmenFmVm6xVkVJakJuulpG5iBEba4Ynql3Yw9s3xOMTIxMF4iFGCg1lJhHfCxaBYId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4rwbeEvChATSE0tSs1NTC1KLYLJMHJxSDYx+CleDXolscDXwuFKq
        UTYr29xLafaEU6w9xfO8J9t79XExO/xj9Qr2nsbaeNuJJzf+X5915G6DO457Lb2+r0x0inWa
        LPpFatfEA6k6PWc9td9M3qwl+dr4uZf+Qp0fjBXf3suueS6+/vYs+/n1ixLnTBdeas390XK1
        vXXURsuPQmvW35r8q1yJpTgj0VCLuag4EQBQuJqjogIAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 15.08.19 15:43, Rob Herring wrote:
> On Thu, Aug 15, 2019 at 4:55 AM Stefan Riedm=C3=BCller
> <s.riedmueller@phytec.de> wrote:
>>
>> Hi Rob,
>>
>> On 13.08.19 18:04, Rob Herring wrote:
>>> On Wed, Jul 24, 2019 at 09:49:32AM +0200, Stefan Riedmueller wrote:
>>>> Add devicetree bindings for i.MX6 UL/ULL based phyCORE-i.MX6 UL/ULL and
>>>> phyBOARD-Segin.
>>>>
>>>> Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
>>>> ---
>>>>    Documentation/devicetree/bindings/arm/fsl.yaml | 8 ++++++++
>>>>    1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Document=
ation/devicetree/bindings/arm/fsl.yaml
>>>> index 7294ac36f4c0..40f007859092 100644
>>>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
>>>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
>>>> @@ -161,12 +161,20 @@ properties:
>>>>            items:
>>>>              - enum:
>>>>                  - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 E=
VK Board
>>>> +              - phytec,imx6ul-pbacd10     # PHYTEC phyBOARD-Segin wit=
h i.MX6 UL
>>>> +              - phytec,imx6ul-pbacd10-emmc  # PHYTEC phyBOARD-Segin e=
MMC Kit
>>>> +              - phytec,imx6ul-pbacd10-nand  # PHYTEC phyBOARD-Segin N=
AND Kit
>>>> +              - phytec,imx6ul-pcl063      # PHYTEC phyCORE-i.MX 6UL
>>>
>>> This doesn't match what is in the dts files:
>>>
>>> arch/arm/boot/dts/imx6ul-phytec-pcl063.dtsi:    compatible =3D "phytec,=
imx6ul-pcl063", "fsl,imx6ul";
>>> arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts:      compatibl=
e =3D "phytec,imx6ul-pbacd10", "phytec,imx6ul-pcl063",
>>> "fsl,imx6ul";
>>> arch/arm/boot/dts/imx6ul-phytec-phyboard-segin.dtsi:    compatible =3D =
"phytec,imx6ul-pbacd-10", "phytec,imx6ul-pcl063",
>>> "fsl,imx6ul";
>>
>> Shawn already applied my patches which rename the compatibles, see
>> https://lkml.org/lkml/2019/7/23/42
>=20
> In any case, it still doesn't match. For example, from those patches:
>=20
> + model =3D "PHYTEC phyBOARD-Segin i.MX6 ULL Full Featured with eMMC";
> + compatible =3D "phytec,imx6ull-pbacd10-emmc", "phytec,imx6ull-pbacd10",
> +     "phytec,imx6ull-pcl063","fsl,imx6ull";
>=20
> The correct schema for this would be:
>=20
> items:
>    - const: phytec,imx6ull-pbacd10-emmc
>    - const: phytec,imx6ull-pbacd10
>    - const: phytec,imx6ull-pcl063
>    - const: fsl,imx6ull
>=20
> This defines how many entries (4), what they are, and the order of
> them. Maybe the first entry can be an enum with the -nand compatible
> if those are 2 options.
>=20
> Run 'make dtbs=5Fcheck' and make sure there aren't warnings for the root =
node.

Thanks for your input. I will take another closer look at this and send a=20
new version.

Stefan

>=20
> Rob
>=20
