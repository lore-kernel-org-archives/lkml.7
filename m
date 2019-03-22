Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE64C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B118E21925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfCVWQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:16:58 -0400
Received: from muru.com ([72.249.23.125]:42206 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbfCVWQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:16:57 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9535080DB;
        Fri, 22 Mar 2019 22:17:10 +0000 (UTC)
Date:   Fri, 22 Mar 2019 15:16:54 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 4/4] leds: lm3532: Introduce the lm3532 LED driver
Message-ID: <20190322221654.GG19425@atomide.com>
References: <20190321142838.22985-1-dmurphy@ti.com>
 <20190321142838.22985-4-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321142838.22985-4-dmurphy@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Dan Murphy <dmurphy@ti.com> [190321 14:29]:
> Introduce the Texas Instruments LM3532 White LED driver.
> The driver supports ALS configurability or manual brightness
> control.
> 
> The driver also supports associating LED strings with specific
> control banks in a group or as individually controlled strings.

Thanks for getting this driver done. I need help a bit using
this though.. What's the glue to the drm driver?

I can control the backlight brightness just fine via /sys, and
backlight shows up as the trigger in /sys/class/leds/lm3532:backlight,
but /sys/class/backlight is empty and looks like drm can't find it.

Do I need to enable some additional driver(s) to get this to work
with the drm driver?

Regards,

Tony
