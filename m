Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1932BC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D751920989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfEGMiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 08:38:13 -0400
Received: from wp126.webpack.hosteurope.de ([80.237.132.133]:59536 "EHLO
        wp126.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726224AbfEGMiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 08:38:12 -0400
Received: from [2003:a:659:3f00:21a:4dff:fe85:1148] (helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1hNzMF-0003iM-5U; Tue, 07 May 2019 14:38:07 +0200
X-Virus-Scanned: by amavisd-new 2.11.1 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from [192.168.34.101] (p5098d998.dip0.t-ipconnect.de [80.152.217.152])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.14.5/SuSE Linux 0.8) with ESMTPSA id x47Cc523032092
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 7 May 2019 14:38:05 +0200
Subject: Re: [PATCH] usb: dwc2: Force 8bit UTMI width for Samsung Exynos SoCs
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20190503204958.GA12532@kozik-lap>
 <CGME20190506130052eucas1p25afd4e15648e9efc6fd011e46081fbea@eucas1p2.samsung.com>
 <20190506130046.20898-1-m.szyprowski@samsung.com>
 <39c7b687-449e-5e89-4c70-527d4e779fd9@fivetechno.de>
 <eefff244-f311-e59e-d914-9a18b5a21620@samsung.com>
 <26ff3deb-4b8d-7dd2-2418-d56f6dcea313@samsung.com>
From:   Markus Reichl <m.reichl@fivetechno.de>
Openpgp: preference=signencrypt
Autocrypt: addr=m.reichl@fivetechno.de; prefer-encrypt=mutual; keydata=
 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
 ZnS2JHg/17+ErCtiUzuJ5EGMPA==
Organization: five technologies GmbH
Message-ID: <e5ded84a-a6a2-f998-f6d8-5af7c7b432e2@fivetechno.de>
Date:   Tue, 7 May 2019 14:38:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <26ff3deb-4b8d-7dd2-2418-d56f6dcea313@samsung.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jQd3EMdFc47qTRaKrCGVpjLKjKCzoyw4f"
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1557232691;5b6394b7;
X-HE-SMSGID: 1hNzMF-0003iM-5U
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jQd3EMdFc47qTRaKrCGVpjLKjKCzoyw4f
Content-Type: multipart/mixed; boundary="qx0FfzwKdsQXFjs26GgsoSMGadaHSWCLD";
 protected-headers="v1"
From: Markus Reichl <m.reichl@fivetechno.de>
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-usb@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Minas Harutyunyan <hminas@synopsys.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Jules Maselbas <jmaselbas@kalray.eu>, Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <e5ded84a-a6a2-f998-f6d8-5af7c7b432e2@fivetechno.de>
Subject: Re: [PATCH] usb: dwc2: Force 8bit UTMI width for Samsung Exynos SoCs
References: <20190503204958.GA12532@kozik-lap>
 <CGME20190506130052eucas1p25afd4e15648e9efc6fd011e46081fbea@eucas1p2.samsung.com>
 <20190506130046.20898-1-m.szyprowski@samsung.com>
 <39c7b687-449e-5e89-4c70-527d4e779fd9@fivetechno.de>
 <eefff244-f311-e59e-d914-9a18b5a21620@samsung.com>
 <26ff3deb-4b8d-7dd2-2418-d56f6dcea313@samsung.com>
In-Reply-To: <26ff3deb-4b8d-7dd2-2418-d56f6dcea313@samsung.com>

--qx0FfzwKdsQXFjs26GgsoSMGadaHSWCLD
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Hi Marek,

Am 07.05.19 um 14:03 schrieb Marek Szyprowski:
> Hi All,
>=20
> On 2019-05-07 11:17, Marek Szyprowski wrote:
>> Hi Markus,
>>
>> On 2019-05-07 10:12, Markus Reichl wrote:
>>> Hi Marek,
>>>
>>> your patch did not help on stable v5.1
>>>
>>> [=C2=A0=C2=A0=C2=A0 3.255963] samsung-usb2-phy 125b0000.exynos-usbphy=
:=20
>>> 125b0000.exynos-usbphy supply vbus not found, using dummy regulator
>>> [=C2=A0=C2=A0=C2=A0 4.044547] usbcore: registered new interface drive=
r smsc95xx
>>> [=C2=A0=C2=A0=C2=A0 4.112261] usb usb1: New USB device found, idVendo=
r=3D1d6b,=20
>>> idProduct=3D0002, bcdDevice=3D 5.01
>>> [=C2=A0=C2=A0=C2=A0 4.120363] usb usb1: New USB device strings: Mfr=3D=
3, Product=3D2,=20
>>> SerialNumber=3D1
>>> [=C2=A0=C2=A0=C2=A0 4.127560] usb usb1: Product: EHCI Host Controller=

>>> [=C2=A0=C2=A0=C2=A0 4.132415] usb usb1: Manufacturer: Linux=20
>>> 5.1.0-00005-geb4efae48eb5 ehci_hcd
>>> [=C2=A0=C2=A0=C2=A0 4.139446] usb usb1: SerialNumber: 12580000.ehci
>>> [=C2=A0=C2=A0=C2=A0 4.183056] usb3503 0-0008: switched to HUB mode
>>> [=C2=A0=C2=A0=C2=A0 4.183121] usb3503 0-0008: usb3503_probe: probed i=
n hub mode
>>> [=C2=A0=C2=A0=C2=A0 4.488344] usb 1-2: new high-speed USB device numb=
er 2 using=20
>>> exynos-ehci
>>> [=C2=A0=C2=A0=C2=A0 4.675605] usb 1-2: New USB device found, idVendor=
=3D0424,=20
>>> idProduct=3D3503, bcdDevice=3Da1.a0
>>> [=C2=A0=C2=A0=C2=A0 4.678166] usb 1-2: New USB device strings: Mfr=3D=
0, Product=3D0,=20
>>> SerialNumber=3D0
>>> [=C2=A0=C2=A0=C2=A0 4.686140] usb 1-2: skipping disabled interface 0
>>>
>>> root@odroid-x2:~# lsusb
>>> Bus 001 Device 002: ID 0424:3503 Standard Microsystems Corp.
>>> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>>
>> This patch fixes the issue introduced by "usb: dwc2: gadget: Replace=20
>> phyif with phy_utmi_width" commit, which is queued only to linux-next =

>> so far. Stable v5.1 doesn't include it, so the fix doesn't change=20
>> anything on v5.1.
>>
>> I've checked and OdroidU3 works fine with v5.1 release, but X2 fails=20
>> to detect USB devices. I will investigate this in a few minutes...
>=20
>=20
> Broken USB on X2 is caused by commit=20
> 01fdf179f4b064d4c9d30b39aba178caf32649f4 ("usb: core: skip interfaces=20
> disabled in devicetree").
>=20
> I looks that the mentioned commit conflicts with the Exynos EHCI and=20
> OHCI bindings and the way the PHY ports are defined for those drivers. =

> It worked on U3 only by the pure coincidence. This is probably a=20
> "minimal" fix for this issue:

Thanks Marek, below fix enables USB on Odroid-X2 with stable v5.1.

>=20
> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index 82239f27c4cc..cd455c4add25 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c
> @@ -2007,6 +2007,7 @@ int usb_set_configuration(struct usb_device *dev,=
=20
> int configuration)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct usb_interface *intf =3D cp->interface[i];
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (intf->dev.of_node &&
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of_device_is_compatible(intf->dev.of=
_node, NULL) &&
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !of_device_is_available(intf->=
dev.of_node)) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_in=
fo(&dev->dev, "skipping disabled=20
> interface %d\n",
> intf->cur_altsetting->desc.bInterfaceNumber);
>=20
> I will try to describe the problem in details and discuss it on the usb=
=20
> mailing list.
>=20
> Best regards
>=20

Gru=C3=9F,
--=20
Markus Reichl


--qx0FfzwKdsQXFjs26GgsoSMGadaHSWCLD--

--jQd3EMdFc47qTRaKrCGVpjLKjKCzoyw4f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEVKeIeBh0ZWJOldzLOiXeDmsa/bIFAlzRfCoACgkQOiXeDmsa
/bK2LwwAx+0GgxHLGk0tMs5zq91YuX1lPr7gH0Kgha1DXAV70khVvjJ6o+gPsEDS
aEr28vKc+nOnWGRi3ihgcc6s8hbFsbQUkg3PG2jGc1T0h/WVwgDdFT3dhi/J6D8R
L1dnqsg1YFBJGaZgx81q4InyMOds5alMG4A9ibbEyOJuWc8aqx/VwjsNsPZ16sfP
sh3MMYOxo736aEU6gBFl0mjybEpNrDI4w3I8EAXneky1nF5lK5KGpL9Zg1BFQuKb
2NZlsLD7xmdsQ/J6+B62wBWLOw1oN0A1q2VAGNCxF7sata8QC2+NxCdNbIaaJtz1
WYTclML+ltdbx2gGgW0HAxIl6EpRABSO3NXDKlo2RVQhfCgsjZBEXmqfJl2BrZpO
9qlC74Q+9IEdF2UhFQg9Goo42WY238G0or1K1+O3bzcqLp9RT7q+sXx8NxhrcAGy
gIw++POPpDq29xawqeJ8wnTZK2DkjO8DjbUVx20S6qSNs9g8N96NU5SUJ2ySu8+3
5+7YIoQW
=jBwf
-----END PGP SIGNATURE-----

--jQd3EMdFc47qTRaKrCGVpjLKjKCzoyw4f--
