Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91164C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C272075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553715137;
	bh=CMCpaVhDmDcoWRphIWIaRtDVI7E2LveCJahY9SuRQE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ovbswV7mRRA45C5YgEaShGpX9niqL6/fOk8NMd+xF19+o7VaE/lZ/DJU/HacPzs4w
	 bzx6fKpxjfIOESIC9zSrGde28ttjOinJyvf2IIp1yu/wLQUv+sFL/ctLhG2pWWUk2H
	 lsYLd9J+GI4Z7rzl7p9R3CMPBTXShHD6WySOW6s8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388279AbfC0TcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:32:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58404 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbfC0TcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Fk+ZaCMLnd5JH2GGV0Aw/dB1Oh2T25U9JuYmOwtZ+bE=; b=UQKP9zuH+hZByJU0EdTRd8RaE
        TU7YLNq63nTPyekzZ+XOtS6LzEulU2UT9UDH6dLd5YQE4uEsxiYtu2gnkSf5Q/vFedlDy6yGpIAQF
        OYfc6EawJp3RaRrpjT582fOb4vcmrdGy7fZEA4KoN2c5SGtcDCsqfN2++Nk81DNSK3/AM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h9EHT-0000ij-U2; Wed, 27 Mar 2019 19:32:11 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8065D1128E50; Wed, 27 Mar 2019 19:32:11 +0000 (GMT)
Date:   Wed, 27 Mar 2019 19:32:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH AUTOSEL 5.0 209/262] regulator: mcp16502: Include
 linux/gpio/consumer.h to fix build error
Message-ID: <20190327193211.GC11404@sirena.org.uk>
References: <20190327180158.10245-1-sashal@kernel.org>
 <20190327180158.10245-209-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Content-Disposition: inline
In-Reply-To: <20190327180158.10245-209-sashal@kernel.org>
X-Cookie: May be too intense for some viewers.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2019 at 02:01:04PM -0400, Sasha Levin wrote:
> From: Axel Lin <axel.lin@ingics.com>
>=20
> [ Upstream commit f3c6a1a194317f3a31ee2b2067bb0a41de64bc8b ]
>=20
> Fix below build error:
> drivers/regulator/mcp16502.c: In function =E2=80=98mcp16502_gpio_set_mode=
=E2=80=99:
> drivers/regulator/mcp16502.c:135:3: error: implicit declaration of functi=
on =E2=80=98gpiod_set_value=E2=80=99; did you mean =E2=80=98gpio_set_value=
=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>    gpiod_set_value(mcp->lpm, 0);

Does this error actually manifest in v5.0?

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlybz7oACgkQJNaLcl1U
h9BejAf9GlvrAtMOeojVFXCPXf2+IE88vxo1323ksrIKNMY++bF6nM6JnUbXD+dn
f14gH8/aa7UChCWHMqfhP5ZYhKrEzO31mLylUInFZgwRyv9HlsXMCNRuRSgC4Ppp
G69x0R1+/JxxkScc4GCeaTZ/TFO0De1tOdOCAVNVOGuGCbDxkYG10p3Q0btTTxfq
dW/6reZdemqne+IdkUoqNttsF9HMxNLR70zVfXDowNjP140A9CU3oM+jD2SRCaNb
ZbmmgxweORr3s2/MPNgqWp/fIIMKPP8vFr3IlkCAFQe7p3SnP4npkAipla2kSPUs
kcMROaawLmiso3/uS7ENHm0E6lQ1/Q==
=wrRX
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--
