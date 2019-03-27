Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF258C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A454D21738
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbfC0WUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:20:18 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:57850 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbfC0WUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 18:20:17 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 74A0072CC64;
        Thu, 28 Mar 2019 01:20:14 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 65CED7CC74C; Thu, 28 Mar 2019 01:20:14 +0300 (MSK)
Date:   Thu, 28 Mar 2019 01:20:14 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2] x86/syscalls: Mark expected switch fall-throughs
Message-ID: <20190327222014.GA32540@altlinux.org>
References: <20190228192746.GA13021@embeddedor>
 <alpine.DEB.2.21.1903231457590.1798@nanos.tec.linutronix.de>
 <20190326151244.GC16837@redhat.com>
 <20190327012606.GA16532@altlinux.org>
 <alpine.DEB.2.21.1903271527110.1789@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903271527110.1789@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2019 at 03:29:16PM +0100, Thomas Gleixner wrote:
> On Wed, 27 Mar 2019, Dmitry V. Levin wrote:
> > On Tue, Mar 26, 2019 at 04:12:45PM +0100, Oleg Nesterov wrote:
> > > On 03/23, Thomas Gleixner wrote:
> > [...]
> > > >  2) syscall_set_arguments() has been introduced in 2008 and we stil=
l have
> > > >     no caller. Instead of polishing it, can it be removed completel=
y or are
> > > >     there plans to actually use it?
> > >=20
> > > I think it can die.
> >=20
> > When PTRACE_GET_SYSCALL_INFO is finally squeezed into the kernel,
> > we could discuss adding PTRACE_SET_SYSCALL_INFO as well, and it
> > will need syscall_set_arguments().
>=20
> So if that ever happens, then adding the code back isn't rocket
> science. But if not, then there is no point in carrying the dead horse
> around another 11 years.

Given that it took me roughly 4 months to get a relatively simple revert
of commit 5e937a9ae913 accepted into linux-next, adding the code back
might be time-consuming.

Could we delay the removal of syscall_set_arguments() until
PTRACE_GET_SYSCALL_INFO is merged into the kernel?
I hope it won't take another 11 years.


--=20
ldv

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcm/ceAAoJEAVFT+BVnCUIEE8QALYlKI6C3NwfhOKR/dR7HX+P
RPjSGvTsGqP6qvOn0WTMaab2nuU2YnyM0k+dnuQIKqbPChWiWzYdhtBCCJGGsnHo
f9HxIguGBwTvUL3B7QvB6iYw0vPG+aZ/S1Bj3gswwDvmQqPMZOLxJtLnUUX9r8zA
EkobwgBp/kr44VycJIPkAifCvpri53Bf84e6aGsaUvJzRLlYBubIuoSi0SbNX7lC
wmOcanjcFB/FcbXPwyDiyXmhLfs5V36Lq2C84IIDzqDeDp9SSR7v7Sw/GBmUcIQa
NWcpn9zOYGpD1Vex3/CvBiGPcZauVJgZsiNgU5uO5Ms5SXhPdgAL9dl9Bmyaycqx
qTTW821o3xTwdhOAYUJUStS7ZzQLPqUNKxJA9gaiY/D73I9cm/YK/H6D8AY0wG+d
CSk7xY9648B2ioN16bsZgJCrh3Qzy4iLPY1fyd5WkTDf1dKxCwgHU30o9VwQdDn5
Ptf0KuxwJx4c+rFZhqGPeSWcT13+Y80tbixwsVUvy+rwEtOSVKH3knfc/hSWasvc
INDXY1+SNKf+J+d/riM1l7zlu3UwG+NPwCzvVbITa5CAqHplReEmPntjs7WdfPV/
wIYBV0CmpfWp17cw8k0rTnEKFFWPgSCeT9aBTHFZdPZ9IEaFNtnNxD+wHsbwNBli
85U7SHuwXllNC2nE+wc6
=bttL
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
