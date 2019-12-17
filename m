Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A85C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C787B2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576583882;
	bh=4e+G10S/FO/9s5pwKDuay77jsJQF2GsOh3k8d0+BUzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kQ75oSudYdgbmUsQ1MFxdLIGkDqk2PcXNgSYf3YI4+DRxxiHxC2JDJIlFQKrCfP7j
	 UTxEgr2jHnqykLW1RdCkoDUiN9VPkQrdkhuafpaDqlpy0Actj3teMCfotPUHDo6Tbt
	 Vxe8lzY74NQQRVlYCis4JjmfJKLEKAUvxJwA0utY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfLQL6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:58:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:33572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfLQL6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:58:01 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E1ED207FF;
        Tue, 17 Dec 2019 11:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576583879;
        bh=4e+G10S/FO/9s5pwKDuay77jsJQF2GsOh3k8d0+BUzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RURNKPS4sbmp6fGE0V82D4fpoHPYb1KpU1XXY4gxROsxJb9pmtwXZlz2GAM1BNGBM
         Tzn8dBak5abMP9bbODmAIvxxn5f0dsTY4S/Ns+/GY++PdC0H/NaFoo4eQbRdsT2hI2
         7CdUU6EBF/9AXoTrWIXRadpwn56NZBoZPn1nBQ6c=
Date:   Tue, 17 Dec 2019 12:57:57 +0100
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
Subject: Re: [PATCH 1/1] drm/sun4i: hdmi: Check for null pointer before
 cleanup
Message-ID: <20191217115757.ptoscpwuyv6tmwtc@gilmour.lan>
References: <20191216144348.7540-1-stefan@olimex.com>
 <20191216161258.lmkq2ersfm746t7q@gilmour.lan>
 <cebda755-2649-79a1-fd08-79b13edef1a5@olimex.com>
 <20191217114603.6cyrfx3sekn6uwmp@gilmour.lan>
 <20191217114906.lrjup35tngrjhwuj@gilmour.lan>
 <83088170-1753-6a2f-aa25-c4f6f54462d6@olimex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dayinannzkrhuxa6"
Content-Disposition: inline
In-Reply-To: <83088170-1753-6a2f-aa25-c4f6f54462d6@olimex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dayinannzkrhuxa6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 17, 2019 at 01:54:56PM +0200, Stefan Mavrodiev wrote:
> Hi,
>
> On 12/17/19 1:49 PM, Maxime Ripard wrote:
> > On Tue, Dec 17, 2019 at 12:46:03PM +0100, Maxime Ripard wrote:
> > > On Tue, Dec 17, 2019 at 08:45:07AM +0200, Stefan Mavrodiev wrote:
> > > > Hi,
> > > >
> > > > On 12/16/19 6:12 PM, Maxime Ripard wrote:
> > > > > Hi,
> > > > >
> > > > > On Mon, Dec 16, 2019 at 04:43:48PM +0200, Stefan Mavrodiev wrote:
> > > > > > It's possible hdmi->connector and hdmi->encoder divices to be NULL.
> > > > > > This can happen when building as kernel module and you try to remove
> > > > > > the module.
> > > > > >
> > > > > > This patch make simple null check, before calling the cleanup functions.
> > > > > >
> > > > > > Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> > > > > > ---
> > > > > >    drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 6 ++++--
> > > > > >    1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> > > > > > index a7c4654445c7..b61e00f2ecb8 100644
> > > > > > --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> > > > > > +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> > > > > > @@ -685,8 +685,10 @@ static void sun4i_hdmi_unbind(struct device *dev, struct device *master,
> > > > > >    	struct sun4i_hdmi *hdmi = dev_get_drvdata(dev);
> > > > > >
> > > > > >    	cec_unregister_adapter(hdmi->cec_adap);
> > > > > > -	drm_connector_cleanup(&hdmi->connector);
> > > > > > -	drm_encoder_cleanup(&hdmi->encoder);
> > > > > > +	if (hdmi->connector.dev)
> > > > > > +		drm_connector_cleanup(&hdmi->connector);
> > > > > > +	if (hdmi->encoder.dev)
> > > > > > +		drm_encoder_cleanup(&hdmi->encoder);
> > > > > Hmmm, this doesn't look right. Do you have more information on how you
> > > > > can reproduce it?
> > > > Just build sun4i_drm_hdmi as module (CONFIG_DRM_SUN4I_HDMI=m). Then try to
> > > > unload the module:
> > > >
> > > > # rmmod sun4i_drm_hdmi
> > > >
> > > > And you get this:
> > > >
> > > > Unable to handle kernel NULL pointer dereference at virtual address 00000000
> > > > pgd = 6b032436
> > > > [00000000] *pgd=00000000
> > > > Internal error: Oops: 5 [#1] SMP ARM
> > > > Modules linked in: sun4i_drm_hdmi(-)
> > > > CPU: 0 PID: 1081 Comm: rmmod Not tainted 5.5.0-rc1-00030-g6ec417030d93 #33
> > > > Hardware name: Allwinner sun7i (A20) Family
> > > > PC is at drm_connector_cleanup+0x40/0x208
> > > > LR is at sun4i_hdmi_unbind+0x10/0x54 [sun4i_drm_hdmi]
> > > > ...
> > > >
> > > >
> > > > I've tested that with sunxi/for-next branch on A20-OLinuXino board.
> > > Yeah, you detailed the symptoms nicely in the commit log, but my point
> > > was that we shouldn't end up in that situation in the first place.
> > >
> > > Your patch works around it, but it doesn't fix the underlying
> > > issue. Is drm_connector_cleanup (or the encoder variant) called twice?
> > Answering myself, yes it is. It's both the destroy call back and
> > called in unbind. We should just remove the one in the unbind then.
>
> Should I do this or leave it to you?

You started that discussion, so it's only fair that you do the patch :)

Maxime

--dayinannzkrhuxa6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXfjCxQAKCRDj7w1vZxhR
xfLKAP9uC6OKBMcKNc6CYIMqeNfUrMweif6tfqGtZf8vZlp9lAD/RYm1F844WPIb
0gupK39Mzpkm6H5yDih2P1r7Xx5T6QA=
=KJ4f
-----END PGP SIGNATURE-----

--dayinannzkrhuxa6--
