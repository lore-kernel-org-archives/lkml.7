Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2391C31E40
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 18:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A813A2064A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 18:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfGMSyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 14:54:53 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37568 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbfGMSyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 14:54:53 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 4758280478; Sat, 13 Jul 2019 20:54:40 +0200 (CEST)
Date:   Sat, 13 Jul 2019 20:54:50 +0200
From:   Pavel Machek <pavel@denx.de>
To:     kernel list <linux-kernel@vger.kernel.org>, dzu@member.fsf.org,
        simon.k.r.goldschmidt@gmail.com, dinguyen@kernel.org,
        s.trumtrar@pengutronix.de, marex@denx.de, stefan@agner.ch
Subject: USB on EBV Socrates
Message-ID: <20190713185450.GA2877@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

(First, I'd like to thank Detlev for fpgasoc-quickstart, it made
getting Socrates to run way easier. I used some older version... so I
had to delete your public key from it. If there's more than one, I'd
like to know :-) ).

Now, I'd like to get USB host to work; I don't have cable with right
pullups, so host-only would be nice, but I noticed USB is not enabled
at all in arch/arm/boot/dts/socfpga_cyclone5_socrates.dts . I tried
enabling it but could not get it to work. Perhaps someone knows what
is going on there?

Thanks,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0qKPoACgkQMOfwapXb+vJjdgCgwWmUWNr1GJLVw8/b6Lja+40J
UowAmQFrnvf9zradQj4FcDTf6qsrI20f
=Bohi
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
