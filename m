Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD0FC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278F0208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfE0NDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:03:21 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55150 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfE0NDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:03:20 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D7C4B8049B; Mon, 27 May 2019 15:03:07 +0200 (CEST)
Date:   Mon, 27 May 2019 15:03:17 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Subject: Re: 5.1.0-next-20190520 -- emacs segfaults on 32-bit machine Re:
 5.2-rc0.8: emacs segfaults?! x220, with 32-bit userland
Message-ID: <20190527130317.GB19795@amd>
References: <20190519221700.GA7154@amd>
 <20190520160636.z6fpjiidc2d5ko5g@linutronix.de>
 <20190520231342.GA20835@amd>
 <20190521073240.mikv2ufwyriy4q7r@linutronix.de>
 <20190522183329.GB10003@amd>
 <20190523083724.GA21185@amd>
 <20190523145035.wncfmwem57z2oxb7@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline
In-Reply-To: <20190523145035.wncfmwem57z2oxb7@linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-05-23 16:50:36, Sebastian Andrzej Siewior wrote:
> On 2019-05-23 10:37:24 [+0200], Pavel Machek wrote:
> > Hi!
> Hi,
>=20
> > > I did not notice any new crashes.
> >=20
> > New crash now; different machine, way -next kernel... and I even have
> > a backtrace.
>=20
> could you please send me (offlist) your .config? Also, what kind of
> userland do you run? Something like Debian stable?

Yep, debian stable.

cat /etc/debian_version
8.11

And now it happened again, and yes, emacs again:

emacs: ../../../../src/cairo-arc.c:189: _cairo_arc_in_direction:
Assertion `angle_max >=3D angle_min' failed.
Fatal error 6: Aborted
Backtrace:
emacs[0x8138719]
emacs[0x8120446]
emacs[0x813758e]
emacs[0x81375fb]
/lib/i386-linux-gnu/i686/cmov/libpthread.so.0(+0xecb8)[0xf636ccb8]
/lib/ld-linux.so.2(+0xc42)[0xf7f49c42]
/lib/i386-linux-gnu/i686/cmov/libc.so.6(gsignal+0x47)[0xf61c6367]
/lib/i386-linux-gnu/i686/cmov/libc.so.6(abort+0x143)[0xf61c7a23]
/lib/i386-linux-gnu/i686/cmov/libc.so.6(+0x276c7)[0xf61bf6c7]
/lib/i386-linux-gnu/i686/cmov/libc.so.6(+0x27777)[0xf61bf777]
/usr/lib/i386-linux-gnu/libcairo.so.2(+0xee02)[0xf735ce02]
/usr/lib/i386-linux-gnu/libcairo.so.2(+0x2803b)[0xf737603b]
/usr/lib/i386-linux-gnu/libcairo.so.2(cairo_arc+0x5c)[0xf736d94c]
/usr/lib/i386-linux-gnu/libgtk-3.so.0(+0x2558f5)[0xf78468f5]
/usr/lib/i386-linux-gnu/libgtk-3.so.0(+0x255e61)[0xf7846e61]
/usr/lib/i386-linux-gnu/libgtk-3.so.0(+0xb21e3)[0xf76a31e3]
/usr/lib/i386-linux-gnu/libgtk-3.so.0(+0xb25ca)[0xf76a35ca]
/usr/lib/i386-linux-gnu/libgtk-3.so.0(+0xb2f4f)[0xf76a3f4f]
/usr/lib/i386-linux-gnu/libgtk-3.so.0(gtk_render_frame+0x11c)[0xf787051c]
/usr/lib/i386-linux-gnu/libgtk-3.so.0(+0xf1e97)[0xf76e2e97]
/usr/lib/i386-linux-gnu/libgtk-3.so.0(+0x1e44cd)[0xf77d54cd]
/usr/lib/i386-linux-gnu/libgtk-3.so.0(+0x31bf3e)[0xf790cf3e]
/usr/lib/i386-linux-gnu/libgobject-2.0.so.0(+0xc2e2)[0xf711d2e2]
/usr/lib/i386-linux-gnu/libgobject-2.0.so.0(+0xd9c9)[0xf711e9c9]
/usr/lib/i386-linux-gnu/libgobject-2.0.so.0(g_signal_emit_valist+0x3e3)[0xf=
7138463]
/usr/lib/i386-linux-gnu/libgobject-2.0.so.0(g_signal_emit+0x25)[0xf71391e5]
/usr/lib/i386-linux-gnu/libgtk-3.so.0(+0x32b037)[0xf791c037]
/usr/lib/i386-linux-gnu/libgtk-3.so.0(+0x32cc89)[0xf791dc89]
/usr/lib/i386-linux-gnu/libgtk-3.so.0(gtk_container_propagate_draw+0x24c)[0=
xf771f73c]
/usr/lib/i386-linux-gnu/libgtk-3.so.0(+0x12e80e)[0xf771f80e]
/usr/lib/i386-linux-gnu/libgtk-3.so.0(+0x16eb78)[0xf775fb78]
/usr/lib/i386-linux-gnu/libgtk-3.so.0(+0x1e44cd)[0xf77d54cd]
/usr/lib/i386-linux-gnu/libgtk-3.so.0(+0x31bf3e)[0xf790cf3e]
/usr/lib/i386-linux-gnu/libgobject-2.0.so.0(+0xc2e2)[0xf711d2e2]
/usr/lib/i386-linux-gnu/libgobject-2.0.so.0(+0xd9c9)[0xf711e9c9]
/usr/lib/i386-linux-gnu/libgobject-2.0.so.0(g_signal_emit_valist+0x3e3)[0xf=
7138463]
/usr/lib/i386-linux-gnu/libgobject-2.0.so.0(g_signal_emit+0x25)[0xf71391e5]
/usr/lib/i386-linux-gnu/libgtk-3.so.0(+0x32b037)[0xf791c037]
/usr/lib/i386-linux-gnu/libgtk-3.so.0(+0x32c86d)[0xf791d86d]
/usr/lib/i386-linux-gnu/libgtk-3.so.0(+0x32cb09)[0xf791db09]
/usr/lib/i386-linux-gnu/libgtk-3.so.0(gtk_container_propagate_draw+0x24c)[0=
xf771f73c]
=2E..
Aborted (core dumped)


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzr4BUACgkQMOfwapXb+vLHswCfezdV1PVcrO4HoFd6EebI34Th
VNgAnj+F4+w10wcCTDbsUCfqeB41lDCc
=J//k
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
