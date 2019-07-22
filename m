Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201A3C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0422120665
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfGVM0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:26:21 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43692 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfGVM0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:26:21 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3A3328034D; Mon, 22 Jul 2019 14:26:08 +0200 (CEST)
Date:   Mon, 22 Jul 2019 14:26:17 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, jacek.anaszewski@gmail.com,
        dmurphy@ti.com, linux-leds@vger.kernel.org
Subject: Re: [PATCH v2] leds: apu: fix error message on probing failure
Message-ID: <20190722122617.GB12069@amd>
References: <f54bb3f1-2699-1213-f568-b2c529488306@gmail.com>
 <1563797331-20993-1-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <1563797331-20993-1-git-send-email-info@metux.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-07-22 14:08:51, Enrico Weigelt, metux IT consult wrote:
> From: Enrico Weigelt <info@metux.net>
>=20
> The current error message on failed probing tends to be a bit
> misleading. Fix it to tell exactly that an APU v1 was not found.
>=20
> Signed-off-by: Enrico Weigelt <info@metux.net>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl01q2kACgkQMOfwapXb+vJUCwCfd48hXYfazmUEgv6Kxz5IaWBM
Fo4AoKbRA/qApIJ5y1VubAMfRN40LgVl
=7D1n
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
