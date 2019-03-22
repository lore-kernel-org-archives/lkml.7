Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C61FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE78C20850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfCVKfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:35:06 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37120 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfCVKfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:35:06 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C099980510; Fri, 22 Mar 2019 11:34:56 +0100 (CET)
Date:   Fri, 22 Mar 2019 11:35:03 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        syzbot <syzbot+b70f2aabc707c69c9239@syzkaller.appspotmail.com>,
        chanho.min@lge.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: WARNING: syz-executor still has locks held!
Message-ID: <20190322103503.GA8681@amd>
References: <0000000000000e4a41057b6c9792@google.com>
 <0000000000004cdec6058485b2ce@google.com>
 <20190320131655.GA8696@dhcp22.suse.cz>
 <20190320132410.GB21673@redhat.com>
 <20190320132936.GB8696@dhcp22.suse.cz>
 <20190320150053.GD21673@redhat.com>
 <20190320151242.GC8696@dhcp22.suse.cz>
 <20190320173041.GE21673@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <20190320173041.GE21673@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > as removing the cgred is way way too complicated.
> > >
> > > We need to do this anyway, this leads to other more serious problems.=
=2E.
> >
> > Yes but this is far away and it doesn't really seem like a stable tree
> > material
>=20
> strace -f can hang ;) so this is the stable material.

Stable is only for obvious fixes... and this looks to be far from
simple/obvious.

And yes, strace -f is a bug, but ... not really sufficiently serious one.
								=09
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyUulcACgkQMOfwapXb+vIlpQCeKtW8R8TyYD6wuX7KAp17UNyS
hKkAn1dmOlE6B7jeCXpdlfwPS5ZwDEuG
=Kv2h
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
