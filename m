Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FFDC2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721232054F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576169380;
	bh=LKSn41kkriO561pO2wAK39PinJzm2f1kU5mB8knzV4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ihus5w+vTk1Cf0LyiyNaAj++xydTsBjyupjkjxKZN3INS4wtLJGn7In2G8E/qNXpd
	 NvDNVk5C7pBnFw1AJvtPCofX/iv7rC6ZO1exclINzX8T0/aiOo1agVO+9BO7/BHzIF
	 Lfy7Px90q5xdKGQkRTDjG0HKoVY/CBCtXRaCH3Mg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbfLLQtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 11:49:39 -0500
Received: from foss.arm.com ([217.140.110.172]:53228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729762AbfLLQtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:49:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D760130E;
        Thu, 12 Dec 2019 08:49:38 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5777F3F6CF;
        Thu, 12 Dec 2019 08:49:38 -0800 (PST)
Date:   Thu, 12 Dec 2019 16:49:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
Subject: Re: Regulator probe on demand (or circular dependencies)
Message-ID: <20191212164936.GI4310@sirena.org.uk>
References: <23236201-a387-7257-35a4-ee4ed2f6bfd0@ideasonboard.com>
 <20191209163755.GF5483@sirena.org.uk>
 <fb87c957-40e8-587e-5789-33b740f8326d@ideasonboard.com>
 <20191212155656.GE4310@sirena.org.uk>
 <CAMuHMdXwNPKfL5Xijtb2RFvf5MDEuiqUZ9DOdWdWxD=RRhScwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ev7mvGV+3JQuI2Eo"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXwNPKfL5Xijtb2RFvf5MDEuiqUZ9DOdWdWxD=RRhScwQ@mail.gmail.com>
X-Cookie: We have DIFFERENT amounts of HAIR --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ev7mvGV+3JQuI2Eo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 12, 2019 at 05:18:43PM +0100, Geert Uytterhoeven wrote:
> On Thu, Dec 12, 2019 at 4:57 PM Mark Brown <broonie@kernel.org> wrote:

> > In theory someone could try to do some sort of sorting with the DT
> > graph, people keep talking about it but nobody's done anything that I'm
> > aware of.

> "of_devlink" has landed in v5.5-rc1, cfr. commit a3e1d1a7f5fcccaf ("of:
> property: Add functional dependency link from DT bindings").

> I gave it a try on some boards lately.  It improved the deferral situation on
> Koelsch, but made it worse on Salvator-XS.

Ah, nice.  It's at least a start on that, that's good.

--ev7mvGV+3JQuI2Eo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3yb6AACgkQJNaLcl1U
h9CLfwf+OAU/ea7UJ6vHvXERuvufBK30An3dBf8rNAW4VU0uM8CREyiUfVQEtdEL
bS5y/7f8wHfDkN6G7WS3+5MXAnPs4Vvtl2fjgEqWqGVTQeVTewokEfQrP2kozlpc
hEBftKAWvW+Aziiqqf5kNiZMO4nRdrHR2LWYCggB8h4DD6cJtjx/GGRzsnK7ZWu/
EwZi/l8b83GTE8zRrlkNgaTX/fAtEsRf4NqjOnxf4m2ZcFEnOW4QrXFwfqPencAR
IeVyO/04Md1gDul/D3ptMskjRhVvfRnKFMghZolfskYJqZZmQPdyT4hV0HzqSmS5
EqDDFpefLtIMsGz9yMRVlFJP0xkguw==
=H+lB
-----END PGP SIGNATURE-----

--ev7mvGV+3JQuI2Eo--
