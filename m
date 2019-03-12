Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27EEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE23320693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfCLPLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:11:00 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39478 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLPK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:10:59 -0400
Received: by mail-ua1-f68.google.com with SMTP id s15so902276uap.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 08:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7wqGJiWYRwkdUJyqrM6cONlJwekjbifUrqXWCARk7eo=;
        b=qeo9PdxLr/8CCnXqOC/TBccK/kGl0lXzYZNx5gpGEQJet6Ar8c/BHDqc7Dlcz/K0hd
         X9BJrsSTfApLyOD+OzR6KzJPP14gD7PKtEjz8gCfcSPNwopPvp1+dCN/k7aP3EoOriy0
         CEuHF1OXvuNavdaMDJj0bG2oKAMGeuFCHmvSA9iD+eGvshBP1iFXtBOUnq7HnUbUdYxF
         P92xcORQftvG6rzJnaZSzmoiB2PWVNoO5M0dLLRZ8JBquOgN6PjqPxHKEasy6RAGAYK0
         I2sryL894IS4eZ/wr5fgDZYKpoquoOPLKMeAYF+EjFe2YXwshe1aQ3+U2Abg8JM3IB2o
         z57Q==
X-Gm-Message-State: APjAAAVSTZwfYSh7LCbOy8Go+mILYYhs3W/oCcyKmpEcneg8WWyaowOg
        nGOdvNvWegXKdelfTs9rm/h+DxbBTb0Vr43ITdIQZlnH
X-Google-Smtp-Source: APXvYqz/+s8AtKWK5SQ10e5ziMwNSM1FsrfrQ03qMiu1k8b3sIH/4xAksB72UMEUqITJsX6O/LjW3Sfv7GCnEk+F1aY=
X-Received: by 2002:ab0:28d6:: with SMTP id g22mr2576004uaq.75.1552403458934;
 Tue, 12 Mar 2019 08:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190312144432.7668-1-andriy.shevchenko@linux.intel.com> <20190312144432.7668-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190312144432.7668-5-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Mar 2019 16:10:47 +0100
Message-ID: <CAMuHMdX8W2dJrpGOjWM0n6ToQzvz9b1XAYFK84ots0KX01tbig@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] auxdisplay: panel: Convert to use charlcd_free()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 3:46 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Convert to use charlcd_free() instead of kfree() for sake of type check.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
