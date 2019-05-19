Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8713C04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 22:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B73320578
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 22:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfESWRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 18:17:03 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60858 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfESWRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 18:17:03 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9C5A4802EE; Mon, 20 May 2019 00:16:51 +0200 (CEST)
Date:   Mon, 20 May 2019 00:17:01 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Subject: 5.2-rc0.8: emacs segfaults?! x220, with 32-bit userland
Message-ID: <20190519221700.GA7154@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

emacs segfaults... when I attempt to exit it. And that did not use to
be the case. Nothing suspect in the dmesg. Rest of the machine seems
to work ok.

I'm using "l1tf=3Dfull" on kernel command line.

During one crash, I got some kind of debug output (from glibc?), but
it scrolled away when I asked for dmesg :-(.

Ideas welcome...
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzh1dwACgkQMOfwapXb+vLx8wCfR8A7RIJwo6KDHY/dAKuFerdQ
IEgAnRtr988aB8dQbyKs57xaKsnV0097
=rlYq
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
