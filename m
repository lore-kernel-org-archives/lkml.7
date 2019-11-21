Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA162C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E5020898
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfKUHuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 02:50:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:42132 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725842AbfKUHuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 02:50:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C0303B270;
        Thu, 21 Nov 2019 07:50:22 +0000 (UTC)
Subject: Re: [PATCH] drm/mgag200: Fix Kconfig indentation
To:     Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Dave Airlie <airlied@redhat.com>,
        dri-devel@lists.freedesktop.org
References: <20191120133625.11478-1-krzk@kernel.org>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 mQENBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAG0J1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPokBVAQTAQgAPhYh
 BHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJbOdLgAhsDBQkDwmcABQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAAAoJEGgNwR1TC3ojR80H/jH+vYavwQ+TvO8ksXL9JQWc3IFSiGpuSVXLCdg62AmR
 irxW+qCwNncNQyb9rd30gzdectSkPWL3KSqEResBe24IbA5/jSkPweJasgXtfhuyoeCJ6PXo
 clQQGKIoFIAEv1s8l0ggPZswvCinegl1diyJXUXmdEJRTWYAtxn/atut1o6Giv6D2qmYbXN7
 mneMC5MzlLaJKUtoH7U/IjVw1sx2qtxAZGKVm4RZxPnMCp9E1MAr5t4dP5gJCIiqsdrVqI6i
 KupZstMxstPU//azmz7ZWWxT0JzgJqZSvPYx/SATeexTYBP47YFyri4jnsty2ErS91E6H8os
 Bv6pnSn7eAq5AQ0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRH
 UE9eosYbT6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgT
 RjP+qbU63Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+R
 dhgATnWWGKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zb
 ehDda8lvhFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r
 12+lqdsAEQEAAYkBPAQYAQgAJhYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJbOdLgAhsMBQkD
 wmcAAAoJEGgNwR1TC3ojpfcIAInwP5OlcEKokTnHCiDTz4Ony4GnHRP2fXATQZCKxmu4AJY2
 h9ifw9Nf2TjCZ6AMvC3thAN0rFDj55N9l4s1CpaDo4J+0fkrHuyNacnT206CeJV1E7NYntxU
 n+LSiRrOdywn6erjxRi9EYTVLCHcDhBEjKmFZfg4AM4GZMWX1lg0+eHbd5oL1as28WvvI/uI
 aMyV8RbyXot1r/8QLlWldU3NrTF5p7TMU2y3ZH2mf5suSKHAMtbE4jKJ8ZHFOo3GhLgjVrBW
 HE9JXO08xKkgD+w6v83+nomsEuf6C6LYrqY/tsZvyEX6zN8CtirPdPWu/VXNRYAl/lat7lSI
 3H26qrE=
Message-ID: <3ae84d5d-a50c-8772-4088-868fc8a6ed8b@suse.de>
Date:   Thu, 21 Nov 2019 08:50:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191120133625.11478-1-krzk@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="p2L1lQQ6oq7m4AD5N54b9Al1ZDXIphrzL"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p2L1lQQ6oq7m4AD5N54b9Al1ZDXIphrzL
Content-Type: multipart/mixed; boundary="EJGRMvCdgKmGCMh4YYBZbxspFyJifmuc4";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Cc: David Airlie <airlied@linux.ie>, Dave Airlie <airlied@redhat.com>,
 dri-devel@lists.freedesktop.org
Message-ID: <3ae84d5d-a50c-8772-4088-868fc8a6ed8b@suse.de>
Subject: Re: [PATCH] drm/mgag200: Fix Kconfig indentation
References: <20191120133625.11478-1-krzk@kernel.org>
In-Reply-To: <20191120133625.11478-1-krzk@kernel.org>

--EJGRMvCdgKmGCMh4YYBZbxspFyJifmuc4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 20.11.19 um 14:36 schrieb Krzysztof Kozlowski:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>  drivers/gpu/drm/mgag200/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/mgag200/Kconfig b/drivers/gpu/drm/mgag200/=
Kconfig
> index aed11f4f4c55..d60aa4b9ccd4 100644
> --- a/drivers/gpu/drm/mgag200/Kconfig
> +++ b/drivers/gpu/drm/mgag200/Kconfig
> @@ -8,8 +8,8 @@ config DRM_MGAG200
>  	select DRM_TTM_HELPER
>  	help
>  	 This is a KMS driver for the MGA G200 server chips, it
> -         does not support the original MGA G200 or any of the desktop
> -         chips. It requires 0.3.0 of the modesetting userspace driver,=

> -         and a version of mga driver that will fail on KMS enabled
> -         devices.
> +	 does not support the original MGA G200 or any of the desktop
> +	 chips. It requires 0.3.0 of the modesetting userspace driver,
> +	 and a version of mga driver that will fail on KMS enabled
> +	 devices.
> =20
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--EJGRMvCdgKmGCMh4YYBZbxspFyJifmuc4--

--p2L1lQQ6oq7m4AD5N54b9Al1ZDXIphrzL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl3WQb0ACgkQaA3BHVML
eiMPcQgAwc4ueoZsjOBGHYYTR92f4owRjn0JV6b1IHgoYAaUbv7kCZtbRYibmHJO
8vgH56rEYhIi0u12X1nJ3M4pVhSzNSNKeZ0Pughhn+G69w8qkqUbvbXVIjuV4YJ6
F3BCOVpOyelI7yIdKRb0om+3EqnQVKkMrvOKL5XzAbo/3eAuqRk4Owv00YUqdhT2
caKaYPd7d/s/ZTrEES6AwDMrUsjoz8OfBunFYu9RdyeIs+a0X5PFt4hc+XtS7BuY
zF5TRLsel6xPFTaMYqoxeRdYmQ5I4HP0+S2vZJvY2KYmeVr8U4M9JA8HkTv+f5FI
OUUhCgNtX+qe+hq2Pa+w3jN2bZDDZw==
=DX5L
-----END PGP SIGNATURE-----

--p2L1lQQ6oq7m4AD5N54b9Al1ZDXIphrzL--
