Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3429C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4FA21738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfDWKWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:22:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53981 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDWKWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:22:43 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B17A98063C; Tue, 23 Apr 2019 12:22:31 +0200 (CEST)
Date:   Tue, 23 Apr 2019 12:22:40 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, hdegoede@redhat.com, axboe@kernel.dk,
        linux-ide@vger.kernel.org
Subject: next-20190408..0418: Suspend/resume problems on Thinkpad X60
Message-ID: <20190423102239.GA15531@amd>
References: <20190408173928.GB13260@amd>
 <20190412102812.GA24977@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20190412102812.GA24977@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > It boots ok (unlike mainline -- I'm debugging that), and I can suspend
> > and resume... but then cursor in X is moving and I can talk to
> > applications cached in memory, but any access to disk hangs.
>=20
> Mainline problem was identified.
>=20
> But resume is still broken. I took advantage of fact that I can still
> do cached commands, and got complete dmesg. I'm attaching it.

Still broken in 0418. Ideas would be welcome at this point.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAly+528ACgkQMOfwapXb+vJUIQCfdlG+O8D9R0SH0VcyH9uQ1lq9
WQsAoJsscMPfrfcXZTCqYo29RRWKli+K
=Z66R
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
