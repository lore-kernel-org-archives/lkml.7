Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FECDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD8820830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553529805;
	bh=Afftre6Ed7JOJz2vNBjWQDp51qKacbwjGeOdXsOzG5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CEjFqHw9SUWwFXsmHc6lwfe++0DOcBg1tI17MkZWHGYPp2TlXFjibjdDaBhvM0yMa
	 q1Fx+dDnIeg/wrKmhM64576JjjXGYaih6+QtfQNJAT4hkXDLGvoTtqn2TYH2MUMz6k
	 3W5Yb/yTr6HzPH4FgoCrG3DWSBE5l+Ec0yRsMAQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfCYQDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:03:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40150 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCYQDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bVatkp1ZOcVOBlKz/e+XJrjrAYMID8wn3F0WJ//LFdM=; b=hmkmYQvmSVfrtNTvQ/7zrh1UT
        L+l6Off4RPoxge/R7435f19CK1kpFLWK2K8CQe2inrZf46AQJ788saGqDXGeAqCaR5RghqhvtScRI
        yOfiSb1iMFiBM9Gu8V3MgcLkO6T4N0qnsm23GwFExARH6HO0IyPNeNG+6zfgwNdVZi4Ds=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h8S4A-0002cY-6t; Mon, 25 Mar 2019 16:03:14 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 76CBB11288F1; Mon, 25 Mar 2019 16:03:13 +0000 (GMT)
Date:   Mon, 25 Mar 2019 16:03:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: stm32-qspi: add spi_master_put in release
 function
Message-ID: <20190325160313.GJ7284@sirena.org.uk>
References: <1553265354-16433-1-git-send-email-ludovic.Barre@st.com>
 <1553265354-16433-2-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tAmVnWIZ6lqEAvSf"
Content-Disposition: inline
In-Reply-To: <1553265354-16433-2-git-send-email-ludovic.Barre@st.com>
X-Cookie: Short people get rained on last.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tAmVnWIZ6lqEAvSf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2019 at 03:35:53PM +0100, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>=20
> This patch adds spi_master_put in release function
> to drop the controller's refcount.

I'm getting build errors with this:

  CC      drivers/spi/spi-stm32-qspi.o
drivers/spi/spi-stm32-qspi.c: In function =E2=80=98stm32_qspi_probe=E2=80=
=99:
drivers/spi/spi-stm32-qspi.c:430:8: error: =E2=80=98struct stm32_qspi=E2=80=
=99 has no member named =E2=80=98phys_base=E2=80=99; did you mean =E2=80=98=
io_base=E2=80=99?
  qspi->phys_base =3D res->start;
        ^~~~~~~~~
        io_base

--tAmVnWIZ6lqEAvSf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyY+8AACgkQJNaLcl1U
h9B0aQf/fdWpPjnowIBjcy1bnS1nYt1V/UZopHw918CDYM0j/ws6gqcZ6hliRlSB
2WhwMUaq4th49OQOitBHw/kDyQAS7gkfvHhg9LyEL0B5nkVnQDTN8pfnsRj7b/5N
fjG2AM6bMKjeiyUl97ObpJrDPvNUi6Gp/RwAXVlFLEXMKrN5vnnzaQYEfpctAFp5
JBMc6n9Qp2Ao5jAHb6Kw0yGqnrFvDDz/Rnp03ofXJJI4T+lvtwp+rUz2R3ZzyRlC
SHP68Lapg/Jk+AQ3EQexlyR3SpOezzpiDRH4iECxNH98nNX3WmUQJ5u8WjMTGU75
0eNyyzqbd0DM8wXYWOd0QSHCV0JCaA==
=T4u8
-----END PGP SIGNATURE-----

--tAmVnWIZ6lqEAvSf--
