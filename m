Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663A2C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A32A2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbfEWI54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 04:57:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53490 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfEWI5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 04:57:55 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C9F058032F; Thu, 23 May 2019 10:57:42 +0200 (CEST)
Date:   Thu, 23 May 2019 10:57:52 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Subject: Re: 5.1.0-next-20190520 -- emacs segfaults on 32-bit machine Re:
 5.2-rc0.8: emacs segfaults?! x220, with 32-bit userland
Message-ID: <20190523085752.GA2241@amd>
References: <20190519221700.GA7154@amd>
 <20190520160636.z6fpjiidc2d5ko5g@linutronix.de>
 <20190520231342.GA20835@amd>
 <20190521073240.mikv2ufwyriy4q7r@linutronix.de>
 <20190522183329.GB10003@amd>
 <20190523083724.GA21185@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20190523083724.GA21185@amd>
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

> > I did not notice any new crashes.
>=20
> New crash now; different machine, way -next kernel... and I even have
> a backtrace.

And one more crash, on x220:

pavel@duo:/data/l/linux-next-32$ uname -a
Linux duo 5.2.0-rc1+ #32 SMP Mon May 20 12:51:17 CEST 2019 x86_64
GNU/Linux
pavel@duo:~$ fg
e cip/HOURS
Fatal error 11: Segmentation fault
Backtrace:
emacs[0x8138719]
emacs[0x8120446]
emacs[0x813758e]
emacs[0x81375fb]
/lib/i386-linux-gnu/i686/cmov/libpthread.so.0(+0xecb8)[0xf634fcb8]
/lib/i386-linux-gnu/i686/cmov/libc.so.6(+0xebbf3)[0xf6266bf3]
/lib/i386-linux-gnu/i686/cmov/libc.so.6(pselect+0xd3)[0xf625f363]
emacs[0x81ffdd9]
emacs[0x81c7ba4]
emacs[0x8127815]
emacs[0x812ada3]
emacs[0x812bdad]
emacs[0x812d838]
emacs[0x818b76c]
emacs[0x8120890]
emacs[0x818b66b]
emacs[0x8124b84]
emacs[0x8124e3f]
emacs[0x8059cb0]
/lib/i386-linux-gnu/i686/cmov/libc.so.6(__libc_start_main+0xf3)[0xf6194a63]
emacs[0x805a76f]
^P/data/pavel/bin/e: line 2: 12713 Segmentation fault      (core
dumped) emacs -nw $*
pavel@duo:~$ fg

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

iEYEARECAAYFAlzmYJAACgkQMOfwapXb+vK9SACeOdCFnzVjgh1CaVG93OCWopYI
5K0AnjkUQVkOcJzugH9mldVuCNtclTvz
=Yeyj
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
