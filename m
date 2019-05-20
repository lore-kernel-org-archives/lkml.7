Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F712C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2529720856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731762AbfETJEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:04:38 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37238 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbfETJEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:04:37 -0400
Received: by mail-vs1-f65.google.com with SMTP id o5so8459441vsq.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 02:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5PAbs8C7MfUj+AVLTb1TSwGH3gvMGuk7/i/KIBisyLk=;
        b=V0wOlEnBDNo2xOAgcTWBMEUgy4nQp1mf1Fls+Th+p95AQhnd9zKh0xa5530IKRbe1g
         T6eP9gsBcuTy8UpAeNTJaAmycFatpDKS/58zW+lLzTk4qwntpzsS6ykF0pNncZKfQiPH
         WwmcnEx55Xgb4AA+CU7Yb4kD/DexAfFOZwmg//wsk2ZuUxVU0ORQEzrLxArp2L6LkdCR
         c72a7pnZv9H9btzmfITnNhO62FxqngB+okuxEVxO0eZlT4UWh06oRVEx9c7iz68R+FrV
         LkFSzn7pgs1a8XxFJM82UO2LDyq1AeQCI73gMB4tBaeAJ+BYT9ppO30yXvwgSK7NE4c+
         f5dw==
X-Gm-Message-State: APjAAAUCBF+sFFLsMwM4Wd6lO9VRYYeTLPpcBbN4Q5I7U8AsJNV6bBDV
        ICemw+A8aMZ5bkqq8/13L+EV2U/arWKPsT/eFTc=
X-Google-Smtp-Source: APXvYqwAa/pzv5JhQ33nlEbDmGsUYUBL2mLFKEWcG/eGbBs4BbpWZisM249gNJP8P2wpfwrzM7QCZz6idyRHk5VKUhs=
X-Received: by 2002:a67:f589:: with SMTP id i9mr2975411vso.152.1558343076612;
 Mon, 20 May 2019 02:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch> <20190520082216.26273-12-daniel.vetter@ffwll.ch>
In-Reply-To: <20190520082216.26273-12-daniel.vetter@ffwll.ch>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 May 2019 11:04:25 +0200
Message-ID: <CAMuHMdV==Vd-W3BuLTykgcSyokSF=TKCP0yD1fD8aHG6styrJw@mail.gmail.com>
Subject: Re: [PATCH 11/33] fbdev/sh_mobile: remove sh_mobile_lcdc_display_notify
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 10:25 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> It's dead code, and removing it avoids me having to understand
> what it's doing with lock_fb_info.
>
> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
