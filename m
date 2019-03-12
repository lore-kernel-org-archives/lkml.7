Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2BAC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7527220693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfCLPFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:05:23 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33604 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfCLPFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:05:18 -0400
Received: by mail-vs1-f67.google.com with SMTP id z6so1698200vsc.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 08:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DUb+FwFUDYf1oJ6d6oQQ3UrXaveonxcoSu5KLD2qH7c=;
        b=oh5GZfchgrB15u1Cm26h6MVjGAgnPIkuCpneSU+Z12zddCPo/usQO1/bjIs24VYI4J
         kwqvAPdfxoCLJ6jQF/6VjRsUXU2nyQU1QIJNgRmDC5ZnDLiCtbhynp/HuzEve0zCX/zd
         SSfGwPCran4lg+/jdoRFpCgCk6IQiN1h/TqTWWNURPjqoyQKjNUL5w9xqdQvizOkFifw
         Awsu3jAM7F1esdlcMVhVURpBYdnmZo9Fxjt45C3YiXz88P9UcDtRHVOF9p+xlq3mz1/e
         oipMTx1pH46yaa1e63dCSBw2+yMfkdT7ZCHt8IO3ZZLp4+4uMFbyDBZ+psGAOGrQY1Gb
         Q8/w==
X-Gm-Message-State: APjAAAW1nMXAbwTkZSCq8FKCyrIduBNg/Z2Nacir9u+bk52fHjDAj5GF
        bSdmES6x6a+P+p2iqJG9AWgApGT2pJQxE/nCHJA=
X-Google-Smtp-Source: APXvYqyEDW0VqrYZX/kVvK3B7e/YGoertCglchz7GzjTv5p2tKoN+KClxtZZCmKwLYKyqH0X02MlcMcW5zmucQOxvWI=
X-Received: by 2002:a67:8588:: with SMTP id h130mr19176623vsd.11.1552403117896;
 Tue, 12 Mar 2019 08:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190312144432.7668-1-andriy.shevchenko@linux.intel.com> <20190312144432.7668-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190312144432.7668-2-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Mar 2019 16:05:06 +0100
Message-ID: <CAMuHMdU+CsZ_YHwHwc99omjK1pdXW4B0Zq5rP5HAC=nbituQLw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] auxdisplay: hd44780: Fix memory leak on ->remove()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 3:44 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> We have to free on ->remove() the allocated resources on ->probe().
>
> Fixes: d47d88361fee ("auxdisplay: Add HD44780 Character LCD support")
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
