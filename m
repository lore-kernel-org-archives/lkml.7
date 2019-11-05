Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AB7C010AE
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FED20869
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572950491;
	bh=tYgfDNUiKF9OG4ZAZHs1pUURXP/0w4N53wTEREG05Pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fbfvXyauu7TgyaOP8jQKfa00AJQy9qLh2AsX0AW3S7QqQ5D/z3VbNMUL/8C/ieOP2
	 n9CApTSVEQeWXmumyCkb5g5Cj6YIAN8EZ9hlWeWzNkI24rpou39k22J40mm+ysdj+V
	 glydMnCg2jqEpb9c60cHfF7W81tr4rkYJX7ov+8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388793AbfKEKla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 05:41:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388098AbfKEKla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:41:30 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 130B3206BA;
        Tue,  5 Nov 2019 10:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572950489;
        bh=tYgfDNUiKF9OG4ZAZHs1pUURXP/0w4N53wTEREG05Pk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YltowqDGvnMBn/nVPnvQGpxkN/kl/KLHSWZ4Iz4UwBznH7w+V0gcqDNuSq2yAsfbo
         oJpi2x/ApcGc+grS9NYykkB2iWQz7g1j//dPIq/0KGRZ6Kjbpcmz6+O4L0Hy/Uyb8X
         dnxCjRrctg0qduKr+uh0C4chDMp3nKA/S+k/EVUc=
Date:   Tue, 5 Nov 2019 11:41:26 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Torsten Duwe <duwe@lst.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/7] drm/bridge: split some definitions of ANX78xx to
 dedicated headers
Message-ID: <20191105104126.GC3876@gilmour.lan>
References: <20191104110400.F319F68BE1@verein.lst.de>
 <20191104110605.F012268BFE@verein.lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <20191104110605.F012268BFE@verein.lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Oct 29, 2019 at 01:16:57PM +0100, Torsten Duwe wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
>
> Some definitions currently in analogix-anx78xx.h are not restricted to
> the ANX78xx series, but also applicable to other DisplayPort
> transmitters by Analogix.
>
> Split out them to dedicated headers, and make analogix-anx78xx.h include
> them.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

This one doesn't apply on drm-misc-next. The fix doesn't look really
obvious to me, can you rebase and resend it?

I'll apply the DT bindings and the DT tree so that it's part of the
next PR I'm going to send.

Maxime

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXcFR1gAKCRDj7w1vZxhR
xV5aAQCXBnZlOkkH5HkRZaHAhmNuaFBDCCHJUlXqxSbXJL/X4QEA5kQpIKafNuiU
aw+xjEUvCpBo0PvmsdjNFuoA8dwovAI=
=FuMM
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
