Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DC5CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 19:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D8020869
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 19:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571428252;
	bh=5W2MZ6xOjT3rUmNYohhNKwwhH+vTrvp3RdgWLAsapxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vCbnzCuMpLF154CaLMSnza6/JV4iOlG+NRa4xcW9pn2FIyv38659xv7jBtyI2eWyy
	 IYDNYhaeecqSZhNqvzP3Ay9afcmKDgOUV2URRyRRSRlVeaySf/GaDA6YeopDuzEybr
	 6w6Dx0PacQLS4ZhysocfzQoSFx2MqT0rYTonbm2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440287AbfJRTuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 15:50:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49954 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730242AbfJRTuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 15:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5W2MZ6xOjT3rUmNYohhNKwwhH+vTrvp3RdgWLAsapxU=; b=B9aHtsFqHcDxVJCQRjc78gGyf
        UGwcbGcDV30yNqjArxM6/YO6cPJcHJ2paHdLXtcUqrCjKyibY124mVSNDlztlzCLbuZvCcvGd7bW1
        FEwcBkvqhJ9eQ7WJ7sGvQ1O978SsnqGXmIAMa+sjL5hlFbplXeAobCXfOmetiWX7T3xqk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iLYGs-0004XJ-F9; Fri, 18 Oct 2019 19:50:46 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id E6D372741DEA; Fri, 18 Oct 2019 20:50:45 +0100 (BST)
Date:   Fri, 18 Oct 2019 20:50:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Clean-up regulator '-supply' schemas
Message-ID: <20191018195045.GG4828@sirena.co.uk>
References: <20191011190231.9779-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BzCohdixPhurzSK4"
Content-Disposition: inline
In-Reply-To: <20191011190231.9779-1-robh@kernel.org>
X-Cookie: Smear the road with a runner!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BzCohdixPhurzSK4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 11, 2019 at 02:02:31PM -0500, Rob Herring wrote:
> Regulator '*-supply' properties are always a single phandle, so
> 'maxItems: 1' or a $ref is not necessary. All that's needed is either
> 'true' or an optional 'description'. Following this clean-up, the
> meta-schema will enforce this pattern.

Acked-by: Mark Brown <broonie@kernel.org>

--BzCohdixPhurzSK4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2qF5UACgkQJNaLcl1U
h9Du1Af+NWqdLU69yR6U/BWWRm08fd7klsWRrk2gHbJrdNnxMkHrmzuAZI/Gi6de
janR9xwD+hN52sz7oRmPOP9dcUazmbEmLi0KH6OhLNoiHgKlmp2BbTlKbcj4pzza
nqBAdr1w0fMhaYp1UalQIwZK/5x6k5a9nA/NeMlIsEfgsTxFGTweMPoB+xHtss5m
30RuaeOxfcXPPByIYpc21X9mAngtSCUKkcm8E51mtl5oQlKzTA6S1MwAeSThJXKD
NqZUGWgIxbeQILNbvlluEvikoYYcnpZ+pKMhe533fqJZtViYd9BStL52h8MUcYJ5
Z+BxfShFXYmVxbTC6fR4jgTqffoqww==
=TAPa
-----END PGP SIGNATURE-----

--BzCohdixPhurzSK4--
