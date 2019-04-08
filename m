Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73964C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5131320879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbfDHRjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:39:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41622 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728920AbfDHRja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 13:39:30 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7D0E6803C9; Mon,  8 Apr 2019 19:39:20 +0200 (CEST)
Date:   Mon, 8 Apr 2019 19:39:28 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org
Subject: next-20190408: Suspend/resume problems on Thinkpad X60
Message-ID: <20190408173928.GB13260@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

It boots ok (unlike mainline -- I'm debugging that), and I can suspend
and resume... but then cursor in X is moving and I can talk to
applications cached in memory, but any access to disk hangs.

Any ideas?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyrh1AACgkQMOfwapXb+vK9kgCfWu7Sxwj52spkyQk5yiLtavag
Q4gAnju8ZnFVdGD6sMbXC4fzN8nOeLxl
=C0vm
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
