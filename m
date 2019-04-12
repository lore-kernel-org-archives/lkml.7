Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02229C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0A82084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555057976;
	bh=tbDeivWO2A5PdYb6MasdwmAoytpIoRqoDdYXPZkS+Jg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Blp59rIefiLG1yYvV1Ajzb/VYZ50HF9NaAE0sxWhkyO50b1jhwEyFazfOr27q51kn
	 p09AZRs63/diH/BMcXcIIeW6WbY3+ArMGxtqCgFVYJBW5MshjWmGliN/JeHEhZBBTm
	 H+nuKXL8JnGiv1vair1y90Tl1rPr9t2+MQvtbxIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfDLIcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:32:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33930 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfDLIcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=arIenWz3SmqWmwZOoKF34oUQXPOGDlF1TlDXs4ri0m4=; b=jjlYpRYSE6f3PVXTDLzy5oa8O
        KkHo0DkEQCSxrhHioAkl4oEXJXKoKrFgZ0svL+FWguo42sOaQiwdvFtdqs/7R+LQj0VqZyc8syY+d
        oCQRbeZUSQ/TaF4tVK3pAHvwzVwTX0eLdTAmfHwXmlqcermPPmPo3jrH80UL5KcEHpIL4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hErc9-000661-Jn; Fri, 12 Apr 2019 08:32:49 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 03ADB1127945; Fri, 12 Apr 2019 09:32:48 +0100 (BST)
Date:   Fri, 12 Apr 2019 09:32:48 +0100
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
Subject: Re: [PATCH V2 11/20] spi: expand mode support and add LSBYTE_FIRST
 mode
Message-ID: <20190412083248.GB6909@sirena.org.uk>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
 <1554423259-26056-11-git-send-email-skomatineni@nvidia.com>
 <20190408062819.GJ2803@sirena.org.uk>
 <BYAPR12MB3398CC43DC1F78A10BC51DE8C22F0@BYAPR12MB3398.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
In-Reply-To: <BYAPR12MB3398CC43DC1F78A10BC51DE8C22F0@BYAPR12MB3398.namprd12.prod.outlook.com>
X-Cookie: Your present plans will be successful.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 07:58:33PM +0000, Sowjanya Komatineni wrote:
> > On Thu, Apr 04, 2019 at 05:14:10PM -0700, Sowjanya Komatineni wrote:

> > > Some SPI Master controllers support configuring Least significant byt=
e=20
> > > first or Most significant byte first order for transfers. Also some=
=20
> > > SPI slave devices expect bytes to be in Least significant first order=
=20
> > > and some devices expect Most significant first order.

> > > SPI driver declares mode and mode_bits as u16 and all bits are used.

> > > This patch changes mode and mode_bits to be u32 to allow for more mod=
e=20
> > > configurations.

> > > This patch also creates SPI_LSBYTE_FIRST mode to allow SPI clients to=
=20
> > > choose LSByte order or MSByte order through the device tree property=
=20
> > > spi-lsbyte-first.

> > Please submit one patch per change, each with a clear changelog, as cov=
ered in SubmittingPatches.  This makes it much easier to review things sinc=
e it's easier to tell if the patch does what it was intended to do and mean=
s that if one part of the patch casues problems it won't hold up the other =
parts.

> I split changes on SPI code side and SPI Tegra side as separate patches.
> Do you meant to have both changes on SPI core and SPI Tegra together in a=
 single patch?

You are expanding the size of the mode variable and adding a new mode in
the same patch.  These are two separate changes and should be in two
separate patches, as soon as you start writing "Also..." in a changelog
that should be a warning flag.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlywTTAACgkQJNaLcl1U
h9ASVgf/YJl1oQzWArLRQHn7PzVwQ4QsUKLnP+dbbx8RWVhM93Whw0IURubE0Qkj
zHIRDTu88rSP4hQMymsqJwcN9ZSWA/QgWW/950S+kZQ23a7d2hmSfC5LEXZACawm
gJ1MFuHKf5zA1nHTeSu1aXVR6QdABMaAvu0Bk+VPplAZPuLI5k7vvLxcxGZ7G3e8
S5Xwyo3Prv9T4J8pMiD/5eg4jc/o05MTw26M2kFRE2IV9STQ25DaSIQjtMhTq8c2
kaBMQKAfEnQ+roNYcqNKMo4SPCCmNrR8MljdRf/bmIqaLIhyj9P/qRFOrjeC19eM
ELTmw4Unue23lYbVs5FVE3JuWWbQgg==
=0IqI
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
