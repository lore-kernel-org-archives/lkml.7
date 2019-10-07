Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F4DC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA4D2173B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570450035;
	bh=arbaz8x3puASuQCFv3RH3ysmpiBHcA2eOWy0FamGrFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d2bkA56KK2SFsil52g8bGAnPHIdXPFMbwBrjx7ttbqmPoJDSwcgIwQ7B/rND+Rc58
	 pRAT0x4C2Y0O9gzWyXARuRS2OqJQczKCv+UOMpGsBFE679x3QkhaTimjmJA6mRpjY+
	 9HEfy4nyFc2UlphUsDZyWnAIVEcthpjQXhgOjI50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfJGMHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:07:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727905AbfJGMHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:07:14 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A59320867;
        Mon,  7 Oct 2019 12:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570450034;
        bh=arbaz8x3puASuQCFv3RH3ysmpiBHcA2eOWy0FamGrFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MnVmxZLoAkVyRKheU9X/YR5bMo6nKlHmcKS2ro6emQd2eneWrMDXRAALYjSXBxp1a
         X5Su7sdTQdbaq81iyYhr3iDbwOwriy8ZJQkNLXJ15ST40Mr4CcXjVRu2h6fGWExYN0
         KKxfdvMTK6e3SF6GYyWpJfvVJH5ai1c/WiucEvsM=
Date:   Mon, 7 Oct 2019 14:07:10 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 3/3] drm/sun4i: sun6i_mipi_dsi: fix DCS long write
 packet length
Message-ID: <20191007120710.zhm6wkm32kpsqv5m@gilmour>
References: <20191006160303.24413-1-icenowy@aosc.io>
 <20191006160303.24413-4-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q5xk63oitgdknstb"
Content-Disposition: inline
In-Reply-To: <20191006160303.24413-4-icenowy@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q5xk63oitgdknstb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 07, 2019 at 12:03:02AM +0800, Icenowy Zheng wrote:
> The packet length of DCS long write packet should not be added with 1
> when constructing long write packet.
>
> Fix this.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied, thanks

Maxime

--q5xk63oitgdknstb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXZsqbgAKCRDj7w1vZxhR
xWdGAPoD+SGxYVP/cSUjH/jrEJNThDwZjOU59WN8z3Qi9XF3BgEA0tiZksS/LTVL
rAlkltweDTGTlptVDBSyEjKNKRqzmg4=
=Ua0x
-----END PGP SIGNATURE-----

--q5xk63oitgdknstb--
