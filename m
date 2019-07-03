Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E52C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0FE21871
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfGCOiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:38:00 -0400
Received: from ns.iliad.fr ([212.27.33.1]:59528 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfGCOiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:38:00 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 4E65D201DB;
        Wed,  3 Jul 2019 16:37:59 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 37FBA20119;
        Wed,  3 Jul 2019 16:37:59 +0200 (CEST)
Subject: Re: [PATCH v2 03/10] ARM: dts: meson6: update with SPDX Licence
 identifier
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jagan Teki <jagan@amarulasolutions.com>
References: <20190527133857.30108-1-narmstrong@baylibre.com>
 <20190527133857.30108-4-narmstrong@baylibre.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <8b84928a-bf0f-43d3-b018-dbba1071528a@free.fr>
Date:   Wed, 3 Jul 2019 16:37:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190527133857.30108-4-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Wed Jul  3 16:37:59 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/2019 15:38, Neil Armstrong wrote:

> While the text specifies "of the GPL or the X11 license" the actual
> license text matches the MIT license as specified at [0]
> 
> [0] https://spdx.org/licenses/MIT.html
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm/boot/dts/meson6.dtsi | 44 +----------------------------------
>  1 file changed, 1 insertion(+), 43 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/meson6.dtsi b/arch/arm/boot/dts/meson6.dtsi
> index 65585255910a..2d31b7ce3f8c 100644
> --- a/arch/arm/boot/dts/meson6.dtsi
> +++ b/arch/arm/boot/dts/meson6.dtsi
> @@ -1,48 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>  /*
>   * Copyright 2014 Carlo Caione <carlo@caione.org>
> - *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This library is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License as
> - *     published by the Free Software Foundation; either version 2 of the
> - *     License, or (at your option) any later version.

You seem to have been so focused on the X11 vs MIT issue that you might
have overlooked the GPL issue?

You selected "GPL-2.0", while the text called for "GPL-2.0+"
(GNU General Public License v2.0 or later)

(Pointed out by Maxime in a similar patch.)

Regards.
