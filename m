Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B648C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFA82082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554180731;
	bh=c1TYRJ7kCd2TLR0vVLGqcB+UOXmX8ArpK4ObvHHhojo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bWwm5ldbJMZo+JMxC/kZ+RxqpC+eXKZzmnepwFPsxJzzvJEWO31UiLY57akElFTPl
	 vxuh0mqGgoMGYwlam7cMHLd0S5kZcaP/EeIULR4GPQiQojgoYiDGEKawiG+PAWch9U
	 SDTkICk69apMO/fn7M8nV935JaF9RNZ0CsFvUhNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfDBEwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 00:52:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39078 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfDBEwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 00:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0rPBcBTeUXQF+EQTKJMx0Ks6b1OVLlX2I1nqwbL9kqo=; b=sz0cBE9Ud47+Xb95mvEYIAI1p
        JPVtlHTtmy2QF5IIG62bjRPepjo2wzgg9/OX7REwTiMU5cJB1I22XXYII0QhhOVaP6o3CbuwOEPaI
        zAH/wS+TNY7PZpYrVZp05/igTxOj4Jq4lj5TNiAEUOWr5rzW62cZYpqxcNfbYQFckhZp0=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBBP2-0005nH-OQ; Tue, 02 Apr 2019 04:52:05 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 21A35440082; Tue,  2 Apr 2019 05:52:01 +0100 (BST)
Date:   Tue, 2 Apr 2019 11:52:01 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH V1 19/26] DT bindings: spi: add spi client device
 properties
Message-ID: <20190402045200.GS2059@sirena.org.uk>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
 <1553666207-11414-19-git-send-email-skomatineni@nvidia.com>
 <20190401073723.GH2059@sirena.org.uk>
 <BYAPR12MB3398F515727D46DE21C54FD6C2550@BYAPR12MB3398.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xUq7mlTLx96rFlBf"
Content-Disposition: inline
In-Reply-To: <BYAPR12MB3398F515727D46DE21C54FD6C2550@BYAPR12MB3398.namprd12.prod.outlook.com>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xUq7mlTLx96rFlBf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 05:59:57PM +0000, Sowjanya Komatineni wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> > > +spi-client device controller properties:
> > > +- nvidia,cs-setup-clk-count: CS setup timing parameter.
> > > +- nvidia,cs-hold-clk-count: CS hold timing parameter.
> > > +- nvidia,cs-inactive-cycles: CS inactive delay in terms of clock=20
> > > +between
> > > +  transfers.

> > Why are these being done as nVidia specific properties rather than
> > generic ones and why are these being configured in DT rather than by
> > the client driver?  If the devices have particular timing
> > requirements for chip select presumably that's going to apply no
> > matter what controller or system they're used with so it seems best
> > to configure this in the client driver and have an API that any
> > controller can implement.

> These are implemented thru DT as Tegra SPI is master and master controls =
the timing.
> Some SPI slaves have specific requirements of certain CS setup/hold time =
and inactive cycles which SPI master should meet when driving during transf=
er and Tegra SPI controller supports tuning these parameters.

This doesn't address the issue at all, obviously the timings for the SPI
bus are going to be impelemented by the controller but that's not the
issue.

--xUq7mlTLx96rFlBf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyi6nAACgkQJNaLcl1U
h9DYhwf/cafHrRWzRugYSCrehLshbVA+er54g9/ZcsiAAz4d1eXY5krepBIVxNRW
ekTXpqsXiu7eCEOlOZw4CHzJ/mf5dbJPdE9Y6MadhP8U+wqSHK7s8OD4cXOeq2qq
+s9vk5zpFmq4UMsoxFGM0IPRkU2C8dylcgDZndYLHaYowRGEMCfTJXGljfHDR6OQ
2IQ8Gv8lG88TNPlteORHsICEcukqJ9P0VPfuszoEbIF+vTwp73e0wJZHnVMAVC//
C9s8e9swMavIef92Aq4WSo9xCBHT6RqDlgOASZoGkQhcIzSMDSTOfTF76kxmOOhb
l5c2qXXcuzBH5bEgAv8G+knbRa3hoQ==
=K2T2
-----END PGP SIGNATURE-----

--xUq7mlTLx96rFlBf--
