Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CC1C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349D220857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554708151;
	bh=kjpyB2qay5tHjTtMtL3Jp0bStANyEsieV9qDpUX+83Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wIQcL8AbYlEJlVcFG3A19V1yqnw/1srOxFCOSaLc1osSeOhYPXL6VjtPfSCjpwOV7
	 FVCZBx0Xr63D2xKdaZAupg/4vY3uVN4mlCYFIGwUfrTeWGuWe5wyvSNlwezqoxuLKC
	 PNivHMTyAp0OeTaFugTmarHWQvp4MjYUGXpyQWbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfDHHWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:22:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55348 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfDHHW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WKn9Q19sjk+ei/BCk8jaN1m1VGj6cilDYm/WkWrvljM=; b=kodxnnVTQuX8MeL1szeJbfjtG
        +Ixz/+CyauBympUQE3ivBxDAHSQ8oJdo99R9k/fsrzfL2LQzP3iuhvVORDYxu2e17eftkremJfynW
        5sS/qKljLq9MI3oWLlQIwRmlTtb+ootOYscQEVopPmqTqeskXVxA/rRoGrEtmrEFAHMgk=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDObn-0003n3-4Q; Mon, 08 Apr 2019 07:22:24 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 6AF67441D3B; Mon,  8 Apr 2019 14:22:11 +0700 (+07)
Date:   Mon, 8 Apr 2019 14:22:11 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kyarlagadda@nvidia.com,
        ldewangan@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 19/20] DT bindings: spi: document tx/rx clock delay
 properties
Message-ID: <20190408072211.GL2803@sirena.org.uk>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
 <1554423259-26056-19-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bzq2cJcN05fcPrs+"
Content-Disposition: inline
In-Reply-To: <1554423259-26056-19-git-send-email-skomatineni@nvidia.com>
X-Cookie: Shah, shah!  Ayatollah you so!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Bzq2cJcN05fcPrs+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 04, 2019 at 05:14:18PM -0700, Sowjanya Komatineni wrote:
> Tegra SPI controller has TX and RX trimmers to tuning the delay of
> SPI master clock with respect to the data.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--Bzq2cJcN05fcPrs+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyq9qIACgkQJNaLcl1U
h9CL1Qf+Jzho0wXetIigWcaXeklQTCcQGD/HvADTvRefQVzgKGRbdbYM7XofM95W
d6UkqYM3UZokgjeqckpNZ0YsvlMkUJDXcTAldSA91XHo/rPfnM6VEAtIHLYNZ60K
DyHx7b+AETu8NGFx916xDLSnkzibjXM66JSR/P9IQANLHBiU8xIYWIJ5pHTO2j1h
5Hq9gjGcLRvldhmwpk8OlNSak7MlOb+EYwmKMMvFvLWaivr9w+gyNbtwELL6GaUx
XP9wCV1ZFJs3cKxSg7IL1etBKbvVny/1suM08+0IlniqYDQdlA3LRqQuk4+unkRd
OePcmB7Ut740XUhSQH6ZmV6CykWsQw==
=trro
-----END PGP SIGNATURE-----

--Bzq2cJcN05fcPrs+--
