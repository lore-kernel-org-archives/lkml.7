Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CFFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2C72083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554889068;
	bh=3kO5umoLV+Zp9+WfL25lxYJDDZGvUFfkNNjuK/HkpTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZomRpL/UUI4nvWrTvxOb7Ep7xkGjsQa3t0DPYTn3lYLCDDvYX6XW9t1Wp1YYi526l
	 pQfH7M55eqRIiBBKlFwvDbyVlJfplCQndGmqGQoTCzEs3TGR99U0trdc5VjPntWQDv
	 vpvxjHE/SueNTBwmHJSMjknm54sO92ejXqtv/Oq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbfDJJhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:37:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33488 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbfDJJhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sTySuJ3uSEbYJqEtVFEIslJYrbNyzomjAmVxCe+9Q68=; b=MReoCFngLXipuXrWa74Axd2+L
        QvUYJ8EVl68TwQf9BTDYGfo1xGGm8WkObxZAvOBOKBpz6NMIlBCVrRhe3ih3bPLNz60pfdYxQ8o01
        GJBKfkAhFkTr6S/Ey25b7ddaiznHUYEuUWfbW8WW463z3+DIhVGCkeWnFfo3Wy+eQQPdY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hE9fR-0007Ju-9d; Wed, 10 Apr 2019 09:37:17 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C15971128E83; Wed, 10 Apr 2019 10:37:16 +0100 (BST)
Date:   Wed, 10 Apr 2019 10:37:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        dwmw2@infradead.org, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, computersforpeace@gmal.com,
        paul.burton@mips.com, stefan@agner.ch, christophe.kerello@st.com,
        liang.yang@amlogic.com, geert@linux-m68k.org,
        devicetree@vger.kernel.org, marcel.ziswiler@toradex.com,
        linux-mtd@lists.infradead.org, richard@nod.at,
        miquel.raynal@bootlin.com, juliensu@mxic.com.tw,
        zhengxunli@mxic.com.tw
Subject: Re: [PATCH v2 3/4] spi: Add MFD for Macronix MX25F0A SPI controller
 driver
Message-ID: <20190410093716.GC6106@sirena.org.uk>
References: <1554777000-10542-1-git-send-email-masonccyang@mxic.com.tw>
 <1554777000-10542-4-git-send-email-masonccyang@mxic.com.tw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Content-Disposition: inline
In-Reply-To: <1554777000-10542-4-git-send-email-masonccyang@mxic.com.tw>
X-Cookie: teamwork, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2019 at 10:29:59AM +0800, Mason Yang wrote:
> Add a MFD driver for Macronix MX25F0A SPI controller.
>=20
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  drivers/spi/spi-mxic.c | 275 +++++++++----------------------------------=
------

This isn't adding a new MFD driver, this is a substantial refactoring of
the SPI driver which doesn't touch SPI at all.

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlytuUsACgkQJNaLcl1U
h9AeQgf8Cq4PSo+iWmspUorVUXm+K5G5aUI3052g+2/+hl0mEaCt7grEKFmiY6ef
xWMpNCd1tocLecIJxAyiipHfJQDpA4hrpRhZaXkbJAG6LXwXfjK2l8YCnzHpSd43
zGBQvVlwNIpqjYv8/YmFXe92QFk6XNPhhofK83HennndKm5ZwjF+vJTa8ZDdPhR5
oikRqtPYEs9ONDwKPL0WRzWBq05uRoe7MjE6tfAqwahQC7paVJCgv40S51m7FUZQ
dv5NyqAfA+piR5zFrrk5QR3GEX3+Hh2pudJjRCSjY8QQkyULl4hT2ehjanj4uWj9
bH4xjLtxOcgcsSxo4wM6vyVNDEffnQ==
=oPnu
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
