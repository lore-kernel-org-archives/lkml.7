Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834E5C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD7C20644
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfHMHAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 03:00:11 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37820 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfHMHAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:00:10 -0400
Received: by mail-ot1-f65.google.com with SMTP id f17so33290942otq.4;
        Tue, 13 Aug 2019 00:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=77nlFndun7+dGLHYK0mymCeb7GTkfwqNOTyP8GLXKB4=;
        b=qboxgeRTLWXXqOowRm05AOos5Q3CNX5A3U2ihlmVjIro9my5thrpFK1uDpMEy6otGp
         mbdKyNx7rMgdztfK9jDjwWwVwfsL0mYBwan/lbwwp+fN1WSMquinV5Dwahaz/kV3XYNv
         WBu+gU0RDGNKY50ZO8rrf7X1OlcjntmM0kGYjx5TTzwLZS+zR74ZXzD+P9Hou6N6Q8HA
         n+SF/72cRlpOyEouDtYFN+BwP7J4w90EaNMEDMSwJclqAVRZ9RBTnzNfIkydwrzGiJaB
         FieBGESCtDraaRvGapP87ppnfhL+pHopDeZcpR0vdGKKl4uDN4Sx3ozHooV9g7l9skk8
         Bt9Q==
X-Gm-Message-State: APjAAAXXZur4E8GQE/Pb+kIOe4FDh0Rm3Eps/m/KDRpk//Zj9u8+hSHs
        NmUKwx2gx7LOHH+kTh/lNtP3FiA9L6QvdNvxdmY=
X-Google-Smtp-Source: APXvYqx3kK+CuMloi9M4R9/cF/K1zMbeUQFdDRf0G+wFjMbtmanXoDtwPVr9jCd4x3uBDF/WRwC/cZ09bLBJJswO7sY=
X-Received: by 2002:a9d:7a90:: with SMTP id l16mr34349798otn.297.1565679609997;
 Tue, 13 Aug 2019 00:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190812235237.21797-1-max@enpas.org> <20190812235237.21797-3-max@enpas.org>
In-Reply-To: <20190812235237.21797-3-max@enpas.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 13 Aug 2019 08:59:59 +0200
Message-ID: <CAMuHMdX8VAA+P_JYi=Xs1Q1SX3aLJuedGRNPPg0tPZ5vvfqY1w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] hwmon/ltc2990: Add platform_data support
To:     Max Staudt <max@enpas.org>
Cc:     Linux I2C <linux-i2c@vger.kernel.org>, linux-hwmon@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 1:53 AM Max Staudt <max@enpas.org> wrote:
> This allows code using i2c_new_device() to specify a measurement mode.
>
> Signed-off-by: Max Staudt <max@enpas.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
