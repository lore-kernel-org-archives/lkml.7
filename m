Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7512BC282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40064217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IB9F9lxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbfDXBND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 21:13:03 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46403 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfDXBNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 21:13:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44pj3w0Q3Fz9sCJ;
        Wed, 24 Apr 2019 11:13:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556068380;
        bh=nP3tNuACXafB8H4LtH9iWPfpFVpRkV7g7WSgCV2Og4Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IB9F9lxgjtqx60i1TVz5d2d2Y96+qlUwk6xsEMG888ifTeXUyvSymVpZI2sYZDF3N
         4VQ9SA9BKjCsnXqoeiFcUwZ6eJwFpPEZNHqBz83cff5ZxXLEEzjx/9U+JBtcLfN5bX
         MfOmsjAHKysoqpGviZA5tRAu0ejT6fpnJlRDTcCRCoaNd2QgH4QBGmTu6iTlCDEp6R
         QkPmGuZB+CxIrZvgkHWtZo14m5A8/+VbvTPr+UDi8dH2ou9Z9NjSrOEsq7dtotr8OY
         u34DQYmrlhR1IW1w1Loqo9jiFuY5NcOLk/nGshLVQkYQF32Priq1iLw0tBl/KhexN9
         ASwY+VtzMtuVg==
Date:   Wed, 24 Apr 2019 11:12:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Deepak Singh Rawat <drawat@vmware.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>
Subject: Re: linux-next: Signed-off-by missing for commit in the drm tree
Message-ID: <20190424111259.6a1aacce@canb.auug.org.au>
In-Reply-To: <44707352378dcd414b476ec5420db23093fb9351.camel@vmware.com>
References: <20190424102219.48cfdfe2@canb.auug.org.au>
        <44707352378dcd414b476ec5420db23093fb9351.camel@vmware.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6b1gFu/lYiX1QCar6=F2ByB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6b1gFu/lYiX1QCar6=F2ByB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Deepak,

On Wed, 24 Apr 2019 00:36:19 +0000 Deepak Singh Rawat <drawat@vmware.com> w=
rote:
>
> On Wed, 2019-04-24 at 10:22 +1000, Stephen Rothwell wrote:
> >=20
> > Commit
> >=20
> >   a9f58c456e9d ("drm/vmwgfx: Be more restrictive when dirtying
> > resources") =20
>=20
> Actully the Signed-off-by: is not missing see=20
>=20
> https://cgit.freedesktop.org/drm/drm/commit/drivers/gpu/drm/vmwgfx?id=3Da=
9f58c456e9dde6f272e7be4d6bed607fd7008aa

There is no Signed-off-by from you as the committer (just a
Reviewed-by from you and a Signed-off-by from the author).

> By the way there is the patter "---" before Signed-off-by:(which is
> same as used by patch to separate description from code) and I think
> the script is reading only till that point. I think "---" should not be
> used in patch description.

All the tags should be *before* the "-- " or "---" separator.

--=20
Cheers,
Stephen Rothwell

--Sig_/6b1gFu/lYiX1QCar6=F2ByB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly/uBsACgkQAVBC80lX
0GxDLAf/cPG8X8WpOjB/jK8g1cMjxYCtJ1iyRRus2SGyZxijfpkhJMOKqUwLgBtR
YdahlejMFa2aVV9gyh3Xt17N1sDKUzXEfAGfVqd5WHwcLAihWQZuqdl1rN8Vzwer
AfNsvpj+kcO2hoPtHaSDcBnDcaPTS7bir0QMEXJanki/ImuHMgnuKG5S+NHiWzla
g2alLOuImU4qLKCtHsoY2vVKaHyalJpdjwQjLYAiErDbTDskZCzdrvDDbyqcUlKO
g+GPhAIH7dWh+7E7+PNUbNy/GHpkv0dM+OPQOaBrvl21zDOUwo7K1NxjeRh2XtIQ
d54TlWTRTQipsyOF7sonsM5b0VBwtg==
=FWCF
-----END PGP SIGNATURE-----

--Sig_/6b1gFu/lYiX1QCar6=F2ByB--
