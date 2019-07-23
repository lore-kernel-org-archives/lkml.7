Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E76CC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6DF21901
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563892797;
	bh=mMeY3/OtxMWpa39E7wXBfaYBm1JiBj12l2UKOs1pdWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V1ePk4WFJkLFiTj/+1Borx/2LupEtQPyjWaaZkQmyN40LSQz9d+UvT3WBs/FPwgo+
	 T/lO/ZvEn9OoIdUTB7P1C0k5W9VmjxzN/n81k4V4autPCSMpeW89LADuDGuOfw0S3i
	 z5iLjBdk+SZTKjHgEeFPyuG2Yy1Al+BbjHHK0gGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390683AbfGWOj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 10:39:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55920 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbfGWOjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 10:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3kwHf4dclNlMO326pKn0fOIoYBdYFcKGvDxeiHwT1Qg=; b=W+hzEGqsxK4WKooZJNtUpklx6
        FsNDdQXDP8iUrin6WzO2OIhaaUxNOZLl616HN1NigAfst5yrzVAe46qBoj4Dx93r7aLghZi8O69EA
        x0cPRYRiTNe7HsOeXUWq8ieyYvnID48DYbt0kFIuZQoTltqlRPywX/7rIup42dxsIfJwg=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hpvxJ-0003vk-HF; Tue, 23 Jul 2019 14:39:53 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id CBC242742B59; Tue, 23 Jul 2019 15:39:52 +0100 (BST)
Date:   Tue, 23 Jul 2019 15:39:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] regulator: act8865: support regulator-pull-down property
Message-ID: <20190723143952.GG5365@sirena.org.uk>
References: <d02d7285ef26f59ce43a3097e342eea081b98444.1563819128.git.mirq-linux@rere.qmqm.pl>
 <20190723105432.GB5365@sirena.org.uk>
 <20190723120938.GC14036@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L+ofChggJdETEG3Y"
Content-Disposition: inline
In-Reply-To: <20190723120938.GC14036@qmqm.qmqm.pl>
X-Cookie: Avoid contact with eyes.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L+ofChggJdETEG3Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2019 at 02:09:38PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> On Tue, Jul 23, 2019 at 11:54:32AM +0100, Mark Brown wrote:
> > On Mon, Jul 22, 2019 at 08:13:29PM +0200, Micha=C5=82 Miros=C5=82aw wro=
te:
> > > AC8865 has internal 1.5k pull-down resistor that can be enabled when =
LDO
> > > is shut down.

> > This changelog...

> > >  static const struct regulator_ops act8865_ldo_ops =3D {
> > > +	.list_voltage		=3D regulator_list_voltage_linear_range,
> > > +	.map_voltage		=3D regulator_map_voltage_linear_range,
> > > +	.get_voltage_sel	=3D regulator_get_voltage_sel_regmap,
> > > +	.set_voltage_sel	=3D regulator_set_voltage_sel_regmap,

> > ...doesn't obviously match this code change which looks to be
> > implementing voltage setting (as well as the pull down stuff but still).

> It's just an diff-artifact of changing act8865_ldo_ops meaning. It's
> now a copy of act8865_ops with .set_pull_down added. Previous
> act8865_ldo_ops is act8865_fixed_ldo_ops now.

If there's that big a refactoring it probably warrants a separate patch,
and it definitely should be called out in the changelog.  Like I say the
changbelog does not describe the change at all well.

--L+ofChggJdETEG3Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl03HDgACgkQJNaLcl1U
h9DXWgf+McinK+M4V+1QaBFtsXFUXStLZ53MAvnbruJJP+pXpNr05ZHhFEfrSiwY
wiQPc/lKK0eOPpAp5azy0sRS6cvzdrD0tHWG1rsfE94WlH2rA73rZZ7jCAb4A0nL
m38lc/J+3RNe/8CPU/wcDMUh7plJUJ6JafrOrOhQIi979NJpAvjps6nfaXsTmMow
6Znn6XpSVS8TMRh12ZwBYoX4lJpmejEn2/RvP/j7dNovLBMebYk5EAoaueFNGjwt
nSvG6gywLZa/7upxUOzwSvJPDuKm4ciLlRoXvjz+gQubsVlPJDXKeMr5JOtL1d//
mOvualWBLUuX8jwDZvL/QLyzrLuF2Q==
=QgBn
-----END PGP SIGNATURE-----

--L+ofChggJdETEG3Y--
