Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EE2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73C520850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553515638;
	bh=Jh3LhQVwu2At8D13a7yVW9Sjkg7/ib+9HieId7hAgZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f4QuIbPqyWCcpCyI2D8yelgzgCV7NMav0IYiRvhswbafaWaDqOtBbGtaRbp5X7V18
	 6yl6PzCLKZjTLULrXrYRZlTEP2cLYaSKfPgTohVvHdtem6PNir1WnwvnoQvlIO7ARs
	 dZSJ4MT4JeZNScmcoK2xYP3QC9gtAdRk871Cxl5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbfCYMHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:07:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39124 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730679AbfCYMHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Jh3LhQVwu2At8D13a7yVW9Sjkg7/ib+9HieId7hAgZE=; b=N55+nmU9MHo2+Kqe0HqNuVfKJ
        8bns6Wg4pijOJ+HU/c6gJB0osvdFoT8giIa0R6TQqwxIAvljT8NC5b9UI0wNe/Nz1aMzs9fkqVwbb
        ofN1JJilSzxiIGwmXDhxkYpp6MsC/mHIcFc86Fa0ryJF0o8kNQ/TqKg0k/NQlo8OVadGU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h8ONG-000216-6G; Mon, 25 Mar 2019 12:06:42 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 972F111288F1; Mon, 25 Mar 2019 12:06:41 +0000 (GMT)
Date:   Mon, 25 Mar 2019 12:06:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Cc:     "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Adam.Thomson.Opensource@diasemi.com" 
        <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [v2] ASoC: AMD: Configure wclk and bclk of master codec
Message-ID: <20190325120641.GE7284@sirena.org.uk>
References: <20190325063759.28300-1-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jTMWTj4UTAEmbWeb"
Content-Disposition: inline
In-Reply-To: <20190325063759.28300-1-akshu.agrawal@amd.com>
X-Cookie: Short people get rained on last.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jTMWTj4UTAEmbWeb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2019 at 06:38:27AM +0000, Agrawal, Akshu wrote:

> v2: Removed clk set rate and enable/disable from da7219 ops as
> da7219 codec takes care of them internally. Clock configuration
> kept for those codecs where da7219 acts as master of clock.
> As suggested by Adam Thomson.
>=20
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> ---

Place any inter-version changelogs after the --- as covered in
submitting-patches.rst.=20

--jTMWTj4UTAEmbWeb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyYxFAACgkQJNaLcl1U
h9Bwtgf/S5cgck6hSu5iyhKwTjGNtEgyPIFBMYUguqKWMZ3gn5raaj5Jk10Ivfhx
PMFH1Rm/k8UzxXl9r2qqb/lqQWHRCt9GDf5RwobpaopYlVONlNKiSx4W6kSqOrjb
JOp00I+unTbeO1LOXPgokwm0dRzRz7JUUgM74QSkghOky6G3qVThY+GG2nBYswr6
i6Ixgo1qvFcc1gI0weEN9Dl04OFCB/dKbBXPvZx6pFCFsWwyvZdMNbOAn7w8paGg
fzoZxNULc3UimvOAhRVQD5O6+dX5rKmbFkMC0C7ZX6IGyoCXWovS01peGfnA8bsJ
Q5Z5l2qykwbet9wBI/NIdGWe/RgHJA==
=JFBI
-----END PGP SIGNATURE-----

--jTMWTj4UTAEmbWeb--
