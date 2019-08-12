Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76930C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBCD20842
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565606193;
	bh=NpUL2HKziv9W7bNy4oKgFuCdzZMEfMfgORZx+fTlVOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eAgtKIQDpwQzaW2HAIwd9uxJqJWK9kLfYwsSO3pkXKluTXC7dlujXwMGhQRGOg3HH
	 8k1if8vkPDt9pDoAxJK1jybzaQnfk8kR1AQaX0QelVx9Gfi7K2hxoxeRRTbOzarhUj
	 2+ECYb8wLwSBi1U20jVT7968mRc1yUjqY6gWcBuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfHLKgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:36:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35860 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfHLKgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NpUL2HKziv9W7bNy4oKgFuCdzZMEfMfgORZx+fTlVOI=; b=QAcmbEfmc8fAQ9N2qowiCEotB
        9tSfgkot9LsBPVGpebpOMbeuX3f63HMDKHd2aVAtSh+fJ1q8HFi3/zYzwLmnof93mbkUgqJ8I2agz
        xGuUvzwXlt2KABq9uIbl950kfULKAHzFhDqOV9jYGl/DH0KVOlPyTr6DDftFVZH+i6tTo=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hx7gj-0000rU-NH; Mon, 12 Aug 2019 10:36:29 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 4C8DA27430B7; Mon, 12 Aug 2019 11:36:28 +0100 (BST)
Date:   Mon, 12 Aug 2019 11:36:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 07/16] spi: remove w90x900 driver
Message-ID: <20190812103628.GA4592@sirena.co.uk>
References: <20190809202749.742267-1-arnd@arndb.de>
 <20190809202749.742267-8-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20190809202749.742267-8-arnd@arndb.de>
X-Cookie: Decaffeinated coffee?  Just Say No.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 09, 2019 at 10:27:35PM +0200, Arnd Bergmann wrote:
> The ARM w90x900 platform is getting removed, so this driver is obsolete.

Acked-by: Mark Brown <broonie@kernel.org>

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1RQSkACgkQJNaLcl1U
h9CDjQf/RnQEad1Kg30+vtpDmN4Xrm5TRgeg5j/scALpOxLR2dbuo7W788H3DPuA
j/o36yT6ruzAkmiZ0jOXFx62DMB2HEOstaCSQbJ2hJphSjzRpvRAGFn9oCUecEiS
Jh41nOEfDJKXG7NlZ3gGEdnnBaUBoVFg3eK9ayy/ooMOUClclN/m2wkujFMMsCGV
upLOPCtPBmibARDCJAq5ia5UukfEV9jP1Era0d8GW6y4feTpz7+dbDs2DqnUW9zU
3o3g69PFW2TKNBl4df2conTNaNzFBroTBGTzuR1rUZT24yx5z48pZsL8l67vrKVi
qazVXvhlE78RDYJtNz8ie8tIY6apkg==
=yqU8
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
