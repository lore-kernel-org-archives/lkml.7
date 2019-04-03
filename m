Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BADC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD94F20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfDCRI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:08:56 -0400
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:35969 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbfDCRI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:08:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 8CD3B182CF66F;
        Wed,  3 Apr 2019 17:08:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: loss59_308304f39563a
X-Filterd-Recvd-Size: 2262
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Wed,  3 Apr 2019 17:08:53 +0000 (UTC)
Message-ID: <8e1f0d1c009e95bc378c8834ac75029b59b7cba9.camel@perches.com>
Subject: Re: [PATCH 1/4] ARM: dts: sama5d{2,4}: use SPDX-License-Identifier
From:   Joe Perches <joe@perches.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 03 Apr 2019 10:08:52 -0700
In-Reply-To: <20190403162206.15794-1-alexandre.belloni@bootlin.com>
References: <20190403162206.15794-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-03 at 18:22 +0200, Alexandre Belloni wrote:
> The X11 license text [1] is explicitly for the X Consortium and has a
> couple of extra clauses. The MIT license text [2] is actually what the
> current DT files claim.
[]
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
[]
> @@ -1,46 +1,9 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)

Nope - NAK...

That's not the correct identifier.
It's not GPL-2.0, it's either GPL-2.0+ or GPL-2.0-or-later

Check this for all submitted patches in this series.

>  /*
>   * sama5d2.dtsi - Device Tree Include file for SAMA5D2 family SoC
>   *
>   *  Copyright (C) 2015 Atmel,
>   *                2015 Ludovic Desroches <ludovic.desroches@atmel.com>
> - *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License as
> - *     published by the Free Software Foundation; either version 2 of the
> - *     License, or (at your option) any later version.
> 

