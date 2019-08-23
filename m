Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927F2C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFD920850
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566554670;
	bh=3DiG4MYwvCMC4cw4VDN8h+L/MvdV9qXsRSZZRwmny6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FbHUnaWwqHV1GsmMAvVbvsRFgJukapeFK1il/I3wFOxPFKnm3OGjSILc1rpvDeR/f
	 bNYouQOFS3htUgEre8vaDcXlDb23U6oHlRkYAojKWOHh/jhbTG9EoIvBgEXdYwpxYL
	 TKpilF99g8VulrynAqQ7mp1dVTzQ+c+Bxw4gAcSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391750AbfHWKE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:04:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43656 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729716AbfHWKE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/fKlgjFGA0o3m4WiBlVTFJ5fR5eZsQoIHmC08YJKEpw=; b=R8QbTtn2kSFaM1V4mogTzuXLs
        1rOMDT3GIa3TV8+bKZehX2qooP6QO/sSeoJwlW31NtztwKne9NyZd4kO0jZa1jMY/SNvTbiMnfN3q
        2W/X+8zTLHaduPe07krQhhkZ/3YirtrpbxSv45V7F6xOsHkzmBhPXjWwn2RbWl7H4uWJQ=;
Received: from [92.54.175.117] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i16Qi-0002fV-MM; Fri, 23 Aug 2019 10:04:24 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 9784DD02CD0; Fri, 23 Aug 2019 11:04:24 +0100 (BST)
Date:   Fri, 23 Aug 2019 11:04:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        =?iso-8859-1?Q?=22Ren=E9_van_Dorst=22?= <opensource@vdorst.com>
Subject: Re: Aw: Re: BUG: devm_regulator_get returns EPROBE_DEFER
 (5.3-rc5..next-20190822) for bpi-r2/mt7623/mt7530
Message-ID: <20190823100424.GL23391@sirena.co.uk>
References: <trinity-584a4b1c-18c9-43ae-8c1a-5057933ad905-1566501837738@3c-app-gmx-bs43>
 <20190822193015.GK23391@sirena.co.uk>
 <trinity-5d117f0d-9f34-4a2b-8a12-1cd34152c108-1566505724458@3c-app-gmx-bs43>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N8ia4yKhAKKETby7"
Content-Disposition: inline
In-Reply-To: <trinity-5d117f0d-9f34-4a2b-8a12-1cd34152c108-1566505724458@3c-app-gmx-bs43>
X-Cookie: Don't SANFORIZE me!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--N8ia4yKhAKKETby7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2019 at 10:28:44PM +0200, Frank Wunderlich wrote:

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> cfba5de9b99f drivers: Introduce device lookup variants by of_node
>=20
> this looks suspicios to me since the change is in the function which fail=
s:

> struct regulator_dev *of_find_regulator_by_node(struct device_node *np)
>  {
>         struct device *dev;
> =20
> -       dev =3D class_find_device(&regulator_class, NULL, np, of_node_mat=
ch);
> +       dev =3D class_find_device_by_of_node(&regulator_class, np);
>=20
>=20
> but i cannot revert this commit so i did it manually...but this does not =
seem to be the cause...still error 517, also a change in core.c is not the =
cause...

Can you run a git bisect to try to identify the commit that
caused things to fail?

> how can i check instantiation at runtime?

Look to see if there is a device driver bound to that device, or
check if the parent regulator is visible in /sys/class/regulators. =20
You'll also see a mesage printed out for each regulator as it
instantiates in the boot logs, you can check there too.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--N8ia4yKhAKKETby7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1fuiUACgkQJNaLcl1U
h9AmOwf/dossdohwbTU7gbRKWcbcwf5yhS50bvPY1dNR7W4KqmsYN4dgsqojcrYT
M05UrO0aDBneDe6vBp5Sv0RQDShfVdQZq9LChbmTkSYExNwexrXptKmMMQsVLvnt
B1vSsj4V7fhEeFzk1ra1Q7/GmXMsa8ilxKjnOgS13ygcSu7+P3BCCSIGTm8u4Bms
Owhk71a4jdDukj5+vkSdK1byT7EFmchdaBF68HN1fh390pjj6qakJBnnOygnfoOu
hj48bRiTFS0tj2rypVZKgzDexw8aAWtKmvlRGH0JL8kSOUCMblhsCT7yJ0o61im6
hTmjxgATLGRh9JZIUOPxoafwWbiclQ==
=hch8
-----END PGP SIGNATURE-----

--N8ia4yKhAKKETby7--
