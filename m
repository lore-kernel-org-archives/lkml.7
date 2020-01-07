Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A74C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB792072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgAGUoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:44:15 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:58170 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgAGUoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:44:15 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 902F21C2597; Tue,  7 Jan 2020 21:44:13 +0100 (CET)
Date:   Tue, 7 Jan 2020 21:44:12 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: OOM killer not nearly agressive enough?
Message-ID: <20200107204412.GA29562@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I updated my userspace to x86-64, and now chromium likes to eat all
the memory and bring the system to standstill.

Unfortunately, OOM killer does not react:

I'm now running "ps aux", and it prints one line every 20 seconds or
more. Do we agree that is "unusable" system? I attempted to do kill
=66rom other session.

Do we agree that OOM killer should have reacted way sooner?

Is there something I can tweak to make it behave more reasonably?

Best regards,
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

iEYEARECAAYFAl4U7ZwACgkQMOfwapXb+vJItgCgomm9fd1Ox5Tq38bSgamMSUzI
pnoAoKnPsJvjVAIfinjbm6ZSm2QYaGUe
=Uklt
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
