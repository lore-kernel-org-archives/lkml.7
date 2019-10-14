Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7497ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 11:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8462084B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 11:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571054233;
	bh=gvv+t9IYMH2eIpjpV53O6oFCQz0gtdGii2nY5V57sdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WZeXdbctfZeQHiztiZCOMMTb2rBEWzoEMmLZVQ+WQM3AhVGJytFvg+zT14B2BlCCZ
	 C402yZdW9Lkrmau546bsGtCopdMN/FoQ/3LyM4dVG48Wv+V0HRFXoPlYZARQEEq9B5
	 Cy1KmE6Mjw+B1ToGk5nsdNZuZ0DBpviV0rRGYJNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbfJNL5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 07:57:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49108 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731183AbfJNL5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 07:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jIj/NmY+eyECv3y+bNn8jTjJhywyBUZaIyrJ62db62Y=; b=VUryfWb7iW/HUzgEfXisB6nFM
        8Nd1kC1Yz7pcGsfKBvwBfL4mcWp+8hirqhUrBmCrEToeay24b9nXEsxPLIIxfT2eokan9Q4P2rMNz
        hiGsI6fp4sKiAyloGyJN/7oRf0FOfl9Q9KJ5P5SK3lFQ9ujfJauD6Q7joVxcxHbXwEaMQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iJyxo-0007VP-0K; Mon, 14 Oct 2019 11:56:36 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3C3552741EED; Mon, 14 Oct 2019 12:56:35 +0100 (BST)
Date:   Mon, 14 Oct 2019 12:56:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [RFC PATCH 2/2] ASoC: simple-card: Add documentation for
 force-dpcm property
Message-ID: <20191014115635.GB4826@sirena.co.uk>
References: <20191013190014.32138-1-daniel.baluta@nxp.com>
 <20191013190014.32138-3-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
In-Reply-To: <20191013190014.32138-3-daniel.baluta@nxp.com>
X-Cookie: Androphobia:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 13, 2019 at 10:00:14PM +0300, Daniel Baluta wrote:

> This property can be global in which case all links created will be DPCM
> or present in certian dai-link subnode in which case only that specific
> link is forced to be DPCM.

> +- force-dpcm				: Indicates dai-link is always DPCM.

DPCM is an implementation detail of Linux (and one that we want to phase
out going forwards too), we shouldn't be putting it in the DT bindings
where it becomes an ABI.

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2kYnIACgkQJNaLcl1U
h9AJzAf+L30WoNHHnOrkkpLMsmM6uZcu7czOKRKOJyZ35878jKwHbjZap1z9TOLG
ivJDyoiRoLYg4twQJcl7Rt/I7WytvqTEkhzju5+LWpRuB+fFtdBjwK0p0rXZbj1E
6wWWkfnGi5NgxPGa0FSCwLUkIwPtrsd3Rwxbwk6n+kekbJxEYK9UzkGOydcIIgez
ie6lZRh515nxc2sohfBhM3//verg1jHxxG6sA0cMQ+hHwdzgIzfXzsHXlYw9M/pm
Z9KNu7+EiJ0gefb6XXCbqfJQ+B37sibpl+10EeiUIHIW2bjOl1w+LJgRJzb6nFK8
j60W+/cODoUMQWboKCkQ+oTUEHuDXg==
=SivO
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
