Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653DFC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3583120838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564664405;
	bh=okI22G20QlaPOLmBQA3yxCPqayqRHGr2WDzvmLXBnnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pMLRGlYcHa9wfnhi+4rX/jW3dII7qBIt6oI61UUox0wGvVxzHhwoLs2hqLEdoJk0c
	 cfNNae6DJnMxT/sypdwxz1MDjj1VMtz59mRDDOSaLYGTSIpmWm4xmSo1/z5KulpRTD
	 bMSg7aCjEdTA5XZaJEg87xDF3Yl5qLENOwVJgkcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbfHANAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 09:00:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36522 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbfHANAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tZI3KTKjRpHUbTZ9xFHXOBJ2TvEhJBVLT56qlP1UV90=; b=W54wwL11CImP68WRPJyAxMIh7
        wZwd4UHxY8TN0idZpHY/wNLyqUT+eGMt5cgvfmM8ztjgN1ecfkrcm5FKFZI4rmeJFXCjgsHoj3n9x
        1BIwoJ3l027hSqtXZS/HQPIMu/t+eLPP91XLfyIyxoUjDRbplTV4kA4jn8uTyFrEwJ8JQ=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1htAfm-0004hM-AB; Thu, 01 Aug 2019 12:59:10 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 13EE12742C48; Thu,  1 Aug 2019 13:59:09 +0100 (BST)
Date:   Thu, 1 Aug 2019 13:59:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com,
        Vijendar Mukunda <vijendar.mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Colin Ian King <colin.king@canonical.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] ASoC: amd: use DMA addr rather than CPU pa for audio
 buffer
Message-ID: <20190801125908.GD5488@sirena.org.uk>
References: <1564402115-5043-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Content-Disposition: inline
In-Reply-To: <1564402115-5043-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Cookie: Love thy neighbor, tune thy piano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2019 at 05:38:29PM +0530, Ravulapati Vishnu vardhan rao wro=
te:
> We shouldn't assume CPU physical address we get from page_to_phys()
> is same as DMA address we get from dma_alloc_coherent(). On x86_64,
> we won't run into any problem with the assumption when dma_ops is
> nommu_dma_ops. However, DMA address is IOVA when IOMMU is enabled.
> And it's most likely different from CPU physical address when AMD
> IOMMU is not in passthrough mode.

This doesn't build for me:

sound/soc/amd/raven/acp3x-pcm-dma.c: In function =E2=80=98acp3x_dma_hw_para=
ms=E2=80=99:
sound/soc/amd/raven/acp3x-pcm-dma.c:356:2: error: =E2=80=98pg=E2=80=99 unde=
clared (first use in this function)
  pg =3D virt_to_page(substream->dma_buffer.area);
  ^~
sound/soc/amd/raven/acp3x-pcm-dma.c:356:2: note: each undeclared identifier=
 is reported only once for each function it appears in

Please check and resend.

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1C4hwACgkQJNaLcl1U
h9C3Fwf7BOfEN4vmffpRJH10Vx7KKitOuorUGoZ4MzdoFmDEvZdkppuWO4WKlp1s
KoulKALI7savBZjmK+EgHjLCgxfg+hDlXd06YhxKf3RRAA0ocYtbMkjpCbzuu1Oi
+9ov2FjktSCXcGTH2/ozG7EBkUsj4BYcMAHRxrjM9RL25BLY0ZnGdBzNfxQUOId4
joH3Z68hx0+X32BPAELE9/8aujIOta+AIeDcMc7mHED2g2HjdeK6IaRRGYAr49CU
pDoQe1N+gw+rzO5IYG4E9q4+ptdLGWxMkeX16vPem/21TWsXZJln0ybieo9XRBI0
bd//ujEu7ChIeKelc2b+VjO+A++Ojg==
=BI5i
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--
