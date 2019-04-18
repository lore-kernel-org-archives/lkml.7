Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C95BC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3E6214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555582647;
	bh=ljQPtbFSc654wnAEvEhcLcUFQF37SstoaMLaV5TOEBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jh37oi5/DA0a9zJlMT55gYvs+cJz9upjsYb8lx5JJ/jfecqYltmUKEZUdP9dCmtE0
	 SiuUGlfQP0H8CwETiWAKlzfqn7H5KUVqGBsEFFOUjBIZcA5/iTz1SKwpSFaq5rzw21
	 /UmHaQE6zAQIU4/tsdHz20xGizU9LW8hnwx2s4XM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388577AbfDRKR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:17:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57274 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387519AbfDRKR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JD6h6osV+7D86EHSdv9rURcI17z2pKxgpc4vwqVQclU=; b=nicGyneXhND0IPZiUYi0quIPA
        QEANuQe4Mv/ZMuBijmfu5XlDmzGRTvgOkvJaVhNzw0xwigJ2HdCqgWeQ1xDL6A6fsOJYgeYDrn1Rc
        IE8IVAy2DBrMoiHShxpmKtgxvNKScOX+VZepEWmzYMTwJAyhBbDDIOMLhz6N5ox7xo5Co=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hH46U-0001ST-7R; Thu, 18 Apr 2019 10:17:14 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BE4E31126DA9; Thu, 18 Apr 2019 11:17:13 +0100 (BST)
Date:   Thu, 18 Apr 2019 11:17:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>,
        "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: fsl_esai: Add pm runtime function
Message-ID: <20190418101713.GD6702@sirena.org.uk>
References: <VE1PR04MB6479871F3FC087282D23582DE3260@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6479871F3FC087282D23582DE3260@VE1PR04MB6479.eurprd04.prod.outlook.com>
X-Cookie: A watched clock never boils.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2019 at 10:15:24AM +0000, S.j. Wang wrote:
> > On Thu, Apr 18, 2019 at 02:00:12AM -0700, Nicolin Chen wrote:
> > > On Thu, Apr 18, 2019 at 03:29:09AM +0000, S.j. Wang wrote:

> > > Just for curiosity, we had similar situation on imx6sx, so we added
> > > suspend/resume with regcache. Why will the clock enable state be lost
> > > too? Does CCM on imx8 (might not be called CCM
> > > though) have any difference? What about clock rate settings?

> > That sounds like a bug somewhere else - I'd expect that after resume the
> > clocking would be restored to the state it was in before suspend.

> There is limitation in our internal design. That is in imx8 the power of
> subsystem will be disabled at suspend, include the clock state , clock ra=
te.=20

Right, that's fairly normal but usually it'd be restored as part of the
resume process?

> This patch is to enable the pm runtime,  so I think it is better to move =
the
> clock operation to pm runtime,  and close the clock at suspend to reduce
> the power.

It's definitely good to turn the clock off as much as possible, yes.

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly4TqkACgkQJNaLcl1U
h9ALKAgAhnvp9dsorOBOcQOXt2Vq+2KD6GhkpwRpRuLi546nZ9RcO9/ADIT31G4a
CPIpTSxmQcE7gESw935EGIhfsg7hySIHmOn0gR/6Jxmp4bOzb8RX+CMZQ1t9PzV7
aWtKsRrHdnIvlg0U0ua6M/ZslqxRTqdJH6rjKOu60lhS+QmeT19wj1kWe2xoP3e1
KUkoMMzdYj0dD6X5DjbjTDi5M2NX1NfVoqAbMclgwQ/A5TSqTSB7y+sktSjRWWEM
YoaFvHpTL/VVfw/Kq6ixXpH1qzLEeSZ++TE3DN7L1m88lXouS1QpcY4Whjsqb9K2
WPl704mTbAKcfAieB4Dilba/VD5CPA==
=ioaN
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--
