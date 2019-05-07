Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5597C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BEB204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfEGI7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 04:59:23 -0400
Received: from wp126.webpack.hosteurope.de ([80.237.132.133]:37334 "EHLO
        wp126.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726072AbfEGI7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 04:59:23 -0400
X-Greylist: delayed 2812 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 May 2019 04:59:21 EDT
Received: from [2003:a:659:3f00:21a:4dff:fe85:1148] (helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1hNvD6-00022c-Lw; Tue, 07 May 2019 10:12:24 +0200
X-Virus-Scanned: by amavisd-new 2.11.1 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from [192.168.34.101] (p5098d998.dip0.t-ipconnect.de [80.152.217.152])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.14.5/SuSE Linux 0.8) with ESMTPSA id x478CMHp011619
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 7 May 2019 10:12:23 +0200
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
From:   Markus Reichl <m.reichl@fivetechno.de>
Openpgp: preference=signencrypt
Autocrypt: addr=m.reichl@fivetechno.de; prefer-encrypt=mutual; keydata=
 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
 ZnS2JHg/17+ErCtiUzuJ5EGMPA==
Organization: five technologies GmbH
Message-ID: <39c7b687-449e-5e89-4c70-527d4e779fd9@fivetechno.de>
Date:   Tue, 7 May 2019 10:12:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506130046.20898-1-m.szyprowski@samsung.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jaQbzrRu5YUNCCshYysHQXwri4Q0c42fX"
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1557219561;e95e4547;
X-HE-SMSGID: 1hNvD6-00022c-Lw
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jaQbzrRu5YUNCCshYysHQXwri4Q0c42fX
Content-Type: multipart/mixed; boundary="SeKTbUyioFhKb6yGXBGhLlzIZWi9Rm3iK";
 protected-headers="v1"
From: Markus Reichl <m.reichl@fivetechno.de>
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-usb@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Minas Harutyunyan <hminas@synopsys.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Jules Maselbas <jmaselbas@kalray.eu>, Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <39c7b687-449e-5e89-4c70-527d4e779fd9@fivetechno.de>
Subject: Re: [PATCH] usb: dwc2: Force 8bit UTMI width for Samsung Exynos SoCs
References: <20190503204958.GA12532@kozik-lap>
 <CGME20190506130052eucas1p25afd4e15648e9efc6fd011e46081fbea@eucas1p2.samsung.com>
 <20190506130046.20898-1-m.szyprowski@samsung.com>
In-Reply-To: <20190506130046.20898-1-m.szyprowski@samsung.com>

--SeKTbUyioFhKb6yGXBGhLlzIZWi9Rm3iK
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Hi Marek,

your patch did not help on stable v5.1

[    3.255963] samsung-usb2-phy 125b0000.exynos-usbphy: 125b0000.exynos-u=
sbphy supply vbus not found, using dummy regulator
[    4.044547] usbcore: registered new interface driver smsc95xx
[    4.112261] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.01
[    4.120363] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    4.127560] usb usb1: Product: EHCI Host Controller
[    4.132415] usb usb1: Manufacturer: Linux 5.1.0-00005-geb4efae48eb5 eh=
ci_hcd
[    4.139446] usb usb1: SerialNumber: 12580000.ehci
[    4.183056] usb3503 0-0008: switched to HUB mode
[    4.183121] usb3503 0-0008: usb3503_probe: probed in hub mode
[    4.488344] usb 1-2: new high-speed USB device number 2 using exynos-e=
hci
[    4.675605] usb 1-2: New USB device found, idVendor=3D0424, idProduct=3D=
3503, bcdDevice=3Da1.a0
[    4.678166] usb 1-2: New USB device strings: Mfr=3D0, Product=3D0, Ser=
ialNumber=3D0
[    4.686140] usb 1-2: skipping disabled interface 0

root@odroid-x2:~# lsusb
Bus 001 Device 002: ID 0424:3503 Standard Microsystems Corp.
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub



Am 06.05.19 um 15:00 schrieb Marek Szyprowski:
> Samsung Exynos SoCs require to force UTMI width to 8bit, otherwise the
> host side of the shared USB2 PHY doesn't work.
>=20
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> Fixes: 707d80f0a3c5 ("usb: dwc2: gadget: Replace phyif with phy_utmi_wi=
dth")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/usb/dwc2/params.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
> index 6900eea57526..9ece4affb9d4 100644
> --- a/drivers/usb/dwc2/params.c
> +++ b/drivers/usb/dwc2/params.c
> @@ -76,6 +76,7 @@ static void dwc2_set_s3c6400_params(struct dwc2_hsotg=
 *hsotg)
>  	struct dwc2_core_params *p =3D &hsotg->params;
> =20
>  	p->power_down =3D 0;
> +	p->phy_utmi_width =3D 8;
>  }
> =20
>  static void dwc2_set_rk_params(struct dwc2_hsotg *hsotg)
>=20

Gru=C3=9F,
--=20
Markus Reichl


--SeKTbUyioFhKb6yGXBGhLlzIZWi9Rm3iK--

--jaQbzrRu5YUNCCshYysHQXwri4Q0c42fX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEVKeIeBh0ZWJOldzLOiXeDmsa/bIFAlzRPeYACgkQOiXeDmsa
/bJ4BAv/aFOkWeqjyJQlgtAY665B6v4yvYO7Xds4CECjPByYCSv1+0zc5MamdQGt
RcPsPqaGZ+HQ1E+3GIAsD2PtyKRst38iYr8JkYo3u/PEQXW+ZRMCQS9VNOQjcs2A
RnwEISl9BVmu/FcSRqL/7SrrTXZPF4+UwTziFu1PsCbx7pCaaLxfZF6zenTxaI3c
Lt4SofevaxV9ExdRLgvMhw/hk9FtzfAkQqWvAAYF5xreKTOlYi+xKvebIdJ66YUj
Otir2ZAEqfVxCLs1AFxvlNNLJ0IHqBNkiwJlPhP9oP9jyMymlTViGgC/Ar5LFA+O
a7BXnr+Cg7xJSHJuW13dyObnau9SDLrpk2OG+LWVXSPcfsuUpu0PwAhrSLvIjkgb
6rryONAA/JlDd463j1TkqSOG4LFk2slw6a/SM2dY9qW5CoYT4QFWtMzvRHKuy+BT
KFA9rg2mmKxP98DXi/9+/FEDL0ywrs1p1GDjH9/nsxGWB1r/P1BJIsdg/gMlbEaF
T+BPl3zG
=3jNv
-----END PGP SIGNATURE-----

--jaQbzrRu5YUNCCshYysHQXwri4Q0c42fX--
