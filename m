Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72315C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5354322CE3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbfHTQ3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 12:29:37 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46122 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfHTQ3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:29:36 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id F1D0780FA6; Tue, 20 Aug 2019 18:29:21 +0200 (CEST)
Date:   Tue, 20 Aug 2019 18:29:34 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] leds: lm3532: Add full scale current configuration
Message-ID: <20190820162934.GA5701@amd>
References: <20190813181154.6614-1-dmurphy@ti.com>
 <20190813181154.6614-4-dmurphy@ti.com>
 <20190819105519.GG21072@amd>
 <1f4efd9f-8234-161a-2c05-c5bae2720207@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <1f4efd9f-8234-161a-2c05-c5bae2720207@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >No need to move ctrl_brt_pointer... to keep order consistent with docs.
>=20
> OK I will reset the patches and get rid of that change.=A0 I think this g=
ot
> moved when I applied the v1 patch.
>=20
>=20
> >>+		fs_current_val =3D led->full_scale_current - LM3532_FS_CURR_MIN /
> >>+				 LM3532_FS_CURR_STEP;
> >The computation is wrong ... needs () AFAICT.
>=20
> Hmm. Doesn't order of operations take precedence?
>=20
> I will add the () unless checkpatch cribs about them

I may be misunderstanding. What do you expect the computation to be? /
has higher priority than -, right? Can you test it provides expected
results?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1cH+4ACgkQMOfwapXb+vL6RQCfU8T+KYM+1XYLfvUyh27rNA/y
FAIAnAgDMashbaY8C+5MnAgnmnCmELXl
=VN1z
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
