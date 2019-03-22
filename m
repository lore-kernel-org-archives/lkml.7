Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3477AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D22218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfCVJFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 05:05:47 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:49595 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfCVJFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 05:05:47 -0400
X-Originating-IP: 90.88.33.153
Received: from localhost (aaubervilliers-681-1-92-153.w90-88.abo.wanadoo.fr [90.88.33.153])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 94608FF805;
        Fri, 22 Mar 2019 09:05:43 +0000 (UTC)
Date:   Fri, 22 Mar 2019 10:05:43 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ARM: sunxi: Fix USB host init fail on v5.1-rc1
Message-ID: <20190322090543.2st5ilhk4nvdngyk@flea>
References: <20190322085108.18693-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="esj3bsxhhq6fyec5"
Content-Disposition: inline
In-Reply-To: <20190322085108.18693-1-wens@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--esj3bsxhhq6fyec5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 22, 2019 at 04:51:06PM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>
> Hi everyone,
>
> As previously reported [1], USB EHCI/OHCI hosts are broken on Allwinner
> SoCs on v5.1-rc1. This is partially triggered by commit b97a31348379
> ("usb: core: comply to PHY framework"), and partially due to how the
> Allwinner USB PHY driver handles phy_set_mode for non-OTG PHYs.
>
> This series fixes this in both places.
>
> Patch 1 makes phy-sun4i-usb accept PHY_MODE_USB_HOST for non-OTG PHYs.
>
> Patch 2 makes the usb core fall back to setting the mode
> PHY_MODE_USB_HOST if set_mode with PHY_MODE_USB_HOST_SS fails. If that
> fails then the failure path is the same as before. This should make it
> so existing USB 3.0 drivers are affected.
>
> The patches don't have any dependencies on each other, and could go in
> through separate branches. However this affects usability of USB input
> devices and Ethernet dongles, I'd rather they go in sooner than later.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--esj3bsxhhq6fyec5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXJSlZwAKCRDj7w1vZxhR
xfalAP0UWJFhN15P+P1fRsbnqLWVfT1VUaynos9xXw/GFttkIAD/cxzj3FaPiFZt
74tR87lA9BRaCnHlMk/aVGx4dOzvBAQ=
=RxTw
-----END PGP SIGNATURE-----

--esj3bsxhhq6fyec5--
