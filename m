Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257CDC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA24420693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564488307;
	bh=4xHN5JoqHKamARZpeNV4nfdGOcqIZaC5iBwfGs29oFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bt5ZlsJGjyyBEmR/6A0Hgin6nXokiWBxU46Rk3TU1vZVvKdidEVyngS/y1Lipk0l2
	 eznEXDCBetcpq6bOSZKYSme8C07ouODeDSHlap1s/Gyan3o9Yl+GP8zc4frMR5ZiIq
	 CkGKPt4r260KU+8onsxWmfaS7SW5O/521REyp+eU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfG3MFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:05:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44282 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfG3MFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4xHN5JoqHKamARZpeNV4nfdGOcqIZaC5iBwfGs29oFM=; b=CUbKJOSwv4V3JsWTmEv/hECy/
        jMqU1C6z8dcefdwH5lbwt7prDmE+zhSzcosPTSnuLqxI4wfiepZlCmFq7y6DZEe0AzuBKAXdfNpSp
        rNrBwa5r1HyOfspwdp/epPoOwnVTPqXusLgTpf4xfjngkv+MsBb/DC3sZWPXByFoab90U=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hsQsC-0007Ly-Ey; Tue, 30 Jul 2019 12:04:56 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 920E72742CB5; Tue, 30 Jul 2019 13:04:55 +0100 (BST)
Date:   Tue, 30 Jul 2019 13:04:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Timur Tabi <timur@kernel.org>, Rob Herring <robh@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mihai Serban <mihai.serban@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [alsa-devel] [PATCH v2 7/7] ASoC: dt-bindings: Introduce
 compatible strings for 7ULP and 8MQ
Message-ID: <20190730120455.GA4264@sirena.org.uk>
References: <20190728192429.1514-1-daniel.baluta@nxp.com>
 <20190728192429.1514-8-daniel.baluta@nxp.com>
 <20190730080135.GB5892@Asurada>
 <CAEnQRZAUOzmP2yPb4utyDTnYUDNyqesXJPb5-Ms0tfPy8TMBig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <CAEnQRZAUOzmP2yPb4utyDTnYUDNyqesXJPb5-Ms0tfPy8TMBig@mail.gmail.com>
X-Cookie: Times approximate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 30, 2019 at 03:02:30PM +0300, Daniel Baluta wrote:

> I removed the 'or' on purpose because I don't want to move it
> around each time we add a new compatible.

> Anyhow, I can put it back if this is the convention.

You could convert to the YAML binding format and sidestep the problem a
different way!

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1AMmQACgkQJNaLcl1U
h9AMEAf+L6HeZMKwL3JgS35lz8KJn8puYlz6JlAgu8b5kJD5U15z/ScSQXE8uJOt
CMauZ7x1gmPQXGEdGQHFSFa365yso1EB4MgsReZDTurM0YYdi9I2038gqzLrtKB0
r+avuU0EzhaljA0ZugeMbEN6v5YiZGf2yrlzOFUyyUb83zTCFQsHscmnH+cw5QCH
HhjVqWPaGLUKuPmJRWO8ol9QMKghvRP5y5N2e+Yohj+mb3xNHdHvXN1Qa/G9koeA
uJU3R7ifuKcvxbGmu/HoWpcvfpWVMPyF/ej2BC2i1uKdiwSsvxFrN3OP8EfUlL5p
syfgAj372TEvfhTQ/2190PTyHrr++A==
=VqB7
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
