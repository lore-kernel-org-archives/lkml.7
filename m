Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E952C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD292171F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfETXNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 19:13:45 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44282 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfETXNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 19:13:45 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9F9AB8030E; Tue, 21 May 2019 01:13:32 +0200 (CEST)
Date:   Tue, 21 May 2019 01:13:42 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Subject: Re: 5.2-rc0.8: emacs segfaults?! x220, with 32-bit userland
Message-ID: <20190520231342.GA20835@amd>
References: <20190519221700.GA7154@amd>
 <20190520160636.z6fpjiidc2d5ko5g@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <20190520160636.z6fpjiidc2d5ko5g@linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > emacs segfaults... when I attempt to exit it. And that did not use to
> > be the case. Nothing suspect in the dmesg. Rest of the machine seems
> > to work ok.
> =E2=80=A6
> > Ideas welcome...
>=20
> I assume that this happens with -rc1, too. Could you please check if
> emacs still segfaults with commit
>=20
>   d9c9ce34ed5c8 ("x86/fpu: Fault-in user stack if copy_fpstate_to_sigfram=
e() fails")
>=20
> and commit
>=20
>   89833fab15d60 ("x86/fpu: Fix __user annotations")
>=20
> ?

I don't have reproducible test case :-(. I had two or three failures
so far.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzjNKYACgkQMOfwapXb+vIbQgCdGpLb+RiI8xUDh9JkMjagiEYK
MZYAnia/9SFoppzCNtLy3IGeCfzdKtvU
=ZjfV
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
