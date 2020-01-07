Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB5AC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F9220656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgAGNpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:45:42 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:43950 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgAGNpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:45:42 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B41E61C2453; Tue,  7 Jan 2020 14:45:40 +0100 (CET)
Date:   Tue, 7 Jan 2020 14:45:40 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Jean-Jacques Hiblot <jjhiblot@ti.com>,
        jacek.anaszewski@gmail.com, sre@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, daniel.thompson@linaro.org, dmurphy@ti.com,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com
Subject: Re: [PATCH v10 6/6] backlight: add led-backlight driver
Message-ID: <20200107134540.x5tngzoslssesb2y@ucw.cz>
References: <20191009085127.22843-1-jjhiblot@ti.com>
 <20191009085127.22843-7-jjhiblot@ti.com>
 <20191121181350.GN43123@atomide.com>
 <20200107102800.GG14821@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107102800.GG14821@dell>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > * Jean-Jacques Hiblot <jjhiblot@ti.com> [700101 00:00]:
> > > From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > > 
> > > This patch adds a led-backlight driver (led_bl), which is similar to
> > > pwm_bl except the driver uses a LED class driver to adjust the
> > > brightness in the HW. Multiple LEDs can be used for a single backlight.
> > ...
> > 
> > > +	ret = of_property_read_u32(node, "default-brightness", &value);
> > > +	if (!ret && value <= priv->max_brightness)
> > > +		priv->default_brightness = value;
> > > +	else if (!ret  && value > priv->max_brightness)
> > > +		dev_warn(dev, "Invalid default brightness. Ignoring it\n");
> > 
> > Hmm so just wondering.. Are we using "default-brightness" instead of the
> > usual "default-brightness-level" here?
> 
> Did this get answered?
> 
> > Please Cc me on the next patchset too :)
> 
> I've been waiting for v11.

I guess I could just remove it from a merge for now if there's no other
fix.

Best regards,
								Pavel
