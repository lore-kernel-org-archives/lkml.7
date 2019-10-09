Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D212ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFC9206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfJIIgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 04:36:42 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44427 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfJIIgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 04:36:41 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7E07B803A4; Wed,  9 Oct 2019 10:36:24 +0200 (CEST)
Date:   Wed, 9 Oct 2019 10:36:38 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [GIT PULL] LED fixes for 5.4-rc3.
Message-ID: <20191009083638.GB11561@amd>
References: <20191008204258.22196-1-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <20191008204258.22196-1-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-10-08 22:42:58, Jacek Anaszewski wrote:
> Hi Linus,
>=20
> Please pull two patches for 5.4-rc3:
>=20
> - fix a leftover from earlier stage of development in the documentation
>   of recently added led_compose_name() and fix old mistake in
>   the documentation of led_set_brightness_sync() parameter name.
>=20
> - MAINTAINERS: add pointer to Pavel Machek's linux-leds.git tree.
>   Pavel is going to take over LED tree maintainership
>   from myself.

Thank you!

								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2dnBYACgkQMOfwapXb+vIJpwCdFvjCMqM+6qSR98F7dsZ6QeuG
uJ8An3mu3PNnUi862Nif643M8le9E1Ot
=BT9G
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
