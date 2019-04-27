Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE1FC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 17:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D58020693
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 17:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556385449;
	bh=pBpwQEwWCBN3YWouAeEzRhfKLF+pSaYiwtkGBy+ZUNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qiLoeaLdvxpPSgqhhBWdWMXC3u8pei3xNW+eeOd0I+/9JT0kbu1kGhkjBD+VdQMYE
	 V9lj2fRBZFLINsMIeW5yqrqG2gn4O+JLtQC5pn8jeAQt6jHdlamYVBBBclhqYir3En
	 8np9FxLQf1uqMNwUdcKDalaYRCV9OTUIsCkfUiHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfD0RR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 13:17:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39270 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0RR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 13:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BrHF07zYw1XVu0tEvTnGpMr1OkuigjWVhQxqr86f0Tw=; b=poKkCc9hoL0tN0EHuvdyOZFJc
        I/KnBGgebnnQOmU+f9qBKc8if436wWlpFUQcoOcOXaA7vSOesU2AkPYLD22S8poQPVUVFE0jegTfv
        c63FPyc5BlugbBz8DHRNcNCXS8GcL0BN2BOYCug5XsIvQpdQ5ERRuUHvGPM2dyBohESmE=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hKQwy-0004XU-1x; Sat, 27 Apr 2019 17:17:20 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id BE38E441D3B; Sat, 27 Apr 2019 18:17:15 +0100 (BST)
Date:   Sat, 27 Apr 2019 18:17:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3] ASoC: fsl_esai: Add pm runtime function
Message-ID: <20190427171715.GF14916@sirena.org.uk>
References: <VE1PR04MB64797233B0BFE833550094C3E33E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pyE8wggRBhVBcj8z"
Content-Disposition: inline
In-Reply-To: <VE1PR04MB64797233B0BFE833550094C3E33E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pyE8wggRBhVBcj8z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 26, 2019 at 10:51:15AM +0000, S.j. Wang wrote:
> > On Mon, Apr 22, 2019 at 02:31:55AM +0000, S.j. Wang wrote:
> > > Add pm runtime support and move clock handling there.
> > > Close the clocks at suspend to reduce the power consumption.

> > > fsl_esai_suspend is replaced by pm_runtime_force_suspend.
> > > fsl_esai_resume is replaced by pm_runtime_force_resume.

> > This doesn't apply against current code, please check and resend.

> Which branch are you using?  I tried for-next and for-linus, both
> Are successful applied.

I'm applying against for-5.2, though if it depends on a patch queued for
5.1 that's fine, I can just merge that up - please just resend.  I think
I did try merging 5.1 though...

--pyE8wggRBhVBcj8z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzEjpoACgkQJNaLcl1U
h9CHlQf6A1P1Ke+eIk6AjsV7q+IJv+iAexa+x1wOv3kVyxN9HNXMrrjuzMEX9GHF
5r7c9xhmJkX6qp8qFYVofOXeK3E9muhfjvSakheiyz6b3bpOP4bTNpZPK2m48Eda
aKkSFsu/TBWB42fymUVC5tAo45RWNe+5OSZrpCHou5DnvhhEMmdoMNS2ZDzrYFSt
h0rgmD+tb0YTZgP7WuEx0L/iSe0epJDpXyN8wgBozUQJp7muUvLnBPHEWqsNnoY9
bLVkFnRQhyZVi/urL0G5fGfbDwjRSXtoJJwjczQDAwXy20veWbr10l88uPXRbL5R
rIYLJu11thD17a4mSdf/UCUix1rE0A==
=tACM
-----END PGP SIGNATURE-----

--pyE8wggRBhVBcj8z--
