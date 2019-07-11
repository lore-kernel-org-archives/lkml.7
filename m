Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B5DC74A4B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 09:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C54D21537
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 09:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562838292;
	bh=OU0r6pDDPf0bfwJa5IbUsOd0jpftMBSu3AIyCunAmaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pS1ipbj5dcCePbxhTdDof/elgJcniT2V0dgNPsyMxvufs+pWHdXHD+Tu0d8MeWbtu
	 /vPyqI46B/R+ohiVzD9NGLUqUhrJ9Sh59PnIU4EaRgaESzbgyvOAsUVl/0Fes1kKH1
	 TZS66o9a6P65cvtpuYFYriF6zmWtdqpSApc7Z0rM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfGKJov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 05:44:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfGKJou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 05:44:50 -0400
Received: from earth.universe (dyndsl-031-150-081-114.ewe-ip-backbone.de [31.150.81.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03D4B20872;
        Thu, 11 Jul 2019 09:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562838289;
        bh=OU0r6pDDPf0bfwJa5IbUsOd0jpftMBSu3AIyCunAmaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=toW6Y+6trrhb59gdQZIgM6+Cf/7TISSyfPifjfMC8gDKzcL7ahmDmIzG6cUfNGtHP
         46Qx5Bsv/qEYXgAZtKosbv/4XgZ+dlzWByh6N1dgKYFCEZv6sFCtxQNT4X0PhniIUx
         ygR20+fE441RUQH+lgq5QhGxOR1XT/uiupViMGWU=
Received: by earth.universe (Postfix, from userid 1000)
        id C0C783C08DC; Thu, 11 Jul 2019 11:44:46 +0200 (CEST)
Date:   Thu, 11 Jul 2019 11:44:46 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: linux-next: manual merge of the battery tree with the pci tree
Message-ID: <20190711094446.mdmjlcsnorluzy5h@earth.universe>
References: <20190628135511.34853c19@canb.auug.org.au>
 <20190709101424.3876cbba@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x4dhcvjv35gg7k5q"
Content-Disposition: inline
In-Reply-To: <20190709101424.3876cbba@canb.auug.org.au>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x4dhcvjv35gg7k5q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 09, 2019 at 10:14:24AM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> On Fri, 28 Jun 2019 13:55:11 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >=20
> > Today's linux-next merge of the battery tree got a conflict in:
> >=20
> >   Documentation/power/power_supply_class.txt
> >=20
> > between commit:
> >=20
> >   151f4e2bdc7a ("docs: power: convert docs to ReST and rename to *.rst")
> >=20
> > from the pci tree and commit:
> >=20
> >   49c9cd95bb6d ("power: supply: add input power and voltage limit prope=
rties")
> >=20
> > from the battery tree.
> >=20
> > I fixed it up (I deleted the file and adde the following merge fix patc=
h)
> > and can carry the fix as necessary. This is now fixed as far as linux-n=
ext
> > is concerned, but any non trivial conflicts should be mentioned to your
> > upstream maintainer when your tree is submitted for merging.  You may
> > also want to consider cooperating with the maintainer of the conflicting
> > tree to minimise any particularly complex conflicts.
> >=20
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Fri, 28 Jun 2019 13:52:44 +1000
> > Subject: [PATCH] power: supply: update for conversion to .rst
> >=20
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  Documentation/power/power_supply_class.rst | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/Documentation/power/power_supply_class.rst b/Documentation=
/power/power_supply_class.rst
> > index 3f2c3fe38a61..883b2ef63119 100644
> > --- a/Documentation/power/power_supply_class.rst
> > +++ b/Documentation/power/power_supply_class.rst
> > @@ -166,6 +166,14 @@ INPUT_CURRENT_LIMIT
> >    input current limit programmed by charger. Indicates
> >    the current drawn from a charging source.
> > =20
> > +INPUT_VOLTAGE_LIMIT
> > +  input voltage limit programmed by charger. Indicates
> > +  the voltage limit from a charging source.
> > +
> > +INPUT_POWER_LIMIT
> > +  input power limit programmed by charger. Indicates
> > +  the power limit from a charging source.
> > +
> >  CHARGE_CONTROL_LIMIT
> >    current charge control limit setting
> >  CHARGE_CONTROL_LIMIT_MAX
> > --=20
> > 2.20.1
>=20
> I am still getting this conflict (the commit ids may have changed).
> Just a reminder in case you think Linus may need to know.

Yes - your solution is correct and I will forward the information to
Linus, thanks.

(Sorry for the delayed reply, lot's of work these days)

-- Sebastian

--x4dhcvjv35gg7k5q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl0nBQgACgkQ2O7X88g7
+prXFBAAgsLyABGUEPD4Z+Tmgyqvw3XXLW/TcALqK7JGWdVDd6nD41fQ1hHvI57V
i8BQrge6B3dF1VUCEQAIEoOm5ACaKwG/m8kEB8KVSe60v/k1P6C+VMbE7bkzUDLm
GtnuXGAMJNa5/FpEuYzyY0ezhk0KrPL+86BMJ1cKVHaxU2IuAI/R7oFQT1zvCHdF
/1cO1IV2rwPjp4M/cN0CVBkBq1FhJwfoDxRp1BtvClUiZsuoJ/T0gT1U2/xZJU42
L2/N1l1sIQ0pp9tvAhwJ95w8IcRpiBiK2ohDqvrzB9BTA2Gz75cAhUwpOVSBbnh0
dpdZhcNjEl2qAqnX7lhJXWkzNPy87DWpz3z6PDmh9CR/zV9S0far9RIS1sQsXBwQ
ClHp3odWFet0tbs8ImfYU3qwhMZxkUbOz432ijGsVGC2QO9+eAcphHQ8Al+j/gWw
KP0/HXghB5TwF9TTP/lDtr/OfRO7+wbPj/AH3TMSkslPuVli/Oo6q2yXoWbjQBWp
NXgMR375hfji4Qe7Hg80Fufm++z/Gs4qXTpkc4LYCZIznBS6+v7bihx50VyHUqtp
EKF0WaPAnP/OSJ9g0DtCSA6FF/n3hgRlzt0RMDOaxB3vKxxBJQbA+UHZ+Op7iqDW
FfC3jwuA8jWH9913ipl0vxYULH+NU9P37o3HyWH2n8f2cjCxtU0=
=csO5
-----END PGP SIGNATURE-----

--x4dhcvjv35gg7k5q--
