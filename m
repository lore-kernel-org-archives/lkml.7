Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74615C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD5D20835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732974AbfDQQzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:55:42 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:41043 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731745AbfDQQzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:55:40 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id C149C200008;
        Wed, 17 Apr 2019 16:55:37 +0000 (UTC)
Date:   Wed, 17 Apr 2019 18:55:36 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, wens@csie.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH -next] drm/sun4i: Make some symbols static
Message-ID: <20190417165536.kzjazgpcb4tf6ho3@flea>
References: <20190416145855.20852-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vniiivupf33cx6yj"
Content-Disposition: inline
In-Reply-To: <20190416145855.20852-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vniiivupf33cx6yj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 16, 2019 at 10:58:55PM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>
> Fix sparse warnings:
>
> drivers/gpu/drm/sun4i/sun8i_tcon_top.c:271:36: warning: symbol 'sun8i_r40_tcon_top_quirks' was not declared. Should it be static?
> drivers/gpu/drm/sun4i/sun8i_tcon_top.c:276:36: warning: symbol 'sun50i_h6_tcon_top_quirks' was not declared. Should it be static?
> drivers/gpu/drm/sun4i/sun4i_tcon.c:239:6: warning: symbol 'sun4i_tcon_set_mux' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--vniiivupf33cx6yj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLdaiAAKCRDj7w1vZxhR
xaH2AP9W0Fd/cwkBPQyfYmwry5PZESYvbqbbyxCNlI3bJtzEOwEAw9T/UugkMGDH
xqIE2H9T2uTSn37vrwgbsKDv0fD75AU=
=wbE8
-----END PGP SIGNATURE-----

--vniiivupf33cx6yj--
