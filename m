Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52153C73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317022166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfGISG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:06:27 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46835 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbfGISGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:06:25 -0400
Received: by mail-ot1-f66.google.com with SMTP id z23so20823280ote.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 11:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G9m9jbjNt70Oo3GkYvW+I8zMmltGr9hFx9mcNFoVY0c=;
        b=tNib1DuZwYbhWrh+JQlUm722vhagLSFBF65C0E2Tev4RJQsT8ZLxaxcM1ra+k6nfnn
         VZHCvMowGbW8QAWZlcxmPNZuPp1xWZBjboZVtYEEIEARXTSdikTtaHwk28lR6PzJc+2W
         rGRwkxbrzM+AhyhcGBiN9Fo9fahmSOmb2T21y8wJQhUGegWPKHJlBK/Sky3amoZ8ockh
         OZo41mcy7eZBfckfa5LDBQPlQGoNf71gbptiRVz6D7M0xoRp8kWkPQKVI941ElKUscpo
         rLnkoSatsnzFJovwX8WvQzpULemMsJGIznWMPzTcp1tnJbdqQIlW1oOIIdW4NbjfrWH4
         hkBQ==
X-Gm-Message-State: APjAAAWh8QlbTzn6+A4SuoAj/Kd4UdGIl4A6HPFjhurR6OtHgoU68ptt
        O1u5y3apb9xtmogd2zxnhSofuzcrj8eN9uZv/0k=
X-Google-Smtp-Source: APXvYqxLC1ZAyVrB8W4kmmo7reQUrDGdcGCr54mx0wK6kjwsfF7qv/ET7sPo4H2Y57rLnoHvmSfZ97NrA3ECQYergsI=
X-Received: by 2002:a9d:7a90:: with SMTP id l16mr8386870otn.297.1562695584580;
 Tue, 09 Jul 2019 11:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190620141039.9874-1-ferdinand.blomqvist@gmail.com> <20190620141039.9874-2-ferdinand.blomqvist@gmail.com>
In-Reply-To: <20190620141039.9874-2-ferdinand.blomqvist@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 9 Jul 2019 20:06:13 +0200
Message-ID: <CAMuHMdV96dj7=b9NTLua=-_kr18yQxjZhuiOFAEA8m22rSobNw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] rslib: Add tests for the encoder and decoder
To:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ferdinand,

On Thu, Jun 20, 2019 at 4:13 PM Ferdinand Blomqvist
<ferdinand.blomqvist@gmail.com> wrote:
> A Reed-Solomon code with minimum distance d can correct any error and
> erasure pattern that satisfies 2 * #error + #erasures < d. If the
> error correction capacity is exceeded, then correct decoding cannot be
> guaranteed. The decoder must, however, return a valid codeword or report
> failure.

> Note that the tests take a couple of minutes to complete.

On which hardware? ;-)

JFTR, the test succeeded on m68k, after 6 hours and 12 minutes of runtime
on an emulated Atari Falcon (ARAnyM hosted by an i7-4770).
So far I have no plans to run it on bare metal.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
