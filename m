Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41739C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1672F20882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440267AbfIWR52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 13:57:28 -0400
Received: from mx1.riseup.net ([198.252.153.129]:48390 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393421AbfIWR51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 13:57:27 -0400
Received: from bell.riseup.net (bell-pn.riseup.net [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id E3D001A0DA7;
        Mon, 23 Sep 2019 10:57:25 -0700 (PDT)
X-Riseup-User-ID: 09F0AE2C6C56BF08CD5EBE05B5951D0EEE3EBD23478EAC0475B93738BB7874E8
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id F1B7E2249A0;
        Mon, 23 Sep 2019 10:57:21 -0700 (PDT)
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     paul.kocialkowski@bootlin.com, GNUtoo@cyberdimension.org
References: <CGME20190921125017epcas3p2f5661cca04f0959f9707f6111102435d@epcas3p2.samsung.com>
 <20190921124843.6967-1-joonas.kylmala@iki.fi>
 <d8a8bf25-0c5e-8d94-9406-b1f74e3edfac@samsung.com>
From:   =?UTF-8?Q?Joonas_Kylm=c3=a4l=c3=a4?= <joonas.kylmala@iki.fi>
Openpgp: preference=signencrypt
Autocrypt: addr=joonas.kylmala@iki.fi; prefer-encrypt=mutual; keydata=
 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
 gKPkEg==
Subject: Re: [PATCH] drm/panel: samsung: s6e8aa0: Add backlight control
 support
Message-ID: <08a83744-ed02-d641-e2a4-db2247ae53de@iki.fi>
Date:   Mon, 23 Sep 2019 20:57:17 +0300
MIME-Version: 1.0
In-Reply-To: <d8a8bf25-0c5e-8d94-9406-b1f74e3edfac@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks a lot for the review, Andrzej!

Andrzej Hajda:
>> +static const struct backlight_ops s6e8aa0_backlight_ops = {
>> +	.update_status	= s6e8aa0_set_brightness,
> 
> 
> This is racy, update_status can be called in any time between probe and
> remove, particularly:
> 
> a) before panel enable,
> 
> b) during panel enable,
> 
> c) when panel is enabled,
> 
> d) during panel disable,
> 
> e) after panel disable,
> 
> 
> b and d are racy for sure - backlight and drm callbacks are async.
> 
> IMO the best solution would be to register backlight after attaching
> panel to drm, but for this drm_panel_funcs should have attach/detach
> callbacks (like drm_bridge_funcs),
> 
> then update_status callback should take some drm_connector lock to
> synchronize with drm, and write to hw only when pipe is enabled.

I will start reading the kernel DRM KMS documentation in order to learn
how the attach callback would fit in the picture and do what you suggest
but it might take a few weeks or months.

Also, as a lot of this code was mimicked from
drivers/gpu/drm/panel/panel-samsung-s6e63m0.c it looks like that is also
having this race condition. Unfortunately, I don't think I have the
s6e63m0 panel so for that I probably cannot fix this issue.

Joonas
