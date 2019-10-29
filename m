Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6AACA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A4920873
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572339262;
	bh=mkkA0nt6hx3V0z0UwVIpSj9LslS/iQ3ZT+43Z9OvzN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fQ1plJgLdV3xe5X37vwI+Ry5/+lNJWWCuAyXBcTasxhGuTblyp+gLn6okLlJxMqYY
	 bwFnrJ2oHXJUp8b0rvSV/myigeRViiaFHryNR+n5DJplWXyDpIGcIlIl2x65v4B8Sc
	 yEdEdOiQUHaI8MtWPkoyvjOwofsgGpIHnYAxW9DY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbfJ2IyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 04:54:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbfJ2IyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 04:54:21 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C04E20663;
        Tue, 29 Oct 2019 08:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572339260;
        bh=mkkA0nt6hx3V0z0UwVIpSj9LslS/iQ3ZT+43Z9OvzN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rvOQbaioo47qLALm3l14AHXxcxc5IYfpvJjlT7KDT/WEkmyjOQKlnSyb7eRV3WHdu
         fT9PRURUDToD06zrggmqZ8s9PCAusIcDS7FYlIzzysiQ+pR5BD6oYTZIy5palfhN14
         W5T1c8taWx9dN6yvQ24GVdJ6SbVbEiiXmQ0VWT9s=
Date:   Tue, 29 Oct 2019 09:54:01 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Subject: Re: [PATCH v11 4/7] drm/sun4i: dsi: Handle bus clock explicitly
Message-ID: <20191029085401.gvqpwmmpyml75vis@hendrix>
References: <20191025175625.8011-1-jagan@amarulasolutions.com>
 <20191025175625.8011-5-jagan@amarulasolutions.com>
 <20191028153427.pc3tnoz2d23filhx@hendrix>
 <CAMty3ZCisTrFGjzHyqSofqFAsKSLV1n2xP5Li3Lonhdi0WUZVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="unkpttpyvqhvobfg"
Content-Disposition: inline
In-Reply-To: <CAMty3ZCisTrFGjzHyqSofqFAsKSLV1n2xP5Li3Lonhdi0WUZVA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--unkpttpyvqhvobfg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 29, 2019 at 04:03:56AM +0530, Jagan Teki wrote:
> > > explicit handling of common clock would require since the A64
> > > doesn't need to mention the clock-names explicitly in dts since it
> > > support only one bus clock.
> > >
> > > Also pass clk_id NULL instead "bus" to regmap clock init function
> > > since the single clock variants no need to mention clock-names
> > > explicitly.
> >
> > You don't need explicit clock handling. Passing NULL as the argument
> > in regmap_init_mmio_clk will make it use the first clock, which is the
> > bus clock.
>
> Indeed I tried that, since NULL clk_id wouldn't enable the bus clock
> during regmap_mmio_gen_context code, passing NULL triggering vblank
> timeout.

There's a bunch of users of NULL in tree, so finding out why NULL
doesn't work is the way forward.

Maxime

--unkpttpyvqhvobfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXbf+KQAKCRDj7w1vZxhR
xQUaAQCp7d+DSgK2CMprYRTRP+TGzpbEjN4u+W/Tt1seOujvoQEA9cGaIr4yjPsP
iK0Vn3o2jO7HYtqHE03IewfUWRW4OgM=
=D4qQ
-----END PGP SIGNATURE-----

--unkpttpyvqhvobfg--
