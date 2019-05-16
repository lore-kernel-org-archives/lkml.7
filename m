Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E466C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701FE20815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558025683;
	bh=zr/zxV1usENV4ElmdAnIWY6NyXFnfV23HLvkPZcxVQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dN2a79xFWQS/C8eL+9885dE9vXIx3zAUMFZudv3nt7nwHbhd2QpMN0K8NyTIwU+WF
	 O+7qEQ1uXPO+NPNc20NtGAgufMxaVZbHoTycwZjh/EZep6p5REB6ubIo7sZe4qkcdL
	 BYp2LOzKeDOXJaWdvg6rLe3w2VCDZjSw+ScTBH1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfEPQym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:54:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42548 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfEPQym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VkFNzLKE4kl1CvHrPz9yn/s6HJV6YwA2NLY66fTp9J0=; b=XYnUP/h6DYKuIcn7ZZt2d5KzI
        neFlnwfwa5xbxp+HzV4XNTtcA+UAql1Vbdc4nSWn+SQoQtBAM+mbcvHg+XKyMHz9e3OevtFIIwqci
        CfWTrJQTSY1ZCTqbsUyxrytgMd9xgLdlri4ZpY+kvFssCwZ/IrTgMNjG8N5jnLe+DMWaI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hRJdw-00076A-7k; Thu, 16 May 2019 16:54:08 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BEF01112929C; Thu, 16 May 2019 17:54:07 +0100 (BST)
Date:   Thu, 16 May 2019 17:54:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Viorel Suman <viorel.suman@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Colin Ian King <colin.king@canonical.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Viorel Suman <viorel.suman@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: AK4458: add regulator for ak4458
Message-ID: <20190516165407.GJ5598@sirena.org.uk>
References: <1558011640-7864-1-git-send-email-viorel.suman@nxp.com>
 <CAOMZO5C1jm=7tiui221B-N+ptEknK_ZdHvrjvSHfvQ=W-K54Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SLfjTIIQuAzj8yil"
Content-Disposition: inline
In-Reply-To: <CAOMZO5C1jm=7tiui221B-N+ptEknK_ZdHvrjvSHfvQ=W-K54Qw@mail.gmail.com>
X-Cookie: <ahzz_> i figured 17G oughta be enough.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLfjTIIQuAzj8yil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2019 at 10:14:42AM -0300, Fabio Estevam wrote:

> > +       ret = devm_regulator_bulk_get(ak4458->dev, ARRAY_SIZE(ak4458->supplies),
> > +                                     ak4458->supplies);
> > +       if (ret != 0) {
> > +               dev_err(ak4458->dev, "Failed to request supplies: %d\n", ret);
> > +               return ret;

> This would break existing users that do not pass the regulators in device tree.

It won't, if you're using regulator_get() and there's just no regulator
in the DT the regulator framework just assumes that there is actually a
regulator there which isn't described in the DT and substitutes in a
dummy regulator for you.

--SLfjTIIQuAzj8yil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzdla8ACgkQJNaLcl1U
h9APjQf+Lv8THYJ4esni1vNmG69HpD0BrrnTj4bJszGYZmzU+NUA1KpHwSgphVPx
dNEm9YVRL58Ap8OQ6R46L0vKKwjv7O2PQHVAVpuH94fJEkdnlRLYppoEof9hODaa
sIVb/mjegYSgclH+zisPqB4DrB9TFX55fkDl7I4JI+6IBuCCX6pGAmDC83VmgPhv
CBgNmyBfE6Iim+g1AKFLo6UJK8Ygn1KKRAfEmNVdN4Q+Zo2GcynfnznEHiUR3gCc
1iw2fGSjM4xOm42TezfFo+AZKBrCElE8jWQfInD3dQtbhJUtVljxIjOe1/ywebWi
qW8LBq1eK2SLwtpuk9lL4BDPZpj4LA==
=79lT
-----END PGP SIGNATURE-----

--SLfjTIIQuAzj8yil--
