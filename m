Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D7DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5DF2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfCVJRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 05:17:46 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:48871 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCVJRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 05:17:46 -0400
X-Originating-IP: 90.88.33.153
Received: from localhost (aaubervilliers-681-1-92-153.w90-88.abo.wanadoo.fr [90.88.33.153])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 3BDF820013;
        Fri, 22 Mar 2019 09:17:42 +0000 (UTC)
Date:   Fri, 22 Mar 2019 10:17:42 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the sunxi tree
Message-ID: <20190322091742.rp3xfy3zkagq5xm2@flea>
References: <20190322083048.31084cf8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eqavf6eufbe5o6pd"
Content-Disposition: inline
In-Reply-To: <20190322083048.31084cf8@canb.auug.org.au>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eqavf6eufbe5o6pd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Mar 22, 2019 at 08:30:48AM +1100, Stephen Rothwell wrote:
> Hi all,
>
> After merging the sunxi tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
>
> WARNING: unmet direct dependencies detected for MFD_SUN6I_PRCM
>   Depends on [n]: HAS_IOMEM [=y] && ARCH_SUNXI
>   Selected by [y]:
>   - CLK_SUNXI_PRCM_SUN6I [=y] && COMMON_CLK [=y] && CLK_SUNXI [=y]
>   - CLK_SUNXI_PRCM_SUN8I [=y] && COMMON_CLK [=y] && CLK_SUNXI [=y]
>
> WARNING: unmet direct dependencies detected for MFD_SUN6I_PRCM
>   Depends on [n]: HAS_IOMEM [=y] && ARCH_SUNXI
>   Selected by [y]:
>   - CLK_SUNXI_PRCM_SUN6I [=y] && COMMON_CLK [=y] && CLK_SUNXI [=y]
>   - CLK_SUNXI_PRCM_SUN8I [=y] && COMMON_CLK [=y] && CLK_SUNXI [=y]
>
> WARNING: unmet direct dependencies detected for MFD_SUN6I_PRCM
>   Depends on [n]: HAS_IOMEM [=y] && ARCH_SUNXI
>   Selected by [y]:
>   - CLK_SUNXI_PRCM_SUN6I [=y] && COMMON_CLK [=y] && CLK_SUNXI [=y]
>   - CLK_SUNXI_PRCM_SUN8I [=y] && COMMON_CLK [=y] && CLK_SUNXI [=y]
>
> Introduced by commit
>
>   49c726d55c1b ("clk: sunxi: Add Kconfig options")

I've just sent a patch fixing this:
https://lore.kernel.org/lkml/20190322091650.5189-1-maxime.ripard@bootlin.com/

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--eqavf6eufbe5o6pd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXJSoNgAKCRDj7w1vZxhR
xTP/AQCT9qnV/p0WU1E+XgnhoZmwGi8I8iTb3cNYIJP8uDIrVwEAzVYZp8iVV32G
8+rRirNgLMvQkN95O8pF8I3/p9nm1A8=
=KVIv
-----END PGP SIGNATURE-----

--eqavf6eufbe5o6pd--
