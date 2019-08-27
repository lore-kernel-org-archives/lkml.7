Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D5BC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D12C205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfH0LZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 07:25:18 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35056 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfH0LZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 07:25:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id 100so7515131otn.2;
        Tue, 27 Aug 2019 04:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8+QWSwWcojaDdjJrlxzolY9DpOXYYC/c2KNNIAQNvxc=;
        b=GgHSdfJSoIR7e1h4EYzJp9WUC+cxwg+AZW/pGiRkDYb0IhpYbZO9zt5Uxa8HX7Xaj8
         fiWDomNriICFUlvlgYlEdjyKDadYu79UHH/P50zmthMvSzJ0zlTSjYRrO3qxeRZ/sfyL
         Ao0fsuejYqsR8pYGhocStHRNgvV1K+mLVChPvYD7SamIMHIekUaEDA3MLj96ILT/8Edk
         n9vNXqR19cUvdWUEppXGLSuBLKJQyEqUQ+LU9ROvq40hsM6xfGc/GyNUkAQy6KyHKqeC
         8t5JoKLVvE/QkT70xgOGtTWo72f/7H4F1JNiNljUm/C87hwlkMksb2YIMW1keYU3rqr5
         irtg==
X-Gm-Message-State: APjAAAXdcSMXPSyMcaWzUSsChooAgmKwCQ2xSXiyKyoWZkbyicRrfNCK
        1v7647aDLi7UelBKUuNVXV1uK8FsqiC51KCpAUSjfw==
X-Google-Smtp-Source: APXvYqw+f7CKWP0dcOY1+7xVWxHjSrtt9IPmRKrLF7GZ2GTvQuuOyd5CeqlxVccIcLk5TLxv4hUggtxpgVwJfYzd5ew=
X-Received: by 2002:a9d:3e50:: with SMTP id h16mr16391328otg.107.1566905116634;
 Tue, 27 Aug 2019 04:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190827110854.12574-1-peda@axentia.se> <20190827110854.12574-2-peda@axentia.se>
In-Reply-To: <20190827110854.12574-2-peda@axentia.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Aug 2019 13:25:05 +0200
Message-ID: <CAMuHMdWzMSGeBrLK6TnUwJrtNqif_vgW1RTYzZXxQ9Qh5x6qTQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] fbdev: fix numbering of fbcon options
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 1:09 PM Peter Rosin <peda@axentia.se> wrote:
> Three shall be the number thou shalt count, and the number of the
> counting shall be three. Four shalt thou not count...
>
> One! Two! Five!
>
> Fixes: efb985f6b265 ("[PATCH] fbcon: Console Rotation - Add framebuffer console documentation")
> Signed-off-by: Peter Rosin <peda@axentia.se>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
