Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26DAC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581B321D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576707488;
	bh=xhXZ+35S+/6cI1WWLxRqDqVB+Krevd61uwH4joVkI+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kjSTskZz/T48xS/k2sm/h+uhVeP6ODwgNXgE3ZMuCWdVnsAuzIrJEReiSnS6X1nz9
	 tRf5HfDlbXg47ow4bSDsoLlqSLY15qNTflruAn80Rn+CpXEX4VRJA5cL6FFZ+bp0Ae
	 0GnP34o4/wt4HuSRLa06m50vbeP9t0kieWwKfP34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfLRWSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 17:18:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:50624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbfLRWSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 17:18:07 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36D63218AC;
        Wed, 18 Dec 2019 22:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576707486;
        bh=xhXZ+35S+/6cI1WWLxRqDqVB+Krevd61uwH4joVkI+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O08qVggBfYFX7mdzqneUUMrtP8xNId4jbqmESqBDwYUUX3GQKLvJc9Tc3uf5MXvet
         YEQ0XBPl8A0jLwLu4r7wd1Jsbj4fiDXw0WD5pHhTEV4r2dtj+HgltfdRHawWdXTZhZ
         w+u1QRxMDDARMOhd6brItV7mj6s/du1DOpjSywN4=
Date:   Wed, 18 Dec 2019 23:18:04 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/1] drm/sun4i: hdmi: Remove duplicate cleanup calls
Message-ID: <20191218221804.5nlobcy2bcxvlsr5@gilmour.lan>
References: <20191217124632.20820-1-stefan@olimex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t3hsvrwjuxfiwifc"
Content-Disposition: inline
In-Reply-To: <20191217124632.20820-1-stefan@olimex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t3hsvrwjuxfiwifc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 17, 2019 at 02:46:32PM +0200, Stefan Mavrodiev wrote:
> When the HDMI unbinds drm_connector_cleanup() and drm_encoder_cleanup()
> are called. This also happens when the connector and the encoder are
> destroyed. This double call triggers a NULL pointer exception.
>
> The patch fixes this by removing the cleanup calls in the unbind
> function.
>
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>

Added a fixes tag, and cc'd stable, and applied, thanks!
Maxime

--t3hsvrwjuxfiwifc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXfqlmwAKCRDj7w1vZxhR
xZ3vAP9s6v4QB4Gp5qZQbl7J9vhz9/z9g/OiEFIVY3exwU1eGQD+Kd9eK1IzBZNQ
jnb58LSELiAKgpGxPmoTsqILx6OCng0=
=8IeF
-----END PGP SIGNATURE-----

--t3hsvrwjuxfiwifc--
