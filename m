Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2003C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E3B20828
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfF0H6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:58:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:41400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbfF0H57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:57:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 84075AF46;
        Thu, 27 Jun 2019 07:57:57 +0000 (UTC)
Subject: Re: [PATCH][next] drm/mgag200: add in missing { } around if block
To:     Colin King <colin.king@canonical.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190614143911.21806-1-colin.king@canonical.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNKFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmNvbT7CwJQEEwEIAD4W
 IQRyF/usjOnPY0ShaOVoDcEdUwt6IwUCWznTtgIbAwUJA8JnAAULCQgHAgYVCgkICwIEFgID
 AQIeAQIXgAAKCRBoDcEdUwt6I7D7CACBK42XW+7mCiK8ioXMEy1NzGbXC51RzGea8N83oEJS
 1KVUtQxrkDxgrW/WLSl/TfqHFsJpdEFOv1XubWbleun3uKPy0e5vZCd5UjZPkeNjnqfCYTDy
 hVVsdOuFbtWDppJyJrThLqr9AgSFmoCNNUt1SVpYEEOLNE6C32BhlnSq21VLC+YXTgO/ZHTa
 YXkq54hHj63jwrcjkBSCkXLh37kHeqnl++GHpN+3R+o3w2OpwHAlvVjdKPT27v1tVkiydsFG
 65Vd0n3m/ft+IOrGgxQM1C20uqKvsZGB4r3OGR50ekAybO7sjEJJ1Obl4ge/6RRqcvKz4LMb
 tGs85D6tPIeFzsBNBFs50uABCADGJj+DP1fk+UWOWrf4O61HTbC4Vr9QD2K4fUUHnzg2B6zU
 R1BPXqLGG0+lzK8kfYU/F5RjmEcClsIkAaFkg4kzKP14tvY1J5+AV3yNqcdg018HNtiyrSwI
 E0Yz/qm1Ot2NMZ0DdvVBg22IMsiudQ1tx9CH9mtyTbIXgACvl3PW2o9CxiHPE/bohFhwZwh/
 kXYYAE51lhinQ3oFEeQZA3w4OTvxSEspiQR8dg8qJJb+YOAc5IKk6sJmmM7JfFMWSr22satM
 23oQ3WvJb4RV6HTRTAIEyyZS7g2DhiytgMG60t0qdABG5KXSQW+OKlZRpuWwKWaLh3if/p/u
 69dvpanbABEBAAHCwHwEGAEIACYWIQRyF/usjOnPY0ShaOVoDcEdUwt6IwUCWznS4AIbDAUJ
 A8JnAAAKCRBoDcEdUwt6I6X3CACJ8D+TpXBCqJE5xwog08+Dp8uBpx0T9n1wE0GQisZruACW
 NofYn8PTX9k4wmegDLwt7YQDdKxQ4+eTfZeLNQqWg6OCftH5Kx7sjWnJ09tOgniVdROzWJ7c
 VJ/i0okazncsJ+nq48UYvRGE1Swh3A4QRIyphWX4OADOBmTFl9ZYNPnh23eaC9WrNvFr7yP7
 iGjMlfEW8l6Lda//EC5VpXVNza0xeae0zFNst2R9pn+bLkihwDLWxOIyifGRxTqNxoS4I1aw
 VhxPSVztPMSpIA/sOr/N/p6JrBLn+gui2K6mP7bGb8hF+szfArYqz3T1rv1VzUWAJf5Wre5U
 iNx9uqqx
Message-ID: <23172c52-424f-747a-fa2d-117772759345@suse.de>
Date:   Thu, 27 Jun 2019 09:57:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190614143911.21806-1-colin.king@canonical.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GMMH86bexZKtIQ8AtxPJFk9BipeWf1o9o"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GMMH86bexZKtIQ8AtxPJFk9BipeWf1o9o
Content-Type: multipart/mixed; boundary="Zi3yHoGxLgC1dPVV2ZmECEj3hqC0qHWVb";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Colin King <colin.king@canonical.com>, Dave Airlie <airlied@redhat.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <23172c52-424f-747a-fa2d-117772759345@suse.de>
Subject: Re: [PATCH][next] drm/mgag200: add in missing { } around if block
References: <20190614143911.21806-1-colin.king@canonical.com>
In-Reply-To: <20190614143911.21806-1-colin.king@canonical.com>

--Zi3yHoGxLgC1dPVV2ZmECEj3hqC0qHWVb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

The code still used to work because mgag200 and userspace switch to a
software cursor if the HW cursor is not available. Thank you for fixing
this bug.

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

Am 14.06.19 um 16:39 schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> There is an if block that is missing the { } curly brackets. Add
> these in.
>=20
> Addresses-Coverity: ("Structurally dead code")
> Fixes: 94dc57b10399 ("drm/mgag200: Rewrite cursor handling")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/mgag200/mgag200_cursor.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/mgag200/mgag200_cursor.c b/drivers/gpu/drm=
/mgag200/mgag200_cursor.c
> index f0c61a92351c..117eaedec7aa 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_cursor.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_cursor.c
> @@ -99,10 +99,11 @@ int mga_crtc_cursor_set(struct drm_crtc *crtc,
> =20
>  	/* Pin and map up-coming buffer to write colour indices */
>  	ret =3D drm_gem_vram_pin(pixels_next, 0);
> -	if (ret)
> +	if (ret) {
>  		dev_err(&dev->pdev->dev,
>  			"failed to pin cursor buffer: %d\n", ret);
>  		goto err_drm_gem_vram_kunmap_src;
> +	}
>  	dst =3D drm_gem_vram_kmap(pixels_next, true, NULL);
>  	if (IS_ERR(dst)) {
>  		ret =3D PTR_ERR(dst);
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--Zi3yHoGxLgC1dPVV2ZmECEj3hqC0qHWVb--

--GMMH86bexZKtIQ8AtxPJFk9BipeWf1o9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl0UdwMACgkQaA3BHVML
eiOSLwf/a25IYHnoB4UAQsiNGDE1rr7BxI7lFDeTm9EOR5//0qkYdxov8KisuA2Y
w111Trf+aFo2nurCKVfidDfrtTjLpz9/KOQDctmzQlFGGzXsHQf+bAA0Q1ZrJaJH
J9bJCVXUWCVh4LLaoaB7fA+XHscjXgzSpQxJ/pbRA9e1r18LFQEa+5KqQ/Bvvafn
vMubMLLNiBY1wz4nTU0GlnOgmLgcOK1GobBRZwkMVgE7CjSc46ZcKy2rLxjzTe7p
nrfE0g7eE2YfKhy9npTllokI/mOb4ydJt6Wr3WLhvaxfOMxDrwYOhdT3CS1jjkuu
NxuypRhJOl0GVMv1Y5DOvXroedOexA==
=wTRU
-----END PGP SIGNATURE-----

--GMMH86bexZKtIQ8AtxPJFk9BipeWf1o9o--
