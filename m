Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D757C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B89A21530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557303250;
	bh=WhnysPOirrt1DrR0x644ScRFfc9EAtcJqNjTBQeoFiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VyPJIRhBoGxUpSprYnW3le5YoOFrqi2zbNvAdd7hMSUP/icyJMdWjHWfOut+I82a4
	 B455R1wKOr/5HsOVtN0pj038soPFxw9HBRR0sW/E+gWDX2q0/iG5UWIf5Qo5c9UO8B
	 ah6gYvrQF1Ht8N5HM0Q26dituMAYwmT5MDQj69yE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfEHIOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:14:08 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49488 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfEHIOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WhnysPOirrt1DrR0x644ScRFfc9EAtcJqNjTBQeoFiM=; b=wWSeSXbwvJpYsldXVtPQpCUFj
        JYlr2xejylzZ6BKn4YD+0Ixk86373GqeyKIo/nobIrwNChDbcd/KUIwte7j9vesBCwhkuW0s53Ben
        JPK9gU6oRvhTRLHSllrBMXjz190TKBNZKsPLNirAhGWbjySe0+6hwIFEBouHoh2ySXcdw=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOHiD-0007RW-PC; Wed, 08 May 2019 08:14:02 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id B32C1440036; Wed,  8 May 2019 09:05:13 +0100 (BST)
Date:   Wed, 8 May 2019 17:05:13 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/6] Introduce machine-specific regulators
 coupling API
Message-ID: <20190508080513.GY14916@sirena.org.uk>
References: <20190414175939.12368-1-digetx@gmail.com>
 <46665d2d-aeda-4b63-1d0e-1599214e7bae@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CpRwOJvrTIYkeTuO"
Content-Disposition: inline
In-Reply-To: <46665d2d-aeda-4b63-1d0e-1599214e7bae@gmail.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CpRwOJvrTIYkeTuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 05, 2019 at 05:57:42PM +0300, Dmitry Osipenko wrote:

> after bootloader. Currently, in this patchset, we are not allowing CORE
> voltage to go lower than the level left after bootloader and once all
> the relevant drivers will get support for the voltage management, we
> should be able to unhold the lower CORE voltages around late_init().

That's going to break as soon as someone like a distro builds drivers as
modules, you can't rely on things getting done at any particular point
in initialization or indeed on any given set of drivers being available
in the particular kernel that the user chooses to run - if they decide
not to build drivers for devices that they don't use on their particular
system that should work.

Overall this feels like an abstraction failure and you've not really
said what the constraints you're trying to implement here are so it's
hard to tell if that's the case or not.

--CpRwOJvrTIYkeTuO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSjbgACgkQJNaLcl1U
h9BIygf/UDsx2Mvn6tUgdKjwd2FK4/61FyNOrCOHq8yIsQJaCv+pAISiYiBYbZJV
p1MMMbjsrGO+2p3hcXsGgK8/lGtKwMK2zHLlQW2ZOK3rShmBXfA5W1uyunwj78Tu
6d+RB51jWzFUKI9wuGkGlv8G4kP4duFpuyzd8ENLpO5toHD0CuE+twv/mS/WXMN2
4KR7WgYaCeztK1zWhBbhViu0H0hTSq49GRCeQLt67dQdchGU19N/rO27cm1iwbjk
LLGRIEhXyfn6GkZDl3YiTTrkYpfRm9eROQEzGm0oG5aMe/ZtZ4XFGxdiQWzqSfjl
AXWIb8nqZkseDVV4WfRJIdJveYS0+A==
=cGV4
-----END PGP SIGNATURE-----

--CpRwOJvrTIYkeTuO--
