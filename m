Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62647C31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9EF2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560843007;
	bh=sINg772RHgD3pq4yq8o9g8pXf7nN9boKh9KcBygvuWc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=0Y5vLLS0BQ+/xlUCpOYWsu85E7iwpGCJnJqOtPMoOUP5izVc182xfEqS6W5vte16Y
	 DxWeJJT34mXOwHALdaVvWPKT/AY6YVSx7p80I79MPxB4XRu2n+NA6kJRlG/P0g5oLX
	 5Fl0yk3afecIf4aXD7AR42RusTDePh2Dp38JUE+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbfFRHaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:30:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:29366 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfFRHaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:30:05 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 00:30:04 -0700
X-ExtLoop1: 1
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jun 2019 00:30:02 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: remove redundant 'default n' from Kconfig-s
In-Reply-To: <79726177-d524-4f83-eeb2-18ae9b2e50cf@samsung.com>
References: <CGME20190520141434eucas1p266520a2ef8db42b3deee004e1cba3a1f@eucas1p2.samsung.com> <79726177-d524-4f83-eeb2-18ae9b2e50cf@samsung.com>
Date:   Tue, 18 Jun 2019 10:29:58 +0300
Message-ID: <874l4ngxl5.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> writes:

> 'default n' is the default value for any bool or tristate Kconfig
> setting so there is no need to write it explicitly.
>
> Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
> is not set' for visible symbols") the Kconfig behavior is the same
> regardless of 'default n' being present or not:
>
>     ...
>     One side effect of (and the main motivation for) this change is making
>     the following two definitions behave exactly the same:
>=20=20=20=20=20
>         config FOO
>                 bool
>=20=20=20=20=20
>         config FOO
>                 bool
>                 default n
>=20=20=20=20=20
>     With this change, neither of these will generate a
>     '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
>     That might make it clearer to people that a bare 'default n' is
>     redundant.
>     ...
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Fine by me. Greg if you want to take this directly (since it touches
things all over the place):

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

If you prefer that I put this in my pull request to you, just let me know.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl0IkvYACgkQzL64meEa
mQa9mg//fdocqbcV3m9oWbkA2fqyPAEbOt+BZPMT5I6NG+7692hoKu4777C6/vDG
/vlng8aPFT1OoqXZxDoJK62yD3f/LOI1ELHfJTObMQmRlhUoyRnZMoRJ7CNtgA3W
DawFYmeHQRBZB6HXsdBCrEF+aNNQ/7cF6e9dnq9dbQwuhToePn3IYCmIO1cWr5eM
i+VjKDjQvB1+CDzCDeXx/eK2cVkTNn8FdzOmP7jjRpybHP3Lgz9T386zUJLiOz8V
rBKzE0/NAeOVQvEk0pROZm/Walm+YDIaTYJlQkGagYgYWvfDBxVKp4qmiqpmC3j0
Wtv8DV+kqcp6w7oe3aMte5ssSyiR6xuUXQ39NECC+C+Zoip6sh7byKcNlEljg88M
YlOJ1rZr99eic1hKxuOqZon0Erj+/bGiEXikmaKI8W4EdY8/NLvKVl0XF2eRDVd6
RBwf3glSPd2iRWHEQYwJDvmwVEi8b6alpXojXsZbunftmUz4b+cizUVKM8fw/6ce
QRB3LZsHR/V8504UWx+l8Uq1jbrNjTwpJp1oLaW3ZweCMMHjFR2Dy351CD5vOy0U
djvW+wjq3BTXqNnQNWVOpyrass4ynPOlBHHN5WnEDrXmVY8q3+tChPeNSDpNVCBg
bbIqYUq4zzYy1QdzqqAKNGvyhWxE4iS8X9OfAcC5h8ae0xnYvtI=
=L/+a
-----END PGP SIGNATURE-----
--=-=-=--
