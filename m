Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FE9C742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63302084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfGLHVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 03:21:49 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:55009 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfGLHVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 03:21:49 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 54820E0004;
        Fri, 12 Jul 2019 07:21:46 +0000 (UTC)
Date:   Fri, 12 Jul 2019 09:21:45 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Zeng Tao <prime.zeng@hisilicon.com>
Cc:     kishon@ti.com, Chen-Yu Tsai <wens@csie.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] phy: Change the configuration interface param to void*
 to make it more general
Message-ID: <20190712072145.gr3dbfvdfgrye6yi@flea>
References: <1562923580-47746-1-git-send-email-prime.zeng@hisilicon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q4ycfudq7dncn663"
Content-Disposition: inline
In-Reply-To: <1562923580-47746-1-git-send-email-prime.zeng@hisilicon.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q4ycfudq7dncn663
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 12, 2019 at 05:26:04PM +0800, Zeng Tao wrote:
> The phy framework now allows runtime configurations, but only limited
> to mipi now, and it's not reasonable to introduce user specified
> configurations into the union phy_configure_opts structure. An simple
> way is to replace with a void *.
>
> We have already got some phy drivers which introduce private phy API
> for runtime configurations, and with this patch, they can switch to
> the phy_configure as a replace.
>
> Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>

I still don't believe this is the right approach, for the reasons
exposed in my first review of that patch.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--q4ycfudq7dncn663
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXSg1CQAKCRDj7w1vZxhR
xcl7AQD/l+gpdt4tLbilzX+6ZMKAGS3WAQO2akmyeVmUZrz6cwEA9wIVIvz4R8Zy
JSba5uROdmHDOd3ljw0dOctpSOHXmAw=
=FZ3v
-----END PGP SIGNATURE-----

--q4ycfudq7dncn663--
