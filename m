Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CE1C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 10:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A5F21850
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 10:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfJFKre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 06:47:34 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:13308 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbfJFKrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 06:47:33 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id E9698A37CC;
        Sun,  6 Oct 2019 12:47:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id 0ELAmdKFdD_J; Sun,  6 Oct 2019 12:47:14 +0200 (CEST)
Date:   Sun, 6 Oct 2019 21:47:03 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: test_user_copy: style cleanup
Message-ID: <20191006104703.jqn7qfcjlflgx5sp@yavin.dot.cyphar.com>
References: <20191005233028.18566-1-cyphar@cyphar.com>
 <20191006084102.mhqrsyg5slbfwejd@wittgenstein>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jyhn67am2k4t4wxp"
Content-Disposition: inline
In-Reply-To: <20191006084102.mhqrsyg5slbfwejd@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jyhn67am2k4t4wxp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-06, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> On Sun, Oct 06, 2019 at 10:30:28AM +1100, Aleksa Sarai wrote:
> > While writing the tests for copy_struct_from_user(), I used a construct
> > that Linus doesn't appear to be too fond of:
> >=20
> > On 2019-10-04, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > > Hmm. That code is ugly, both before and after the fix.
> > >
> > > This just doesn't make sense for so many reasons:
> > >
> > >         if ((ret |=3D test(umem_src =3D=3D NULL, "kmalloc failed")))
> > >
> > > where the insanity comes from
> > >
> > >  - why "|=3D" when you know that "ret" was zero before (and it had to
> > >    be, for the test to make sense)
> > >
> > >  - why do this as a single line anyway?
> > >
> > >  - don't do the stupid "double parenthesis" to hide a warning. Make it
> > >    use an actual comparison if you add a layer of parentheses.
> >=20
> > So instead, use a bog-standard check that isn't nearly as ugly.
> >=20
> > Fixes: 341115822f88 ("usercopy: Add parentheses around assignment in te=
st_copy_struct_from_user")
> > Fixes: f5a1a536fa14 ("lib: introduce copy_struct_from_user() helper")
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
>=20
> Fwiw, I think the commit message doesn't necessarily need to mention
> stylistic preferences nor a specific mail. It's sufficient enough to say
> that the new way makes things way more obvious. But ok. :)
>=20
> I'll pick this up now.

Thanks, and feel free to rewrite the commit message to whatever you'd
prefer.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--jyhn67am2k4t4wxp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXZnGJAAKCRCdlLljIbnQ
Eij3AP9AppWhz2UrNZFZwahOKB6K15CtcIrsH4fmtSSnntOPjQD9HKUd7PTtbkg+
t5Le+eFWp4nsyHectmZKqsivds2iLgU=
=cwwz
-----END PGP SIGNATURE-----

--jyhn67am2k4t4wxp--
