Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212B7C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 09:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FF420838
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 09:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577353114;
	bh=Mr8Uh6VVBiWsMxxVZI0L4qzbBIyfNz4dUgYhjdF9bxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zsf+npullNj5+dPeY239nuLNWQthc+HJW1j1o9vfC8hX6DTAWPNFmi2US+zI1XPBi
	 /6cpxyClh2P3LAgOYwB+LjCPi189AJFRnAgRDzZ2ufwqiocImHd16g3QhLc8eNDgPK
	 EqLsCD6eF9w6NvQUB2JvnR+Pyra0gi7CTEZKx0Hc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfLZJid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 04:38:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:60358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfLZJic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 04:38:32 -0500
Received: from localhost (lfbn-lyo-1-633-204.w90-119.abo.wanadoo.fr [90.119.206.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 992F82075E;
        Thu, 26 Dec 2019 09:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577353112;
        bh=Mr8Uh6VVBiWsMxxVZI0L4qzbBIyfNz4dUgYhjdF9bxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RNn9y+8DsUK/oQbFJLeb19DhGx54/xMLG77+3mm4kwDstHVH8cubfvxvJjvHaoLaf
         ydoXKFiFDeHUsNQW2DUVqLllBm0kDhSUgDxeXO40rw1G3cIkthez4HpOZzV2hpp2MK
         p30RNiOo5UZVYnBbGFPwcU2kyWYHhihg8TFOip7Y=
Date:   Thu, 26 Dec 2019 10:39:52 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        michael@amarulasolutions.com, Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v14 0/7] drm/sun4i: Allwinner A64 MIPI-DSI support
Message-ID: <20191226093952.i2jttp7tr5hie6jl@hendrix.home>
References: <20191222132229.30276-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h3pmpnueinecnwd2"
Content-Disposition: inline
In-Reply-To: <20191222132229.30276-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h3pmpnueinecnwd2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 22, 2019 at 06:52:22PM +0530, Jagan Teki wrote:
> This is v14 version for Allwinner A64 MIPI-DSI support
> and here is the previous version set[1]

I applied the patches 1 to 6, and fixed checkpatch warnings in the
patch 5. Make sure to run it before sending patches.

Thanks,
Maxime

--h3pmpnueinecnwd2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXgR/6AAKCRDj7w1vZxhR
xbLvAQCJi7xi94JsmmvMc/qiv546VIdF1KVEM1HWgg4A2XFb1gD9GrsRw+V1QxTC
1yZ8gotcEiYivT+fUp5C9q8c/WwP6wU=
=zrYu
-----END PGP SIGNATURE-----

--h3pmpnueinecnwd2--
