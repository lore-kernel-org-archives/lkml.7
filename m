Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83519C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504022082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554197536;
	bh=VL1IQsYJq3jztzAFgXzFafyxvpq7ZRyhIynuLQXO/lU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KdRTZCrjPh4xMdwbQ81v4/QSv8HMwurdIcosUxjgqiI/Q+w1m5BrBa3U1VpA2Xa9v
	 gbRrz4x/YwyZyaczOw/xMJt2IPX6lDyfhkJWolcevgEOhTvpQdm9AoBTuoxokfJGfy
	 TYXKD2+kxQijC+UDc4u255ti2/B2SpJBB1yMXbxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbfDBJcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:32:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57988 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfDBJcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CtCVmWF/BeSxfSbv7LaAk/mOoYaPRqpoqMYKrqxqLcE=; b=S8W/XlcoJKCzfaFqeTQji7rAx
        hidw1aY5r0CWzkcY6LTysDvWsv0Mbo39P8ZrXs3dhSTom+nZXRull7/I4AVrj/QjDljo7Gazuu+hf
        D3rF90uiwvRGwIBJzbvxsiNEAy0Jy/gsvusetTc4PL6xBO7Yav5E1z3oMC7DSO7Wlo9u4=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBFlz-0006nG-A6; Tue, 02 Apr 2019 09:32:03 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 9B5F6440082; Tue,  2 Apr 2019 10:31:59 +0100 (BST)
Date:   Tue, 2 Apr 2019 16:31:59 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Curtis Malainey <cujomalainey@google.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] ASoC: soc-core: Fix probe deferral following prelink
 failure
Message-ID: <20190402093159.GF2059@sirena.org.uk>
References: <1551706274-22571-1-git-send-email-jonathanh@nvidia.com>
 <4eb94b41-7e16-7b39-5c14-a7d180ce67df@nvidia.com>
 <20190402043509.GQ2059@sirena.org.uk>
 <2d8a0569-b821-c0c0-af39-d3863d17f47f@nvidia.com>
 <20190402091955.GE2059@sirena.org.uk>
 <10d454a4-e1e1-3a4b-8400-acd680d75a3d@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ExIO7AL6tcaLjJBF"
Content-Disposition: inline
In-Reply-To: <10d454a4-e1e1-3a4b-8400-acd680d75a3d@nvidia.com>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ExIO7AL6tcaLjJBF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 02, 2019 at 10:30:34AM +0100, Jon Hunter wrote:
> On 02/04/2019 10:19, Mark Brown wrote:

> > Oh, if I've applied that's why I don't have it any more.  Indeed it's
> > applied in my 5.1 branch so I don't know what you're expecting here?

> Well I still don't see it in the mainline branch and some boards are
> still failing to register soundcards with v5.1-rc3 because this is
> missing. So I am wondering what has happened to the change. It seems it
> has been dropped.

You can check to see what's in my tree by looking at it directly or at
-next.

--ExIO7AL6tcaLjJBF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyjLA4ACgkQJNaLcl1U
h9A1+wf+MuG8N763r1I+LvdFPfgQpxNEVZPSj4mjqMMge36/LhHGE5zs5TghmDjL
CCKzt46YWc9OVZzwRdWvgVZh0JB3mhJDV2+jrrJvJoS5W/NMDYNpfOZxtOiFU/6I
4KcomG7ArPB51w2YnpD2g2QebPF8AII4+hHNqwYWfL+wSohU9HGgylV5YbwZt22Y
OdtVulgLA4iMt1H/4PI6X6dNtIljV0N/ERwmKjNzc1FmK5xUS7EIvKpfMJDRN29x
jWskMzGktlug3FzQtbI7M/3mbMYJxkH+A9CyWsYRL8FR6gFYhO1vJWaAngfA3dD6
OAlNY2IdaHh6RmKYX5PJXj2/nwsIpQ==
=e5Lx
-----END PGP SIGNATURE-----

--ExIO7AL6tcaLjJBF--
