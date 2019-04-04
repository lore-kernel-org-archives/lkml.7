Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD481C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AFE2133D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfDDAJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:09:14 -0400
Received: from muru.com ([72.249.23.125]:44270 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfDDAJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:09:13 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 66E7D803A;
        Thu,  4 Apr 2019 00:09:27 +0000 (UTC)
Date:   Wed, 3 Apr 2019 17:09:09 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 4/4] leds: lm3532: Introduce the lm3532 LED driver
Message-ID: <20190404000909.GY49658@atomide.com>
References: <20190321142838.22985-1-dmurphy@ti.com>
 <20190321142838.22985-4-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321142838.22985-4-dmurphy@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dan Murphy <dmurphy@ti.com> [190321 14:29]:
> Introduce the Texas Instruments LM3532 White LED driver.
> The driver supports ALS configurability or manual brightness
> control.
> 
> The driver also supports associating LED strings with specific
> control banks in a group or as individually controlled strings.

I'm seeing slightly different naming under /sys/class/leds:

lm3532:backlight
lm3532:platform::kbd_backlight

Not sure if this is correct with the the "platform" and
"::" there for the kbd_backlight?

With the dts change I posted, I've tested this with
linux-next and Sebastian's DSI command mode patches
"[PATCHv6 0/4] omapdrm: DSI command mode panel support".

So feel free to add:

Tested-by: Tony Lindgren <tony@atomide.com>
