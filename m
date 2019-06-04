Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C142C28CC3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B9224D40
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfFDIA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:00:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35945 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfFDIA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:00:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id i21so4186430ljj.3;
        Tue, 04 Jun 2019 01:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2L8XCkLmDMvU/p7RbEo4G1kyYLV+G71wvJ8lGUNsBwI=;
        b=uRIrX2Am+GpFkmzmWIB+1TsiSerVuyub17ZL7COQTsK97DyMOeM18Bd03A+lrPU8Z8
         h2i1ERFAtGlBPtSIfIAlmNZUeVHT6yFpm+aG0iwkFBtWuMrtFy0Fm4bAfKzlN3m0ggle
         EVTvPxfOweEOkOxoqfs5ZHQMzqJ5b2DJARiRcZn65vQDqGm+h/DUCaLBYz1bZPq0/6Ff
         D9bZgo5+0kkn04HhlupXswA4TC6ej/M/g5Tot6rPu34pw7Olj7SPMAX0eS/aK/XYGTCP
         7tY/xiCIZ0Ea5b8FgW1qsSz62nGbxMzrPr/TDKBdfZAaHh27nlnDRMOMlU0ch4VSwclr
         tRcA==
X-Gm-Message-State: APjAAAX/iTpmk2/9WSZe7JC7JNTXI5sF//ErbFNsdO8p2vwPCrNK27Fa
        kO5BVK1YqEj8bubJIiDiWk5sHQDr7i2S043d2tY=
X-Google-Smtp-Source: APXvYqymyjI708y5PZTas2O0wBhQG7rpPBAnl5mORMT9yPEOwJRvS4Uq7a6ONVoFwvSMDIcmDhPypSShgJJ0qxxF2+Q=
X-Received: by 2002:a2e:8555:: with SMTP id u21mr15742288ljj.133.1559635226175;
 Tue, 04 Jun 2019 01:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <1559635059-20644-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1559635059-20644-1-git-send-email-krzk@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jun 2019 10:00:14 +0200
Message-ID: <CAMuHMdW+Ax1OCohn5DKv=ae33y5Du++hJmW74g-3utW67ohEMQ@mail.gmail.com>
Subject: Re: [PATCH] parisc: configs: Remove useless UEVENT_HELPER_PATH
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 9:57 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Remove the CONFIG_UEVENT_HELPER_PATH because:
> 1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
>    CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
>    made default to 'n',
> 2. It is not recommended (help message: "This should not be used today
>    [...] creates a high system load") and was kept only for ancient
>    userland,
> 3. Certain userland specifically requests it to be disabled (systemd
>    README: "Legacy hotplug slows down the system and confuses udev").
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
