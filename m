Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D536C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086D0206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfCLL6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 07:58:01 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43419 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfCLL6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 07:58:01 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id AD1018057A; Tue, 12 Mar 2019 12:57:50 +0100 (CET)
Date:   Tue, 12 Mar 2019 12:57:57 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     corbet@lwn.net, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tony Luck <tony.luck@intel.com>,
        Salvatore Bonaccorso <carnil@debian.org>,
        linux-doc@vger.kernel.org
Subject: Re: [patch] Fix up l1ft documentation was Re: Taking a break - time
 to look back
Message-ID: <20190312115757.GA29955@amd>
References: <alpine.DEB.2.21.1812200022580.1651@nanos.tec.linutronix.de>
 <20190102235152.GA24163@amd>
 <20190311102109.GA14118@amd>
 <alpine.DEB.2.21.1903111403330.1691@nanos.tec.linutronix.de>
 <20190311131341.GA28223@amd>
 <alpine.DEB.2.21.1903112211180.1651@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903112211180.1651@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-03-11 23:31:08, Thomas Gleixner wrote:
> Pavel,
>=20
> On Mon, 11 Mar 2019, Pavel Machek wrote:
> > On Mon 2019-03-11 14:05:07, Thomas Gleixner wrote:
> > > Huch? Care to tell what's a lie instead of making bold statements?
> >=20
> > Take a care to look at the patch I submitted?
> >=20
> > Lie:
> >=20
> > # A system with an up to date kernel is protected against attacks from
> > # malicious user space applications.
> >=20
> > 3GB system running 32bit kernel is not protected. Same is true for for
> > really big 64bit systems.
>=20
> I agree that this statement is incorrect.
>=20
> Calling this a lie is a completly unjustified personal attack on those who

So how should it be called? I initally used less strong words, only to
get "Care to tell what's a lie instead of making bold statements?"
back. Also look at the timing of the thread.

> >     Ok, I guess L1TF was a lot of fun, and there was not time for a good
> >     documentation.
>=20
> It's interesting that quite some people were actually happy about that
> document. Sorry, that we weren't able to live up to your high
> standards.

Ok, now can we have that document updated to meet the standards?

> > @@ -1,10 +1,11 @@
> >  L1TF - L1 Terminal Fault
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > =20
> > -L1 Terminal Fault is a hardware vulnerability which allows unprivileged
> > -speculative access to data which is available in the Level 1 Data Cache
> > -when the page table entry controlling the virtual address, which is us=
ed
> > -for the access, has the Present bit cleared or other reserved bits set.
> > +L1 Terminal Fault is a hardware vulnerability on most recent Intel x86
>=20
> The 'Affected processors' section right below this is very clear about th=
is
> being an Intel only issue (for now). So what exactly is the point of this
> change?

Making it very clear from the begining this is x86-only issue. Yes,
you can kind-of figure it out from the next section... except for
Intel StrongArm.

Next sentence speaks about "present bit" of "page table entry". That
may be confusing for people familiar with other architectures, which
may not have such bit. We should mention this is x86 before using
x86-specific terminology.

> hardware. A 32bit kernel booted on a 64bit capable CPU has the same issue.
> For further correctness, this needs to mention that !PAE enabled kernels
> cannot do PTE inversion at all.

Ok.

> > 3GB system running 32bit kernel is not protected. Same is true for for
> > really big 64bit systems.
>=20
> Where is the explanation for the 'really big 64bit systems' issue for
> correctness sake?

I don't know the detailed limits for each system; what about this?

Signed-off-by: Pavel Machek <pavel@ucw.cz>

									Pavel

diff --git a/Documentation/admin-guide/l1tf.rst b/Documentation/admin-guide=
/l1tf.rst
index 9af9773..cbf02a4 100644
--- a/Documentation/admin-guide/l1tf.rst
+++ b/Documentation/admin-guide/l1tf.rst
@@ -1,10 +1,11 @@
 L1TF - L1 Terminal Fault
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-L1 Terminal Fault is a hardware vulnerability which allows unprivileged
-speculative access to data which is available in the Level 1 Data Cache
-when the page table entry controlling the virtual address, which is used
-for the access, has the Present bit cleared or other reserved bits set.
+L1 Terminal Fault is a hardware vulnerability on most recent Intel x86
+CPUs which allows unprivileged speculative access to data which is
+available in the Level 1 Data Cache when the page table entry
+controlling the virtual address, which is used for the access, has the
+Present bit cleared or other reserved bits set.
=20
 Affected processors
 -------------------
@@ -76,12 +77,15 @@ Attack scenarios
    deterministic and more practical.
=20
    The Linux kernel contains a mitigation for this attack vector, PTE
-   inversion, which is permanently enabled and has no performance
-   impact. The kernel ensures that the address bits of PTEs, which are not
-   marked present, never point to cacheable physical memory space.
-
-   A system with an up to date kernel is protected against attacks from
-   malicious user space applications.
+   inversion, which has no measurable performance impact in most
+   configurations. The kernel ensures that the address bits of PTEs,
+   which are not marked present, never point to cacheable physical
+   memory space. For mitigation to be effective, physical memory needs
+   to be limited in some configurations.
+
+   Mitigation is present in kernels v4.19 and newer, and in
+   recent -stable kernels. PAE needs to be enabled for mitigation to
+   work.
=20
 2. Malicious guest in a virtual machine
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyHnsUACgkQMOfwapXb+vJM9QCeKbEXiW/YBjJn52kEdFLQvM1i
FKsAoL4ebJhxukQko0/F+7OVRAj/YHpG
=p7N6
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
