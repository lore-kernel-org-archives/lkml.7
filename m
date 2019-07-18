Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A07EC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE782085A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563450324;
	bh=B9Kz6pFMczFF1LD0Q9C/OP/+r6DSVJP8CbzcGMXcEiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q40SWNecKFmUSPRJ3Qf135p9CbNebqIdUg3GinsypBY3hui4itDOQcb2X0POxeRIz
	 +O/T4vZDVCnT5GBS1+fr9D9fpYFy5PHAj09oV+xFh+wLY4PgPUTNE11jhVAl7HmG4s
	 iK9OtvvKlwPb5J/lOn6DdSP+6uZD5EPvsgQL3o0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390142AbfGRLpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 07:45:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58702 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfGRLpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 07:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NKk1z9eeAZpeVSsCA5XD6xsclz2cwdL0iURWkjA/YF0=; b=wlXSOFlWAZaZhPQOl1zJwbMRx
        frcQPj15rPyZEVIl3jhXyGyy0HYkv8Hjp+Yl6V7nF3hQ7A6RVJsMf0IZzdNF5UtaoN+WOWkxRIfTP
        FUbqlP/0b9XHmgjePbatehOO1pe3NMr9rBfuF0tuAi5fXuT7KekyIzN6cyXhKHhFnw4ak=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ho4qX-0004yz-3a; Thu, 18 Jul 2019 11:45:13 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 2FE502742C07; Thu, 18 Jul 2019 12:45:12 +0100 (BST)
Date:   Thu, 18 Jul 2019 12:45:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, chao.hao@mediatek.com,
        cui.zhang@mediatek.com, ming-fan.chen@mediatek.com,
        youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>,
        anan.sun@mediatek.com, Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [RFC PATCH] regulator: core: Move device_link_remove out from
 regulator_list_mutex
Message-ID: <20190718114512.GA5761@sirena.org.uk>
References: <1563432146-28097-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <1563432146-28097-1-git-send-email-yong.wu@mediatek.com>
X-Cookie: Oh, wow!  Look at the moon!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2019 at 02:42:26PM +0800, Yong Wu wrote:
> The MediaTek SMI adding device_link patch looks reveal a deadlock
> issue reported in [1], This patch is to fix this deadlock issue.

Can you please describe in words what this issue is and how the patch
addresses it?

> This is the detailed log:
>=20
> [    4.664194] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    4.670368] WARNING: possible circular locking dependency detected
> [    4.676545] 5.2.0-rc2-next-20190528-44527-g6c94b6475c04 #20 Tainted: G=
 S
> [    4.684539] ------------------------------------------------------

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

> index 955a0a1..3db9350 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -2048,7 +2048,9 @@ static void _regulator_put(struct regulator *regula=
tor)
>  	debugfs_remove_recursive(regulator->debugfs);
> =20
>  	if (regulator->dev) {
> +		mutex_unlock(&regulator_list_mutex);
>  		device_link_remove(regulator->dev, &rdev->dev);
> +		mutex_lock(&regulator_list_mutex);
> =20
>  		/* remove any sysfs entries */
>  		sysfs_remove_link(&rdev->dev.kobj, regulator->supply_name);
> --=20
> 1.9.1
>=20

Just randomly dropping and reacquiring the lock in the middle of a
series of operations sounds potentially racy...  What happens if the
list gets changed while the lock is dropped?

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0wW8UACgkQJNaLcl1U
h9Duwgf8DrFA6rkNbZWAOQolUO3ScHl7ZIFDMYs/c8IslX851jEG59mVl69AFFdx
OOzfKw4BgDoYJX0pIoCnYGkEyTZgI3m1zWOmb3ceu8UPwxDa2fOeXaXvfRT0C9IP
J4sQe88/NyzcipB6TwzYri4MnDI/dC5cmnHGuiOLWRzLtu9JKLdkyqoHynMk8gy8
RbFiatFKpVgxXz1RCVKulsJ/bZuHAUoa827QErIIzH00XVUSeolXp0k1HOZmbtJe
xrUkA+hvKhCw+cJaft/ifJWyO9+AorM7CGBJvJtSYuqjUp4rB5+Bl4T/8IHVNgtX
rl74RJhGjAjgSzIE+HlBKIiOD1DL8A==
=hW06
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
