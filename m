Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DF4C2D0C3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 23:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F01D20828
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 23:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577487967;
	bh=dEQPnibKM+jROVVU6qVMkmV/8zSOhY3xCdtSKxVLgb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sZcwFUDjf16mypsd+D0lflEQDf6U+IXl2VyMmydnKcQBUVCmVIXd7FulM8bD52zvd
	 GW2uFbSptW9gPw6VYE+Q6r5Y7/jGh0HnZ2FYooq4F/uh/QaraGHHtcw9ahzXfBsUzq
	 PMDUQVYp+hHvC4p1U5CRh21CGQeg0Vd64O2j99B8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfL0XGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 18:06:06 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42742 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfL0XGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 18:06:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2Me3W1CcQYRUaMjjW7RP9yGrYFxAf8aGHpvTMfD4pMI=; b=t/3p7NnTTB+32zGkG70ymdoQV
        nQXEGjm2MkflE9oplm5CNCG0kaF53p7x1nn2jFgiFahN/KxZW9Ivu4LWDzpZ6T1SEHun+d8TUOK9j
        i8cq1IiJPOW4gfIQf3WT5wt9kY1XkpegDiWEok1y1xA0oktZsWRYKKTZdAWnH/Cn1Jzck=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ikyWS-0006bi-9H; Fri, 27 Dec 2019 22:55:56 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id AD55FD01A22; Fri, 27 Dec 2019 22:55:55 +0000 (GMT)
Date:   Fri, 27 Dec 2019 22:55:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com, djkurtz@google.com,
        pierre-louis.bossart@linux.intel.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 1/6] ASoC: amd: Refactoring of DAI from DMA driver
Message-ID: <20191227225555.GA3897@sirena.org.uk>
References: <1577451055-9182-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1577451055-9182-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <1577451055-9182-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 27, 2019 at 06:20:50PM +0530, Ravulapati Vishnu vardhan rao wro=
te:
> ASoC: PCM DMA driver should only have dma ops.
> So Removed all DAI related functionality.Refactoring
> the PCM DMA diver code.Added new file containing only DAI ops

This breaks the build:

  CC      sound/soc/amd/raven/acp3x-i2s.o
In file included from sound/soc/amd/raven/pci-acp3x.c:13:
sound/soc/amd/raven/acp3x.h: In function =E2=80=98acp_get_byte_count=E2=80=
=99:
sound/soc/amd/raven/acp3x.h:94:19: error: =E2=80=98SNDRV_PCM_STREAM_PLAYBAC=
K=E2=80=99 undeclared (first use in this function)
  if (direction =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
                   ^~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/amd/raven/acp3x.h:94:19: note: each undeclared identifier is repo=
rted only once for each function it appears in

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4Gi/oACgkQJNaLcl1U
h9BQiQf+New8Dfm5hPPcu9h4aqIHcTz0z6dH4Zl6/A44Bhe0czd13P/r9M/6mFVu
radVO29d8A7ntQzZBxk5hXN/z5mt2OdXSknoE8tGnr+PTl7h3V+iPMGgOnK3KzRv
KnbUDB1FRdBMlS+y9SrSDMZ01rqmf59d++wmaXLb/hSyycjTcGcFbD8Y0VtcboeN
QcbcqfHLyneiWOfGzlEPl9EiYK5l8qVHiN8Ey/O6kCvIJS+bXjXwB1/uS7DY/MzM
s0aSahTt8CaOCTimfp7QvBmfxW7gXiGKcaVp+dk/DVnDRJ5UOf8JNiCl26boFKJh
72JSSFqQywYn0Qf7LcjiYQGNqmH0EQ==
=QKCx
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
