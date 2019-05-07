Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB681C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B687D20989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfEGG4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:56:40 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:32809 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfEGG4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:56:40 -0400
Received: by mail-vk1-f195.google.com with SMTP id r195so3796876vke.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 23:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=G9/9K0rq5nGHfHISp2XHAr4LKBOhZnBOjj4ANxEXHd8=;
        b=QAMruxhtzDMgQWxPrJfx3Y8ip/AOCuaRZAf3x9/cr0/jQseU/Z/LSOomg52s8teX5v
         PYr+xk5Zfzo7yjU5HC04ArfodQDuv7nYJBjuTC/nmlrNh0+lKr6GccXePeouroI7XMXx
         zd3SJvqHeW19uynb4bBTQlH5DRdU/PJwv1+BtIq5C/7fNzkvzv+bi1FU7p1gzVo75p7Q
         +n5fI5n15l9ZnhbcbCAAegwzDCLIlMVGoj0g69THFMqL6Tskzv3ySGB1kvsTD3lpJAUo
         j15+pEprW6DTK8zR/EmpitO15a+vIN/OUjV2+Xpc8BPMTAz9375k2JOy5G+Qd0eSSYap
         rQGg==
X-Gm-Message-State: APjAAAU8xwGB+GxJmnNdT/Y62yJUu8QDYSQtIVqcP+wZ6V9nJq9O6l5x
        z9qdSLDHFXy7VQCoG9J9clzIu0B2nOpy1m0N0Qta7w==
X-Google-Smtp-Source: APXvYqxPX4jCpcW+866IjucNuww+AIBVfUXXNEHeuKZnq9czOWVGOvioeoeHuNfw54cRxR4EemPbUsAPfgmNtGEaw3k=
X-Received: by 2002:a1f:c2c1:: with SMTP id s184mr6275483vkf.65.1557212198471;
 Mon, 06 May 2019 23:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190507064844.15299-1-geert@linux-m68k.org>
In-Reply-To: <20190507064844.15299-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 May 2019 08:56:26 +0200
Message-ID: <CAMuHMdXC+bPCCbLKGQvV+nan_r1j+Sm-yUprDYOKHXOBzCCfTw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 8:49 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v5.1[1] compared to v5.0[2].
>
> Summarized:
>   - build errors: +1/-1
>   - build warnings: +126/-105
>
> JFYI, when comparing v5.1[1] to v5.1-rc7[3], the summaries are:
>   - build errors: +0/-1
>   - build warnings: +102/-61

The warning regressions look a bit excessive to me, for a final
v5.1 release...

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd/ (all 236 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/1c163f4c7b3f621efff9b28a47abb36f7378d783/ (all 236 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/37624b58542fb9f2d9a70e6ea006ef8a5f66c30b/ (all 236 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
