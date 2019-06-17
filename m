Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A83C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129A5208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560785586;
	bh=nrWtFau8QBbmJF7FXKx0ywmXxDO07oH0XZFBBdNfoao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NzISkN9uEo5MCU3Oe8BPklDfZiSGULDFs7OfQtHjoOhnES0SzmWwtjKjvez/XEPsl
	 KQ5UKSKbFP4+VW6h/R1bpRdXChSSYSHrvQMvdEgD6XEiMUbUNDHCGaJ+yIv2knn9dT
	 5l4rx9NZbORWtRZOAoUr2+wjvUuWd1H2xLbjBCx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfFQPdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:33:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37670 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbfFQPdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5n0Qq04gxXCu8dSk6/GBEW6XU3aU7NpprL9AD2yLI6g=; b=hiRVBALxOUt+f2Xln66yAjcFU
        +CB+qC6AJi4nr/B3jLVAirvAqzTTBP6zUsVPdWTxRwc/3iNOuNNyCMryfoQuL5x7OyZrpvxHmdbs9
        BqzK0HSJ84d3dMQPYsKrbAcrYNkgeC1oVRg/yEdc7y6ntQwQz/H1CH97C4af8u2K/pnTs=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hctcy-00021I-5Z; Mon, 17 Jun 2019 15:33:00 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 490DA440046; Mon, 17 Jun 2019 16:32:59 +0100 (BST)
Date:   Mon, 17 Jun 2019 16:32:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] regulator: core: Expose some of core functions
Message-ID: <20190617153259.GZ5316@sirena.org.uk>
References: <20190603235904.19097-1-digetx@gmail.com>
 <20190603235904.19097-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GjiSaFH9IIUbbImY"
Content-Disposition: inline
In-Reply-To: <20190603235904.19097-4-digetx@gmail.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GjiSaFH9IIUbbImY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 04, 2019 at 02:58:59AM +0300, Dmitry Osipenko wrote:
> Expose some of internal functions that are required for implementation of
> customized regulator couplers.

>  include/linux/regulator/driver.h | 11 ++++++

I'm a bit dubious about exposing any of this but there's no way we
should be exposing it directly to random drivers, this needs a new
header so it's more obvious that normal code shouldn't be using these
interfaces.

--GjiSaFH9IIUbbImY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0HsqoACgkQJNaLcl1U
h9A0Jwf+IR3w3BeDt0vdH+/tUjf9Ma255H7SF8BeBA+QxDBtM2j5UeC3xo7WVFBM
J8RwyLm3u2q84WMZ4G2VD+jQD1BFEdyFOcD0Qa3JMCg07qJty29rwxrlR3H7TwtA
B56FIFL4l3buz2un6cybfGKXNDmSRi8G37g41EnTry7TwtdIJJmK4zGeawbMNBzg
2O2b34F1+V9+Oq8Jv/Ysl+Tl9gDIo0M4fqlLBtV6I5D7vA73OyamjvcRlBNqnXys
X8uXAO0/BI+Ghb5OPb9P7ljHLvlI0lwv/gd7Qhfc0otz+wAqReoJl5kMz3KhAmtt
Vkf2MxU0jPJupMmknxRUVwkCNqg3hw==
=Wtow
-----END PGP SIGNATURE-----

--GjiSaFH9IIUbbImY--
