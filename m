Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC41C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9547204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698738;
	bh=K94Jf9uq6VUzxzChY0kp9dzYdfeeLelf0XJfrRUOQnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=piijXHXIBgV6zKI/3S2tWwx1TRNHi0VburSF3ZYg9EalikEihoscbGGYOmD97gGYr
	 HYlWwdSF6VmD52I0txlAYWX08MPFiwQNFS+M6vJ68C1R8RGEaJvWulQDVYzD8Y6W5D
	 K99K1kMkYO1pPV1XYr4uQLW7PJVEOCuXOqQbnyAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfDSScR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:32:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbfDSS3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:17 -0400
Received: from earth.universe (dyndsl-091-248-050-217.ewe-ip-backbone.de [91.248.50.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DB3B21924;
        Fri, 19 Apr 2019 12:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555677744;
        bh=K94Jf9uq6VUzxzChY0kp9dzYdfeeLelf0XJfrRUOQnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1dpW6m8g5XkcbsyT9NfTUTEZ3w4+LzI0FSI1tizaIQ4MDOUyFtcSMhW3nFjHS84l4
         43fbXDmDb94mGd+WKykmI84GgtV5TczySN7XAxZSws3sy/II1FjXCb5udOKBlgHRgC
         JvoebHzkeT1Dg2QMkf1/DbyjocMHnBVgoQ74T9tk=
Received: by earth.universe (Postfix, from userid 1000)
        id 3C8383C08D5; Fri, 19 Apr 2019 14:42:22 +0200 (CEST)
Date:   Fri, 19 Apr 2019 14:42:22 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        Darren Hart <dvhart@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 00/10] Add support for XO 1.75 to OLPC battery driver
Message-ID: <20190419124222.yizj6krkdi236x74@earth.universe>
References: <20190418144655.18758-1-lkundrak@v3.sk>
 <20190418202000.hcojhcf2f47te44u@earth.universe>
 <20190419075716.GB6795@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fjpcncqz7gjt75yj"
Content-Disposition: inline
In-Reply-To: <20190419075716.GB6795@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fjpcncqz7gjt75yj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ingo,

On Fri, Apr 19, 2019 at 09:57:16AM +0200, Ingo Molnar wrote:
> > On Thu, Apr 18, 2019 at 04:46:45PM +0200, Lubomir Rintel wrote:
> > > This patch set modifies the OLPC battery driver so that it could even=
tually
> > > be used on an Arm-based OLPC XO 1.75 machine.
> > >=20
> > > Compared to the previous version, it addresses review comments for the
> > > x86 platform parts from Thomas Gleixner. Details in individual patche=
s'
> > > change logs.
> > >=20
> > > I've failed to version the previous iteration of the set that should'=
ve
> > > been "v6" for the change logs to make sense. Sorry for that.
> > >=20
> > > Thank you,
> > > Lubo
> >=20
> > I queued up the complete patchset via an immutable branch based on
> > v5.1-rc1. X86 maintainers can pull this signed immutable branch as
> > required. Thanks for the patches,
>=20
> Would you mind sending these patches to Linus yourself, as part of the=20
> power-supply tree?
>=20
> That's where it really belongs, the impact on arch/x86/ was mostly=20
> drive-by (and it's now all Acked-by Thomas), the meat of the changes is=
=20
> in the OLPC battery driver.

Yes, I merged the immutable branch into power-supply. You can either
also merge it (e.g. when you plan to add other changes), or just ignore
it :) This is what I usually do with other subsystems to avoid
pointless merge conflicts.

TLDR: Yes.

-- Sebastian

--fjpcncqz7gjt75yj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAly5wiQACgkQ2O7X88g7
+pohFhAAnMvGVvpZWUjOCSBeX6SHrawPkrxXf0+MNl9LXP58EPyPdlLep8CkDTWM
3l2z2RuOdWyPdUjRuJquk0GdiSum+DtTiUPj+E0c1TjgFxzqOxV5p+sY1J1aGlMP
ES6x5K1d3CFVDDYKY+e+0+SS8vU4Bhfxb+n1jOBQsEQDa6MdP7HDXDFt0QGDCqoM
2CdNIGWPjefYvwMJD7HthEoe7Rkahv81EVGv8RbkojNSd4vr5k7pTlYyNHsrv8sR
K3/+1BMQ+bDuvfwYFXO7FmR1UivLq+gNE+q0+TA+AkKZMpIJ6+P8fjxgspn2T8UI
PC8XR2HVmvVVA6VeiM/gcvPbX6GnVAlnXCxeLUkGwF+NZvyIIEgg1TIsDrmV21Nn
DQ02ELgvIXX5QdbBREP0aL83HqK4i5C0bJRO/+4kTrClP3clthuoA5GSEppOWxmP
2kZJUMdiWCU5Q9ReGjOaXq63HMNRMwrFi+2jABbM2FSc9+shv3M+O9tr2heJi1Kx
+e8RQkQ+iZn4w/Uz8EVIvwdfHgHKLMrip38A3iXqQABmIEk7nvI9/UXoC7nNcxDM
8E1FXpN5hoK+b2pTaTWMCfTlsjXM7kFg2J4Pgq4KMJIp2xcLmxMkrl/9cQg0pWwb
uO8IXoUm8ChpHvXHrS7wWPcbQCGTrV0LoVwMpbUyVF1vtVB8+Ck=
=NiHD
-----END PGP SIGNATURE-----

--fjpcncqz7gjt75yj--
