Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAF1C2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 23:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27E3206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 23:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577231528;
	bh=C5fps0vju0uw2DJbpRLK2OvynOY0XLNabLTCoyaSMW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JxOCZukxtlc8NU629QqJHaWACvuDPWndAOUDmuQ0T+eA3eC9vQmFxaCoA/VCeXtwm
	 qnTH6vd43PCby0GH/kciwTj3I2GJCfo9Tt5k0oKU5Th8LGOtNknPaFuQEO+3dVHnHX
	 8lns1x5vIjKtoFz6MkFcIzbskiA7CyUMYxK2dqQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfLXXwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 18:52:07 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60882 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfLXXwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 18:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wVeG4o2wMLfWamY/spW73kzHgOHGF8sCfwGnxV1QecY=; b=Qqn84oRLhfEoicUtxn8KgThtq
        ekIL2BYMpXYFkDWCTQa3OkwsKbFICnezYVm5bxWhwismS5YCDkoRJSK3Gjt4AzP0ZPqHh7GgBJ90Z
        1OjPgDhJpjrvi/XL0xlQRXwvVd91R79HneYLVJhdhyFMiEm9G14s5vKQgfqcz29GZO954=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ijtxr-0007BU-Pt; Tue, 24 Dec 2019 23:51:47 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 9EAB1D01938; Tue, 24 Dec 2019 23:51:45 +0000 (GMT)
Date:   Tue, 24 Dec 2019 23:51:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?amVmZl9jaGFuZyjlvLXkuJbkvbMp?= <jeff_chang@richtek.com>
Cc:     Jeff Chang <richtek.jeff.chang@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: Add MediaTek MT6660 Speaker Amp Driver
Message-ID: <20191224235145.GA27497@sirena.org.uk>
References: <1576836934-5370-1-git-send-email-richtek.jeff.chang@gmail.com>
 <20191220121152.GC4790@sirena.org.uk>
 <7a9bcf5d414c4a74ae8e101c54c9e46f@ex1.rt.l>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <7a9bcf5d414c4a74ae8e101c54c9e46f@ex1.rt.l>
X-Cookie: I have many CHARTS and DIAGRAMS..
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2019 at 02:10:12AM +0000, jeff_chang(=E5=BC=B5=E4=B8=96=E4=
=BD=B3) wrote:

> --> When I check other driver at sound/soc/codecs/ folder, I just follow =
what others do.
> It seems in .h --> /* SPDX-Liencese-Identifier: GPL-2.0 */
>    In .c --> // SPDK-Liencese-Identifier: GPL-2.0

> Is it correct?

Yes, headers use C style comments and source files use C++ style.

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4CpI4ACgkQJNaLcl1U
h9DFVwf7Bvj8SH/istxSwNkLQ2Tr1SMqR95oagZSg6cNQ4V31uLCUSK/oD+TYaO/
4JjGHrPKLlwBKweT/nJ6nOX9/YcS1N7hvb5bOwK2dbcpsNb0BmkuDC+fy4sEXqfY
KyMmaYgN7+lkV2bYC7Y+x3FtZHs3IScuvGLk5pDp4NqXJddKTMEljQRdegtPDP3N
sAzfTrBMczPhnb320cF+yBQk5xSGCrez8FAJPlpGiaS1TkuHMr4CczYtSgO2qCKW
DYRLizqBUbJ0l8FkHW87f1YY8KdF4GKig5ihIiF8BQ4Vz7IiNTXiDC9eaayD/V71
hchxd/+izG1UhhEmm6NiVOIuyyUl9w==
=YYW7
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
