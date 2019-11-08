Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A832CFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E0F222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573205491;
	bh=2T3Ba/HzcnTOuzzt5o+FEiAJPzM/l6yorQVOheFyKdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jrgSBVsRaeyEbqqMxpY8VbrHuyv8dekTUx32ITOKsvW86eGhe5Ji+lLsUf8oM5fA6
	 SQnK+FTYy0nAQsw+7GrcFHg5ZSFpXxpTcHA0YDHRQQ/1loPmVKlpC3IivcRftSP6m+
	 2DE5WttnvGbSaxcXOvoEdnF3G2a3V2jJWZcZATeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbfKHJba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 04:31:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:59082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729873AbfKHJb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:31:29 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B305D214DA;
        Fri,  8 Nov 2019 09:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573205487;
        bh=2T3Ba/HzcnTOuzzt5o+FEiAJPzM/l6yorQVOheFyKdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E5/QlUVw4HFCIXEX+ccAEyig5qjAsz2QnssGieCtqvgV6SriyjSz5YHdiSJtqAZyc
         tDN3I2HsDNCYL45f6eF1YEsh+u2WoYCDuaAKxnwgsVzuyb45yZG2oGnSvpwXEDpAhn
         1yfKWPSPYFegSowkz7v6+tZjwAGuqFz0F8uvzs7M=
Date:   Fri, 8 Nov 2019 10:31:24 +0100
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
Subject: Re: [PATCH v5 0/7][rebased] Add anx6345 DP/eDP bridge for Olimex
 Teres-I
Message-ID: <20191108093124.GD4345@gilmour.lan>
References: <20191107135018.0A04068BE1@verein.lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Content-Disposition: inline
In-Reply-To: <20191107135018.0A04068BE1@verein.lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 04, 2019 at 11:34:23AM +0100, Torsten Duwe wrote:
> On Wed, Nov 06, 2019 at 04:21:31PM +0100, Maxime Ripard wrote:
> >
> > Please resend the whole series rebased on top of either linux-next or
> > drm-misc-next.
>
> Here it is. Applies cleanly to both, modulo those patches already in.

applied, thanks!
Maxime
--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXcU17AAKCRDj7w1vZxhR
xVqMAQCIfvK3vHGIOLtlR1wZJ1qhlXxRXFOgO5OH2g2LK36KCgD/Tyu1aY0jCKQN
IvSTgB2bS8dNe6KkrPg33wCTDFFKtw8=
=KfZB
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
