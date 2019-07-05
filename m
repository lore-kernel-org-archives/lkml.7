Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20C7C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953612082F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfGEKMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 06:12:02 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47208 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfGEKMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 06:12:01 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9E1CA80601; Fri,  5 Jul 2019 12:11:48 +0200 (CEST)
Date:   Fri, 5 Jul 2019 12:11:51 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc:     jacek.anaszewski@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, dmurphy@ti.com,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] devicetree: Add led-backlight binding
Message-ID: <20190705101151.kmyvccbjitfqe4fv@devuan>
References: <20190701151423.30768-1-jjhiblot@ti.com>
 <20190701151423.30768-5-jjhiblot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701151423.30768-5-jjhiblot@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Add DT binding for led-backlight.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
> Cc: devicetree@vger.kernel.org
> ---

> +Required properties:
> +  - compatible: "led-backlight"
> +  - brightness-levels: Array of distinct LED brightness levels. These
> +      are in the range from 0 to 255, passed to the LED class driver.

These days, we support more (or less) than 256 brightness levels for LED.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
