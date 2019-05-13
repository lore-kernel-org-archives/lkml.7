Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950F8C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6708F20879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557769206;
	bh=SrM4iNJmqoJMscAMH9MSZa273/S6iFsFRBCwJbdFkiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NLCPyhysCDRTU6PdEvn97/3raZz0HdBNH3dZqJuI3PFl5N8BkkxwEvq43sI8FIFxU
	 J/wkr4HwVxATojPWdweafbth+xK7mRQPC9YRr/l5bXE176/gvY7yICWYteBKw0zBL5
	 erxp+5HjcNh1nOZGboc3poP6201SGED5Uus+DgkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731796AbfEMRkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:40:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39722 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfEMRkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Q8Ws9F8LuqNXJmuF056IOvQqVLZe5vGNwBdJxJpKZrE=; b=Lj3EC4zP2azv7daXeW00ojMnV
        TQ5VDXE6mjJ4BxlgMmM5TsECB75OFZvSvRpyGSVbfc87Sughcm6sCle2EgMlBB/iyxSEAh6XfZuk9
        UHmjqd/JfVORHto5SVaDs+jiaU/0rLMOB/leAuFqgXlWs6BrVCEmiGP7LazzcWtwe4fwY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hQEvi-0007FN-95; Mon, 13 May 2019 17:40:02 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8FAF61129232; Mon, 13 May 2019 18:40:00 +0100 (BST)
Date:   Mon, 13 May 2019 18:40:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 6/6] soc/tegra: regulators: Add regulators coupler
 for Tegra30
Message-ID: <20190513174000.GH5168@sirena.org.uk>
References: <20190414175939.12368-1-digetx@gmail.com>
 <20190414175939.12368-7-digetx@gmail.com>
 <20190508075848.GX14916@sirena.org.uk>
 <af6de446-ab45-1745-30e5-426c6b34421f@gmail.com>
 <20190512090446.GN21483@sirena.org.uk>
 <3988cfb6-55fe-48c4-5365-ac79871f7fd2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4C6bbPZ6c/S1npyF"
Content-Disposition: inline
In-Reply-To: <3988cfb6-55fe-48c4-5365-ac79871f7fd2@gmail.com>
X-Cookie: Must be over 18.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4C6bbPZ6c/S1npyF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 12, 2019 at 09:29:54PM +0300, Dmitry Osipenko wrote:
> 12.05.2019 12:04, Mark Brown =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Wed, May 08, 2019 at 04:27:42PM +0300, Dmitry Osipenko wrote:

> > Those seem like they should be doable in generic code, though the fact
> > that the constraint is variable makes it annoying to specify - otherwise
> > it'd just be a minimum and maximum spread.  I'm not really coming up
> > with any great ideas right now, it's getting into OPP type territory but
> > it sounds like there's more flexibility for ramping the core voltage so
> > you'd end up with silly numbers of OPPs.

> The OPP shouldn't have to do anything in regards to the regulators
> coupling. The whole idea of the regulators coupling is to make device
> drivers to not churn with the coupling. The coupling in this case is
> specific to SoC and not to a particular board.

The thing with OPPs is that they specify a whole table of values that
work together including regulator settings, the result being that you
have many fewer options but don't need to think about constraints.

> I think the current approach with the customized regulators coupler is
> the best solution for the time being. We may consider something more
> generic if there will be other users with a similar coupling
> requirements, otherwise it's quite difficult to judge what is "generic".
> Do you agree?

Some of the constraints (like having drivers loaded) are kind of fun...

--4C6bbPZ6c/S1npyF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzZq+8ACgkQJNaLcl1U
h9Dtswf/f4sgl8pKS8cZdLJ7aTJAOm1gCl9vpwFvrhRXFUi7Zmj5BQyd/G1GAWXu
OxtEoUI8JWPsrf9vk9UxD2Qk1xlVTBXIWt1UfGn7HXXAOcgAMmHya1QRYJSy7rNh
2bUCy/+Sh+tjmz2fqWe+YnoecfV1GyxCoTXF0WgA6+k86sXKZT8SNss1F6MJCJ14
5pgJmTikPDbjOR8g/Wdd+5x315iaAjY/zv6q6d2uxgwvybHYVIx+YMwowzEI8FyH
y2keI9ZHfPbZtmAw2SuxCJ2+74W+4ffAu7xiVANCFtdr5F665+/wa3V4AM9t7k4L
dBlGd+z0XFj1J7KCxxmllK1RSYwJIA==
=1OqR
-----END PGP SIGNATURE-----

--4C6bbPZ6c/S1npyF--
