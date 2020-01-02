Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F57C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527F524125
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgABJGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 04:06:01 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:36022 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgABJGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 04:06:00 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id C7E8A20027;
        Thu,  2 Jan 2020 10:05:55 +0100 (CET)
Date:   Thu, 2 Jan 2020 10:05:54 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, lee.jones@linaro.org
Cc:     boris.brezillon@bootlin.com, airlied@linux.ie,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        lee.jones@linaro.org, peda@axentia.se,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] fixes for atmel-hlcdc
Message-ID: <20200102090554.GB29446@ravnborg.org>
References: <1576672109-22707-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576672109-22707-1-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=MpWoGPNM3uDNEO5XxNkA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee.

How do de handle the two mfd related patches?

> I have few fixes for atmel-hlcdc driver in this series as well
> as two reverts.
> Revert "drm: atmel-hlcdc: enable sys_clk during initalization." is
> due to the fix in in patch 2/5.
> 
> Thank you,
> Claudiu Beznea
> 
> Changes in v3:
> - changes dev_err() message in patch 4/6
> - collect Acked-by tags
> 
> Changes in v2:
> - introduce patch 3/6
> - use dev_err() inpatch 4/6
> - introduce patch 5/6 instead of reverting commit f6f7ad323461
>   ("drm/atmel-hlcdc: allow selecting a higher pixel-clock than requested")
> 
> Claudiu Beznea (5):
>   drm: atmel-hlcdc: use double rate for pixel clock only if supported
>   drm: atmel-hlcdc: enable clock before configuring timing engine

>   mfd: atmel-hlcdc: add struct device member to struct
>     atmel_hlcdc_regmap
>   mfd: atmel-hlcdc: return in case of error

Would it be OK to apply the to drm-misc-next, or shal they go in via
your mfd tree?

	Sam
