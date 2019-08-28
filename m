Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED96C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7919E22DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfH1WS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:18:29 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58257 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfH1WS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:18:27 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 680128051E; Thu, 29 Aug 2019 00:18:11 +0200 (CEST)
Date:   Thu, 29 Aug 2019 00:18:24 +0200
From:   Pavel Machek <pavel@denx.de>
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
Message-ID: <20190828221824.GB24056@amd>
References: <alpine.DEB.2.21.1812200022580.1651@nanos.tec.linutronix.de>
 <20190102235152.GA24163@amd>
 <20190311102109.GA14118@amd>
 <alpine.DEB.2.21.1903111403330.1691@nanos.tec.linutronix.de>
 <20190311131341.GA28223@amd>
 <alpine.DEB.2.21.1903112211180.1651@nanos.tec.linutronix.de>
 <20190312115757.GA29955@amd>
 <alpine.DEB.2.21.1903120633000.1985@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903120633000.1985@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Tue, 12 Mar 2019, Pavel Machek wrote:
> > On Mon 2019-03-11 23:31:08, Thomas Gleixner wrote:
> > > Calling this a lie is a completly unjustified personal attack on thos=
e who
> >=20
> > So how should it be called? I initally used less strong words, only to
> > get "Care to tell what's a lie instead of making bold statements?"
> > back. Also look at the timing of the thread.
>=20
> You called it a lie from the very beginning or what do you think made me
> tell you that? Here is what you said:

Actually, I still call it a lie. Document clearly says that bug is
fixed in non-virtualized cases, when in fact it depends on PAE and
limited memory.

> If you want to provide more accurate documentation then you better come up
> with something which is helpful instead of completely useless blurb like
> the below:

At this point I want you to fix it yourself. Lying about security bugs
being fixed when they are not is not cool. I tried to be helpful and
submit a patch, but I don't feel like you are cooperating on getting
the patch applied.

> > +   Mitigation is present in kernels v4.19 and newer, and in
> > +   recent -stable kernels. PAE needs to be enabled for mitigation to
> > +   work.
>=20
> No. The mitigation is available when the kernel provides it. Numbers are
> irrelevant because that documentation has to be applicable for stable
> kernels as well. And what is a recent -stable kernel?
>=20
> Also the PAE part needs to go to a completely different section.

Best regards,
								Pavel


--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1m/bAACgkQMOfwapXb+vKFyACffq6XkJvAWQwUcLfh9KmQ9cn3
tdYAoJ+7fLiag86nhWVARzGKq5ICLBjw
=PtcO
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
