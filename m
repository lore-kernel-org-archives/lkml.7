Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8474C2D0DA
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 22:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4BC2208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 22:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577486615;
	bh=PBsKP8gtbmBJPTI5aIng2BCqn7LuKLBL/0YvXsWQfmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HUpwYSqwsjjV3oNue1nofR31iuA3Gw2FWDfZTdfRfBXIUEblXcjMum0GjcSUvYX1o
	 skTK0dd52kCcSuhYXQg1vo76F7hmeF70XaVI4olRcLby6q5G8iocBguz13oVZsPX2q
	 TZCDmyigXBt0zAqZmwVrOjizMd5TiRADn0OOKW3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfL0Wne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 17:43:34 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32944 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfL0Wne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 17:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PBsKP8gtbmBJPTI5aIng2BCqn7LuKLBL/0YvXsWQfmE=; b=stCMR1/Sr1/3RfQMgganUG+10
        1f1GNXYHTXNWSZ2LmteRQgzQp/UopIFgc4crjtQYOvEl5YZy6vmqjmpYnqkZk3dt2o6MVofqOA1Qk
        skYpw1zaCwUpbdmo7YIA1auXsKjl2TwYXo/IMwRJGLXEd4s26VmNnNi/8zIszbNVuYlNs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ikyKP-0006a6-SZ; Fri, 27 Dec 2019 22:43:29 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 5E21BD01A22; Fri, 27 Dec 2019 22:43:29 +0000 (GMT)
Date:   Fri, 27 Dec 2019 22:43:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Shuming Fan <shumingf@realtek.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH AUTOSEL 5.4 001/187] ASoC: rt5682: fix i2c arbitration
 lost issue
Message-ID: <20191227224329.GM27497@sirena.org.uk>
References: <20191227172911.4430-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EOHJn1TVIJfeVXv2"
Content-Disposition: inline
In-Reply-To: <20191227172911.4430-1-sashal@kernel.org>
X-Cookie: I have many CHARTS and DIAGRAMS..
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EOHJn1TVIJfeVXv2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 27, 2019 at 12:26:05PM -0500, Sasha Levin wrote:
> From: Shuming Fan <shumingf@realtek.com>
>=20
> [ Upstream commit bc094709de0192a756c6946a7c89c543243ae609 ]
>=20
> This patch modified the HW initial setting to fix i2c arbitration lost is=
sue.

It's not great to send stuff like this out during vacations,
there's a good chance people won't be looking at their mail these
two weeks...

--EOHJn1TVIJfeVXv2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4GiRAACgkQJNaLcl1U
h9AyNAf/VopNHKmQBrZ3SbdvrbbTDSyxScjJd/iJURWlKw37+601meo0Y1oDME/Z
zMcmZBvH17dQDUj7iVJ2EQ0nXt8JXXmbZUUKy18RuEgYsBYpucLB2cqtwqM5Y8tW
uwr/y0tyFYv+E/NtvYLB+umh8ZccQoyAFrFVimA71Ii6EDt9OgX6Fe7JfPUdZRhZ
L3/M0vyLAlrPY1XO1Q1Z20V93DxuDZXXY5ura7O31K2JA8+ds3ovt8buQgwKUaS5
Y9FBh19Fa2Gii5n2WwQ2rX8K7rQZYccHVV31UX1GF85+cUkOUpCVwb8ggj8aqm32
6LWVBkDn8LC7xsx8rmgtpy2VAcjcTQ==
=ooCn
-----END PGP SIGNATURE-----

--EOHJn1TVIJfeVXv2--
