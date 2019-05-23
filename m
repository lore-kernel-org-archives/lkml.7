Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE3DC04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F210C20881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbfEWIh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 04:37:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52835 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfEWIh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 04:37:26 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1022A8026C; Thu, 23 May 2019 10:37:14 +0200 (CEST)
Date:   Thu, 23 May 2019 10:37:24 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Subject: 5.1.0-next-20190520 -- emacs segfaults on 32-bit machine Re:
 5.2-rc0.8: emacs segfaults?! x220, with 32-bit userland
Message-ID: <20190523083724.GA21185@amd>
References: <20190519221700.GA7154@amd>
 <20190520160636.z6fpjiidc2d5ko5g@linutronix.de>
 <20190520231342.GA20835@amd>
 <20190521073240.mikv2ufwyriy4q7r@linutronix.de>
 <20190522183329.GB10003@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <20190522183329.GB10003@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I did not notice any new crashes.

New crash now; different machine, way -next kernel... and I even have
a backtrace.

								Pavel

pavel@amd:~$ e cip/HOURS
Fatal error 11: Segmentation fault
Backtrace:
emacs[0x8138719]
emacs[0x8120446]
emacs[0x813758e]
emacs[0x81375fb]
/lib/i386-linux-gnu/i686/cmov/libpthread.so.0(+0xecb8)[0xb636ccb8]
/lib/i386-linux-gnu/i686/cmov/libc.so.6(+0xebbf3)[0xb6283bf3]
/lib/i386-linux-gnu/i686/cmov/libc.so.6(pselect+0xd3)[0xb627c363]
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
/lib/i386-linux-gnu/i686/cmov/libc.so.6(__libc_start_main+0xf3)[0xb61b1a63]
emacs[0x805a76f]
^CSegmentation fault (core dumped)
pavel@amd:~$ uname -a
Linux amd 5.1.0-next-20190520 #285 SMP Mon May 20 13:20:20 CEST 2019
i686 GNU/Linux
pavel@amd:~$ dmesg | grep fpu
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
"Genuine Intel(R) CPU           T2400  @ 1.83GHz"


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzmW8QACgkQMOfwapXb+vIKHACeMax3ol/Lt6Gf9KxytTAlIA29
+18An150AL20CBY9DdGxQpIK1lMMSKqR
=y+0N
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
