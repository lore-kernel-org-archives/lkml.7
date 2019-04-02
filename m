Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E70EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD75020857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554196810;
	bh=3mG3iR2NqGNpMvRI2bKkGRI0eJY9PpihAf50d83gcOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uSp8elMCG6lG+O/Hms+cIX6EfYl744FTNoKIatMQU/+m4p1EOoeciRVVatRyH2Lom
	 SbZG2O11JAtPGzFSf/5/ouaHe/Kg8IFYKypd4sHqhg8rUbEH9XjH/XkQZ0Va59PUGQ
	 tOB0mAAaPHky+DpZhEckvYyfpA+U8f5TYKXweAlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfDBJUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:20:09 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37678 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDBJUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T01mHDgEmP7617KXCDTyjm0F86yiz4BdFMQla118gW8=; b=Dpi0erhMqNOkPh3Xp+Fu4I84S
        LOp3+0J4puuERx4psnZU0AmdsuMSpXx1UODKfKkR04x/THUXn8jOz5ZA8Izl+ttVIlghePvq9mEMB
        SRa4HeyFcYiwpOXosbISMQwsHbhUrPihbM1ZXqZdw7FAbyuTNdb3VnhUQgtiWjP1IopKI=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBFaM-0006mE-Cj; Tue, 02 Apr 2019 09:20:02 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 24AB6440082; Tue,  2 Apr 2019 10:19:55 +0100 (BST)
Date:   Tue, 2 Apr 2019 16:19:55 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Curtis Malainey <cujomalainey@google.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] ASoC: soc-core: Fix probe deferral following prelink
 failure
Message-ID: <20190402091955.GE2059@sirena.org.uk>
References: <1551706274-22571-1-git-send-email-jonathanh@nvidia.com>
 <4eb94b41-7e16-7b39-5c14-a7d180ce67df@nvidia.com>
 <20190402043509.GQ2059@sirena.org.uk>
 <2d8a0569-b821-c0c0-af39-d3863d17f47f@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tpXFRyzAyQ/GSAaD"
Content-Disposition: inline
In-Reply-To: <2d8a0569-b821-c0c0-af39-d3863d17f47f@nvidia.com>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tpXFRyzAyQ/GSAaD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 02, 2019 at 09:52:15AM +0100, Jon Hunter wrote:
> On 02/04/2019 05:35, Mark Brown wrote:

> > I don't have this patch at all AFAICT.

> That's odd. It is definitely in -next and I did receive an 'applied'
> email from you [0]. So looks like something went wrong here. Can we get
> this into v5.1?

Oh, if I've applied that's why I don't have it any more.  Indeed it's
applied in my 5.1 branch so I don't know what you're expecting here?

--tpXFRyzAyQ/GSAaD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyjKToACgkQJNaLcl1U
h9C44wf+IAgKYLt9gaomDLHoupiqqE5n81Hc70YYK0P/YD8IsMTzUvA/jUPrnYnF
kyBCu27wTkzTMK2x6lKN/YublQPJxAEbWtjqT+2NuEqSRXLQvJ5Wmv8dc6gmZJLT
QxqhB4pWVMucX25QOqyUMhs8ZXIBxHU2Bj1pjGqrNMTltYFsvxiNpP7Y6B3QJXgI
2NPDzP39tZ+pqywYikJ9ke4AYoBlgrToFHVt5nRxnGOsBFZRlMZ9NQvWYC3fzqJ/
80rwPgXEsfUiRe+f4hd3ianW4CQaJEaRaY4ag6yno+gzyIg6trbs2G5Wy0Q0VooF
k+NzaCaGYcQBnmdRhZKr67cSmPzX1w==
=cNSi
-----END PGP SIGNATURE-----

--tpXFRyzAyQ/GSAaD--
