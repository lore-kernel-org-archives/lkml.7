Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27695CA9ED2
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047642246E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfKDJtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 04:49:17 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42398 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfKDJtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 04:49:17 -0500
Received: by mail-oi1-f193.google.com with SMTP id i185so13515186oif.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 01:49:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bWUvSeGgSv+muiEAKV2K5AyD4TX36f4U/j2W4wxdxfE=;
        b=EV8DauF9Ycu2Zh9smKGLxuGKHc4OhhgDDOnpAMQ+mr23ZyZby5s3neFMxfvn+9HKQt
         U/o2GOcPvJXmNl7LYvD8UA23YgzECooEef0BZp4lJ9gzeiMbUZvUiz81uNylXmtSpVNV
         xoOc0dCS09aDdxbMLUDtf6xXfV65h9TjYk3+vBTM3wJ9B/Xn/ONmpgETk2On1LOVlVbZ
         SEc4V/pFAmBUNNZvSRw/PJB7P2CEsfbnz2Ws4v0vS1YYFlvgWcSB/kRlpi/k3POtn5Q8
         SeNPWwk/yqjy47O9dp4hyNR37HN/o5/IBB4LBxnygwuqKAtsOb/SBNZcB0UXNEtofZrQ
         rXOA==
X-Gm-Message-State: APjAAAU8W+2fUZ3JdkDoIZn8MYH816Y2ei7M+pLO5zk4TsGrtuEUCAJa
        7Zk6kOhC16HCJSrb4D8Bb3eRUEWb9VxgPFtpLec=
X-Google-Smtp-Source: APXvYqyBjkS4cv/f8oPhrmfxlYdda1lj+lToTfcTy8ko+yyPHEOpDbsLt4+HHrcJe6r7hrskK+e5z9KSVJaQHYBRlxQ=
X-Received: by 2002:aca:fc92:: with SMTP id a140mr13819884oii.153.1572860956631;
 Mon, 04 Nov 2019 01:49:16 -0800 (PST)
MIME-Version: 1.0
References: <20191021070438.10819-1-geert@linux-m68k.org> <de96bb80-d706-2413-0b27-fb5dcdaea394@enpas.org>
In-Reply-To: <de96bb80-d706-2413-0b27-fb5dcdaea394@enpas.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Nov 2019 10:49:05 +0100
Message-ID: <CAMuHMdVxPVnVz49bBPe2Dgg3EgSgox0UkpdWXM0ndW-XY=5=+Q@mail.gmail.com>
Subject: Re: [PATCH] m68k: defconfig: Enable ICY I2C and LTC2990 on Amiga
To:     Max Staudt <max@enpas.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 9:29 AM Max Staudt <max@enpas.org> wrote:
> Looks good, thanks Geert!
>
> Acked-by: Max Staudt <max@enpas.org>

Thanks, queuing for v5.5.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
