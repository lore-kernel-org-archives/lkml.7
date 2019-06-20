Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51F2C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 07:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98EE82085A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 07:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Sha4u42Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfFTHvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 03:51:55 -0400
Received: from ozlabs.org ([203.11.71.1]:41009 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbfFTHvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 03:51:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
        id 45TvCn4f3jz9sBr; Thu, 20 Jun 2019 17:51:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1561017109;
        bh=KY2I3dC1Px56+CQotFXwYFAvhLT69NhbHKJ1Ta4T1+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sha4u42YfDlRkYyVdHB+7UMxiKsSZOusC0WbZTwuwnE6jAKyBBTpF4VPpHzYTPEtf
         fR8fgbrFr8gql9u7+f6oGqb9NBj9GsSH1lDcxIXx6YDqa+5B8Xx20rm1cPOapz0uy2
         5TyrJ6kflvOgpok2aWwB5UoydscA5nQ2tjyRqRoM=
Date:   Thu, 20 Jun 2019 17:45:17 +1000
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-spdx@vger.kernel.org,
        Devicetree Compiler <devicetree-compiler@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: SPDX conversion under scripts/dtc/ of Linux Kernel
Message-ID: <20190620074517.GA2066@umbus.BigPond>
References: <CAK7LNARHHXv5Tu4BHN1avKOExS6HmPfd2c0ELZiQaxtmETOsDw@mail.gmail.com>
 <20190619125948.GA27090@kroah.com>
 <CAL_JsqJQ0bkMMpgA_JpGf-mo8ue28XpGf7oMFJ8bScGAmc+_1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <CAL_JsqJQ0bkMMpgA_JpGf-mo8ue28XpGf7oMFJ8bScGAmc+_1g@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2019 at 09:39:13AM -0600, Rob Herring wrote:
> On Wed, Jun 19, 2019 at 6:59 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jun 19, 2019 at 07:23:19PM +0900, Masahiro Yamada wrote:
> > > Hi.
> > >
> > > In this development cycle of Linux kernel,
> > > lots of files were converted to use SPDX
> > > instead of the license boilerplate.
> > >
> > > However.
> > >
> > > Some files were imported from a different project,
> > > and are periodically synchronized with the upstream.
> > > Have we discussed what to do about this case?
> > >
> > >
> > > For example, scripts/dtc/ is the case.
> > >
> > > The files in scripts/dtc/ are synced with the upstream
> > > device tree compiler.
> > >
> > > Rob Herring periodically runs scripts/dtc/update-dtc-source.sh
> > > to import outcome from the upstream.
> > >
> > >
> > > The upstream DTC has not adopted SPDX yet.
> > >
> > > Some files in Linux (e.g. scripts/dtc/dtc.c)
> > > have been converted to SPDX.
> > >
> > > So, they are out of sync now.
> > >
> > > The license boilerplate will come back
> > > when Rob runs scripts/dtc/update-dtc-source.sh
> > > next time.
>=20
> Already has. It just happened and is in next. The policy is everything
> is upstream first and any changes to dtc in the kernel are rejected.
>=20
> > >
> > > What shall we do?
> > >
> > > [1] Convert upstream DTC to SPDX
> > >
> > > This will be a happy solution if it is acceptable in DTC.
> > > Since we cannot push the decision of the kernel to a different
> > > project, this is totally up to David Gibson.
> >
> > That's fine with me :)
>=20
> I'll do the work if David is okay with it.

I have no objection.


> > > [2] Change scripts/dtc/update-dtc-source.sh to
> > >     take care of the license block somehow
> >
> > That would also be good.
> >
> > > [3] Go back to license boilerplate, and keep the files
> > >     synced with the upstream
> > >     (and scripts/dtc/ should be excluded from the
> > >      SPDX conversion tool.)
> >
> > nothing is being excluded from the SPDX conversions, sorry.  The goal is
> > to do this for every file in the kernel tree.  Otherwise it's pointless.
> >
> > > Or, what else?
> >
> > Rob remembers to keep those first lines of the files intact when doing
> > the next sync?
>=20
> Patches to the import script are welcome. The only thing I have to
> remember running the script is to add any new files. Otherwise, it's
> scripted so I don't have to remember anything.
>=20
> Rob
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0LOYoACgkQbDjKyiDZ
s5JO2Q//Qnvu8CIqR9v1DPhq1I1K6wFUT3RxjlX+pE03rujjRcwTv7K7d19AWqdL
3lwaWAc8faWWg8/ceC8hBN/yXzNwtN1nnPyeeULgVUPWoPPPg4LzWjDFfuy+6M51
CdS8lSkiCYNR52jEkirsDW6pd6NIwbaAsSgtYxd7EB39HGWwPk6xq726aPKqD6Vo
ae70uJsDOH3tSbeXwFIx8//wvI1VtylMxROJU6MoKcs7c538jddrJSRQHjI1V0PY
2Git/vQSI92xIkVc4ZrDCPhZ3TGUUuK+caYaxssLdK2lxd/lrQjL3fUCIoSykzOr
u5vaBrxoYoP4GbZX9VxCZrwocXgAYn7Qf2ihw3Xs2/StrhdNsLVkrsuzP4A9pDbZ
73Fr7FIw6UFarugBtKahlDV0yI3mQG42Awk6Is5SxLwFheyhrGMzkk8P33pV4ffb
RYZ++8GwzVFl3ko0vf7tZIhNnLZLY4/MT+efPfmu+0+YF67oZ/TsdtHu1rHz+cJz
tDj4hEzPXBRaj3jB3pEw3Xvs9EZvd6a3WeBEBoV8WtJWioS9cqHTvYtq5YQfOqzc
qg82KlJpZg74ukamcHEmwfooC9AjfKFek/7ecqlBI5fBviEMM6fI7MfyTHAErVya
ctngxdwSqxU/9DSCo5oRoSS7vgJkaaLo5rgNkd8M2DbmU9EM1ok=
=vqV0
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
