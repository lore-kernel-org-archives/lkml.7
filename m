Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D33CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2666E2245B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfKDJJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 04:09:34 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:33234 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKDJJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 04:09:33 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2499B1C06CB; Mon,  4 Nov 2019 10:09:32 +0100 (CET)
Date:   Mon, 4 Nov 2019 10:09:31 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] leds: an30259a: add a check for devm_regmap_init_i2c
Message-ID: <20191104090931.GE12355@duo.ucw.cz>
References: <20191016125403.23359-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="o0ZfoUVt4BxPQnbU"
Content-Disposition: inline
In-Reply-To: <20191016125403.23359-1-hslester96@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o0ZfoUVt4BxPQnbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-10-16 20:54:03, Chuhong Yuan wrote:
> an30259a_probe misses a check for devm_regmap_init_i2c and may cause
> problems.
> Add a check and print errors like other leds drivers.
>=20
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Thanks, applied.
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--o0ZfoUVt4BxPQnbU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXb/qywAKCRAw5/Bqldv6
8tyGAJ4wfMBKXkzwGdXU7+D4hoK47ixpAACfeJnc9IYTirdXFtkbOW1XSHhfBbs=
=DAiz
-----END PGP SIGNATURE-----

--o0ZfoUVt4BxPQnbU--
