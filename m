Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F815C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247DE2146F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557680745;
	bh=KJwpJGQx7wMPwZuFQD4Xj5LQRS1Zg6qPUXTGykk0TqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FPjKmF+LmXFzsCh0rugXLp4m+joAWw5j/1HvMW6GsZu7p1tAdrF5IIL1swPINXsvo
	 Hia6fNKYb+yfh1OQYRiDqoHbGfYdBiDRAKPqka3wCoG/FFPbcPSBlvmfoxnNMZzhYI
	 ggHyuBBwK+YVfettEk7X5OX84Xe6G2xMRlqrl0Tw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfELRFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 13:05:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49326 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfELRFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 13:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KJwpJGQx7wMPwZuFQD4Xj5LQRS1Zg6qPUXTGykk0TqY=; b=ZTn4espIgdpj7vgG+IP2gEdT/
        3KBCIf8lRU7WrYMs9tSJbOFEGsIbImm9aYrQjdxIVGDeEB8AFDUGyR2P1wXILCzaS7gb94P0LD5o4
        7uF4dHa795ZlL7qVdllzhK5fmMz/0CrAJPVeUJsNpCIkxIRzGbb0TkO5QL84kNzHaqvSo=;
Received: from [81.145.206.43] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hPruu-00044o-Ag; Sun, 12 May 2019 17:05:40 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 69893440064; Sun, 12 May 2019 10:06:27 +0100 (BST)
Date:   Sun, 12 May 2019 18:06:27 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 5/6] soc/tegra: regulators: Add regulators coupler
 for Tegra20
Message-ID: <20190512090627.GO21483@sirena.org.uk>
References: <20190414175939.12368-1-digetx@gmail.com>
 <20190414175939.12368-6-digetx@gmail.com>
 <20190508075706.GW14916@sirena.org.uk>
 <9756d8ca-0778-5185-5b6b-3168d63819ec@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DRfr/2Y1Zz/5r+Kb"
Content-Disposition: inline
In-Reply-To: <9756d8ca-0778-5185-5b6b-3168d63819ec@gmail.com>
X-Cookie: HOST SYSTEM RESPONDING, PROBABLY UP...
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DRfr/2Y1Zz/5r+Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 08, 2019 at 04:10:58PM +0300, Dmitry Osipenko wrote:

> 1) CORE and RTC have max-spread voltage of 170mV.
> 2) CORE and RTC voltages must be higher than the CPU voltage by at least
> 120mV.

This seems like it should be easy enough to describe - we just need
minimum and maximum spreads between pairs of rails.

--DRfr/2Y1Zz/5r+Kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzX4hIACgkQJNaLcl1U
h9A5TQf/blHJSlXwfDTeB7y4cB421y3ptVKoJD6BlCl1CMMkfYxarqomyCybWbOs
0Y15BUjBQCWrggGmMc05Z1gXwp4NqIzfrKWq7FXpUccH5lukp50IBMauQn9eDxsT
pXP7ZwWNHvo7UXDODHoNahiAhBbLdOi6YnLKp9EarO4YD/TJ83NbqdtceQ1m8Upr
z65FekjYssye1HXZWAqrOKl1eW/0UnvqAUuzJNuKmpeIHuppCNRuH/2SMM07f3WH
b5B2oZZMSsFiVcpvTtO2iD4Zv01beijvLa5q05cozYGTGp4bjcA1keiMGMNwI8Po
1jmOEzyyxn0nBbcQUuEU34pMIl+jbA==
=cTGZ
-----END PGP SIGNATURE-----

--DRfr/2Y1Zz/5r+Kb--
