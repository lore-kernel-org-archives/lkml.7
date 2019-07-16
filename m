Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222BEC76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FDB2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388634AbfGPT2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 15:28:22 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47317 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGPT2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 15:28:22 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 2A4A980593; Tue, 16 Jul 2019 21:28:09 +0200 (CEST)
Date:   Tue, 16 Jul 2019 21:28:19 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, jacek.anaszewski@gmail.com,
        dmurphy@ti.com, linux-leds@vger.kernel.org
Subject: Re: [PATCH 6/6] leds: apu: add pr_fmt prefix for better log output
Message-ID: <20190716192819.GF10400@amd>
References: <1563202653-20994-1-git-send-email-info@metux.net>
 <1563202653-20994-7-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NGIwU0kFl1Z1A3An"
Content-Disposition: inline
In-Reply-To: <1563202653-20994-7-git-send-email-info@metux.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NGIwU0kFl1Z1A3An
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-07-15 16:57:33, Enrico Weigelt, metux IT consult wrote:
> From: Enrico Weigelt <info@metux.net>
>=20
> Define pr_fmt() macro for prefixing the module name to all
> pr_*() outputs, in order to increase log message clarity.
>=20
> Signed-off-by: Enrico Weigelt <info@metux.net>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--NGIwU0kFl1Z1A3An
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0uJVMACgkQMOfwapXb+vLC6gCff1sHEerkaxnaRpzpJyUhjTQ6
PVwAnA1ISMTcSCdo3IKCu3ww2qgYVAC9
=xwfR
-----END PGP SIGNATURE-----

--NGIwU0kFl1Z1A3An--
