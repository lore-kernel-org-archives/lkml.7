Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778E3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEEF2184D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbfC2WE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:04:29 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:58230 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730394AbfC2WE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:04:28 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 41BB772CC64;
        Sat, 30 Mar 2019 01:04:26 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 33BC17CCE4F; Sat, 30 Mar 2019 01:04:26 +0300 (MSK)
Date:   Sat, 30 Mar 2019 01:04:26 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 13/25] m68k: add asm/syscall.h
Message-ID: <20190329220425.GA3563@altlinux.org>
References: <20181210042352.GA6092@altlinux.org>
 <20181210043010.GM6131@altlinux.org>
 <CAMuHMdVYq_2P=gb_zbSGFkPWASTds6uSPTyyhyNAgp2Qm5+feQ@mail.gmail.com>
 <20181210124059.GA11942@altlinux.org>
 <CAMuHMdW8ejp4gm2Xh-8inSQngQ5zRQ9bfsg1SG+BAD8RFV8xcA@mail.gmail.com>
 <20181210133025.GG11942@altlinux.org>
 <20181212085516.GA13288@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20181212085516.GA13288@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2018 at 11:55:16AM +0300, Dmitry V. Levin wrote:
> On Mon, Dec 10, 2018 at 04:30:25PM +0300, Dmitry V. Levin wrote:
> > On Mon, Dec 10, 2018 at 02:06:28PM +0100, Geert Uytterhoeven wrote:
> > > On Mon, Dec 10, 2018 at 1:41 PM Dmitry V. Levin <ldv@altlinux.org> wr=
ote:
> > > > On Mon, Dec 10, 2018 at 09:45:42AM +0100, Geert Uytterhoeven wrote:
> > > > > On Mon, Dec 10, 2018 at 5:30 AM Dmitry V. Levin <ldv@altlinux.org=
> wrote:
> > > > > > syscall_get_* functions are required to be implemented on all
> > > > > > architectures in order to extend the generic ptrace API with
> > > > > > PTRACE_GET_SYSCALL_INFO request.
> > > > > >
> > > > > > This introduces asm/syscall.h on m68k implementing all 5 syscal=
l_get_*
> > > > > > functions as documented in asm-generic/syscall.h: syscall_get_n=
r,
> > > > > > syscall_get_arguments, syscall_get_error, syscall_get_return_va=
lue,
> > > > > > and syscall_get_arch.
> > > > > >
> > > > > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > > Cc: Oleg Nesterov <oleg@redhat.com>
> > > > > > Cc: Andy Lutomirski <luto@kernel.org>
> > > > > > Cc: Elvira Khabirova <lineprinter@altlinux.org>
> > > > > > Cc: Eugene Syromyatnikov <esyr@redhat.com>
> > > > > > Cc: linux-m68k@lists.linux-m68k.org
> > > > > > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > > > > > ---
> > > > > >
> > > > > > Notes:
> > > > > >     v5: added syscall_get_nr, syscall_get_arguments, syscall_ge=
t_error,
> > > > > >         and syscall_get_return_value
> > > > > >     v1: added syscall_get_arch
> > > > >
> > > > > > --- /dev/null
> > > > > > +++ b/arch/m68k/include/asm/syscall.h
> > > > > > @@ -0,0 +1,39 @@
> > > > >
> > > > > > +static inline void
> > > > > > +syscall_get_arguments(struct task_struct *task, struct pt_regs=
 *regs,
> > > > > > +                     unsigned int i, unsigned int n, unsigned =
long *args)
> > > > > > +{
> > > > > > +       BUG_ON(i + n > 6);
> > > > >
> > > > > Does this have to crash the kernel?
> > > >
> > > > This is what most of other architectures do, but we could choose
> > > > a softer approach, e.g. use WARN_ON_ONCE instead.
> > > >
> > > > > Perhaps you can return an error code instead?
> > > >
> > > > That would be problematic given the signature of this function
> > > > and the nature of the potential bug which would most likely be a us=
age error.
> > >=20
> > > Of course to handle that, the function's signature need to be changed.
> > > Changing it has the advantage that the error handling can be done at =
the
> > > caller, in common code, instead of duplicating it for all
> > > architectures, possibly
> > > leading to different semantics.
> >=20
> > Given that *all* current users of syscall_get_arguments specify i =3D=
=3D 0
> > (and there is an architecture that has BUG_ON(i)),=20
> > it should be really a usage error to get into situation where i + n > 6,
> > I wish a BUILD_BUG_ON could be used here instead.
> >=20
> > I don't think it worths pushing the change of API just to convert
> > a "cannot happen" assertion into an error that would have to be dealt w=
ith
> > on the caller side.
>=20
> I suggest the following BUG_ON replacement for syscall_get_arguments:
>=20
> #define SYSCALL_MAX_ARGS 6
>=20
> static inline void
> syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
> 		      unsigned int i, unsigned int n, unsigned long *args)
> {
> 	/*
> 	 * Ideally there should have been
> 	 * BUILD_BUG_ON(i + n > SYSCALL_MAX_ARGS);
> 	 * instead of these checks.
> 	 */
> 	if (unlikely(i > SYSCALL_MAX_ARGS)) {
> 		WARN_ONCE(1, "i > SYSCALL_MAX_ARGS");
> 		return;
> 	}
> 	if (unlikely(n > SYSCALL_MAX_ARGS - i)) {
> 		WARN_ONCE(1, "i + n > SYSCALL_MAX_ARGS");
> 		n =3D SYSCALL_MAX_ARGS - i;
> 	}
> 	BUILD_BUG_ON(sizeof(regs->d1) !=3D sizeof(args[0]));
> 	memcpy(args, &regs->d1 + i, n * sizeof(args[0]));
> }

