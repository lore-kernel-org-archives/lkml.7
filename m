Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136F0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 00:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC35D20838
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 00:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577406029;
	bh=dKb6nVThT//M3UvZTw1X0LRTsixwsq25IuRFiddkXPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dF/E/cNhfXCwQC8koDWPjyz/JMjjpgBfYktD7mpZlTdqSmPMHr9IpZsiBI1nw8GVj
	 USMsGfOBVkVq04XdDftAhKcRRkFL9X9Lod2utHfrj7FWLwToDQhuIJzi4aQJtON4Ht
	 eFI4NCt1kvWcLNg6rYhV20RpyDBxLsAe/L6T4vQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfL0AU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 19:20:28 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34774 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfL0AU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 19:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1p+hQ0EfSq9Y8XT2J4hrcnRxIbbiNS3tV0JV+yn7c1w=; b=hMI/mVirKJv0gb2xHCYPyTECq
        3/+NGhfxg4l0MM/ExhCnpz3026YtCLI/Wm9pC1J6FYJqCGHWU561pmXmbrsow9t19ki6ZTUyfrHrK
        YooGc8o7mv2m4VTTC5ClQ328H7BWEX021BlyMmJsHawGun97kEp6IU2gwBfaPFqrC06P4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ikdMR-00043K-P3; Fri, 27 Dec 2019 00:20:11 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 24A04D01A24; Fri, 27 Dec 2019 00:20:11 +0000 (GMT)
Date:   Fri, 27 Dec 2019 00:20:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>, lgirdwood@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        heiko@sntech.de, sam@ravnborg.org, icenowy@aosc.io,
        laurent.pinchart@ideasonboard.com, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: regulator: add document bindings for
 mpq7920
Message-ID: <20191227002011.GG27497@sirena.org.uk>
References: <20191222204507.32413-1-sravanhome@gmail.com>
 <20191222204507.32413-3-sravanhome@gmail.com>
 <20191223105028.amtzf62yjdpdsfrt@hendrix.home>
 <ec7d8937-724e-946c-0569-da685223d21d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yZnyZsPjQYjG7xG7"
Content-Disposition: inline
In-Reply-To: <ec7d8937-724e-946c-0569-da685223d21d@gmail.com>
X-Cookie: I have many CHARTS and DIAGRAMS..
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yZnyZsPjQYjG7xG7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 26, 2019 at 11:23:36PM +0100, saravanan sekar wrote:
> On 23/12/19 11:50 am, Maxime Ripard wrote:
> > On Sun, Dec 22, 2019 at 09:45:05PM +0100, Saravanan Sekar wrote:

> > > +  mps,fixed-off-time:
> > > +     description:
> > > +        select power off sequence with fixed time output delay mentioned in
> > > +        time-slot reg for all the regulators.
> > > +     type: boolean

> > I'm not sure what this fixed-on-time and fixed-off-time property is

> the time slot register holds the time interval of Vout when enable the
> each regulator.
> fixed-on-time property is to specify each regulator shares same time
> interval mention in time slot register.
> variable on-time defines the factor or multiples of value in time slot
> register.

This really isn't very clear from the bindings document.  You
need an explanation like the above in there.

> > supposed to be doing. Why not just get rid of the time slot property,
> > and set the power on / power off time in fixed-on-time /
> > fixed-off-time property?

> 1. if fixed-on-time is needed with default time slot register settings,
> then time slot property is not needed
> 2. if variable time is needed with modified time slot, then both
> variable time factor & time slot property is needed,
> Hope above explanations answers the necessary of all the above property

Same here, though I'm still a bit unclear about what "needed with
modified time slot" means.

> > > +  regulators:
> > > +    type: object
> > > +    description:
> > > +      list of regulators provided by this controller, must be named
> > > +      after their hardware counterparts BUCK[1-4], one LDORTC, and LDO[2-5]
> > > +      The valid names for regulators are
> > > +      buck1, buck2, buck3, buck4, ldortc, ldo2, ldo3, ldo4, ldo5

> > For the third times now, the names should be validated using
> > propertyNames.

> Not sure did I understand your question correctly.
> all the node name under regulators node are parsed by regulator
> framework & validated against
> name in regulator descriptors.

That validates at kernel runtime but doesn't let bindings
validation at the time the DTS is built verify things, Maxime is
asking you to spell things out in the DT binding document so the
DT can be validated independently of the kernel.

--yZnyZsPjQYjG7xG7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4FTjoACgkQJNaLcl1U
h9D96wf+OYYRfv8FwHCO/xbRHLQnV9IfwhRjxZEBM/0wqkxc723HdSEUxPWF/CFl
bP9EuzUZXPUU1OFk0tJ//UIRqxC0E+vpGKwJ/c724Z3Kk0oKEM4hlsAsUjfIjkvh
Z0By73bCL82WJ3J+PmLO+jecUP4oKf0LiJvZELUPdW9zpIYdZDf3DvnFjrz4eUnX
cDvMK9ywKS6vJPe5Pp7/vIWQcVmfNOYN1LSjz6alPMwpygyl7BpLYh7r1LkTfQ9G
Y376bT9fhxeo8zw6dm2DebCbfl/hRWwDzo+hhMQc8hhmpwBsJMJ2QP0nzrzJIMUn
QlbgAaX3XO2kp5EJzH49qE3tXelfkg==
=bGL+
-----END PGP SIGNATURE-----

--yZnyZsPjQYjG7xG7--
