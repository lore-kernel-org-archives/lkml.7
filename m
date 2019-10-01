Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089AFC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D608B20679
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569951672;
	bh=BS1G/n24oaaEFfyJtjy4OEJCNTLWMyXODCacVBFL6sY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HqZBkSs9XE4xYg0PGMvu8vpqbQMSe1TkgrXH8qQiirOqF/SpQnditLS3h9sngEx+u
	 mfKKpi8EWAq+v/pcHVgDykdN+B0v5RpZKdceeLpAngPcanun4Uj6wCwoYOt0hYjicb
	 JzzDB7uB4v5NW9qheOqGFeL1LEwsLV7aqBnbtavU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbfJARlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:41:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53448 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfJARlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6PHfJPpmmbQhxMK6M7AY9ix0LgB6D7xNSfISfBov93M=; b=SPik2K5YFCus0OmRBE4TFg6f0
        hCSr5oyR5SNPGXhUt/7Cj/GKlOYMdykbv51DkyGouCBPFnU946I8Bw6lvmehLd3APpkkLYEb4TWrZ
        f9oZEdtIhBSAiP0cSjnl7K4wm9A81KRkOIX1XFRBY7iTXlk6RsUBqEnv7pQjbnA7wD/TU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFM93-0005on-G0; Tue, 01 Oct 2019 17:41:05 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id A0C4127429C0; Tue,  1 Oct 2019 18:41:04 +0100 (BST)
Date:   Tue, 1 Oct 2019 18:41:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        ckeepax@opensource.cirrus.com, zhang.chunyan@linaro.org,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] regulator: Document "regulator-boot-on" binding more
 thoroughly
Message-ID: <20191001174104.GD4786@sirena.co.uk>
References: <20190926124115.1.Ice34ad5970a375c3c03cb15c3859b3ee501561bf@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline
In-Reply-To: <20190926124115.1.Ice34ad5970a375c3c03cb15c3859b3ee501561bf@changeid>
X-Cookie: Keep refrigerated.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 26, 2019 at 12:41:18PM -0700, Douglas Anderson wrote:

> -    description: bootloader/firmware enabled regulator
> +    description: bootloader/firmware enabled regulator.
> +      It's expected that this regulator was left on by the bootloader.
> +      If the bootloader didn't leave it on then OS should turn it on
> +      at boot but shouldn't prevent it from being turned off later.

This is good...

> +      This property is intended to only be used for regulators where
> +      Linux cannot read the state of the regulator at bootup.

...but we shouldn't say "Linux" here since the DT binding is for all
OSs, not just Linux.  I'd say "software" instead.  Really the
expectation is that things wouldn't support readback at all, though it's
possible there's some weird hardware out there that will support
readback some of the time I guess.

--48TaNjbzBVislYPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2Tj68ACgkQJNaLcl1U
h9CRrgf+OhK++Wg53aKS5GOG5Scxu88CKfhRSgAezLcnGjLTBX16YijOdZNEM3yX
+eknFRwLl189sJOTSGpO+skgW1BNVYJac8PHCk8wviVL5APiFqIMkGNNIcPQZnQc
gJQFBLCnBO6RSqMiT98i0YK5Qes492NNap2lWKl+a7OvwXHo4onrdE9oYZcwmMVj
DqsJAf+7VPG+BT1nIqJVL4jTuZeAWFyWMKaUMDFWmWev0RDEMF+bHXFMf2pFtkzj
LfvVrsc7/JgU35ruEO3vCrJnDOS1Z4mplIKKFiAn/41OByNYePUx0RzdOHwinpT8
Q9w5NkdPaasBpx6zg7XiXlwSjLScfg==
=INGH
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--