There seems to be a more straightforward approach to this issue.

Assuming there is a general consensus [1] to get rid of "i" and "n"
arguments of syscall_get_arguments(), the implementation could be
simplified to

static inline void
syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
		      unsigned long *args)
{
	memcpy(args, &regs->d1, 6 * sizeof(args[0]));
}

[1] https://lore.kernel.org/lkml/20190328230512.486297455@goodmis.org/


--=20
ldv

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcnpZpAAoJEAVFT+BVnCUI4vIQAPQqju1aoX3/IZxEksFJW+ev
dIbmz5U9rnjfdtM50I6X9mysyxyR2HNniWeuFZbt0tHmpAhu16O8Bnp9KvxYr5Dm
ftvzu6VPj44c/S09aLdnlBLSgFJcckQqGauuggS67ADhENuFv9pAWYNBUz6oEKWv
RawTPm+1po3rUVgm2Ob3AK9mujgsuShyhvWxc2ObZgUBptYVC7BhnbOErBRYIomi
FPeEmA0esJN2HeU2KNuq9H+tOpzODEIY9EfF2m4b+LLFgCwI4OqL34KiQ57qbNJ/
aywwUV+TAMahEgxNFPEt1nDgx4S23EaMoI49y5W/l8lKIqKD3uc+AKOzTIabDnE3
ntY8i1YWUBaOZ14oqZJ5AQtzIr51mgu7H4LmNIJQvJoxGj5T8tJ2f2VlLDIlyTEG
bw8O+pnAof6GcaXxBvjuvwpXyegApM/s11a5G2ERCLLaWtnEloNf8Ud/ZCVLsPV6
ppHcvjY/OhI+vglUiz2gm5AuR7ci6afdFzUkvWuwM3kHOdudsVANM3EK7Whp4BZt
K6G8uy2wT4j9xTqLBsJoHuOkbchXn9+d/jBVUUuEs2IumK8SoWolynuyIA8VRepB
MrM7o6RcWNtT/x/5Ew9HkVJERzPwkAtNVKn+vEwNlwiRKar/up/UPZIqMSPdikKz
7y4/HcyUgWxDuWb5uvpz
=i7SW
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
