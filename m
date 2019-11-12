Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EB0C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03FF21925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573589134;
	bh=Snz++UdcsaVDqtyqzKDLVJnVYN3dmVpXMHJ3jUKP5IY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Sn/WE/AWy2QY5dUobwHCyj1/+182ey3reGusoWgFQle5a4xyMwn8KoH504BrFCZ/f
	 /6Tvo+2wzSINVLWoBdFzYzD/skiTpqcqp+69kb476HprxQFsHEfjTU+eo3hBBULlYw
	 hqhfVyRZUxDApRFqB9pSapUFacL8hsDFJbfXxCpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfKLUFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 15:05:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:55876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfKLUFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 15:05:33 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 261A421872;
        Tue, 12 Nov 2019 20:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573589132;
        bh=Snz++UdcsaVDqtyqzKDLVJnVYN3dmVpXMHJ3jUKP5IY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vYvIjyxkX5Zo8smdNu3bWGbERygoEFwwa6KXjuXfQq+TRCeAWsmEJn1F8txa55XNl
         dcJm4I7iUpp3pdW1mO1EXGRS1dC5mvoij3dl3829qiouhIb/BOWR7tZJJ0XfhQKzdh
         RpvjGbVD5r2n9ALYNjdqHeXzOjS8r6oIv9wTYj5U=
Date:   Tue, 12 Nov 2019 21:05:29 +0100
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
Subject: Re: [PATCH] drm/bridge: fix anx6345 compilation for v5.5
Message-ID: <20191112200529.GD4345@gilmour.lan>
References: <20191112175940.GA13539@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="K3iCROrs1P5jLO0B"
Content-Disposition: inline
In-Reply-To: <20191112175940.GA13539@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--K3iCROrs1P5jLO0B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 12, 2019 at 06:59:40PM +0100, Torsten Duwe wrote:
>
> The anx6345 driver originally was copied from anx78xx.c, which has meanwhile
> seen a few changes. In particular, the removal of drm_dp_link helpers and the
> discontinuation to include drm_bridge.h from drm_crtc.h breaks compilation
> in linux-5.5. Apply equivalents of these changes to anx6345.c.
>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
>
> ---

I've pushed that fix, but it still doesn't compile on x86. I'm
guessing you're missing a depends on OF in the Kconfig option.

Maxime

--K3iCROrs1P5jLO0B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXcsQiQAKCRDj7w1vZxhR
xfxeAQCbVisRTcE1Ce3PVDIcGzEUIJUMob4fd21aFdLYVx1lNQD+JpvMUuRpM4sh
Juw/GRayY3iQ60DmSudqv+xFhRjsMAk=
=+el9
-----END PGP SIGNATURE-----

--K3iCROrs1P5jLO0B--
