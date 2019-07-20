Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0485CC76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 13:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29792183E
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 13:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfGTNzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 09:55:18 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35512 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbfGTNzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 09:55:18 -0400
Received: by mail-qk1-f195.google.com with SMTP id r21so25446733qke.2;
        Sat, 20 Jul 2019 06:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ahfkEPbPjVvWh/5AReF1hyMp+EpgnJ/V5qr8O+zjfvU=;
        b=nBseJXYZ1WSm0E6jJZNZRMbGEuplcdB15vLtrvY2TQ9sCKpbQKsdjH2KAqjUiqKbxL
         4bJhC/01UVWYNIho6/zZl2GPKFnwA957mMHMljuLHcWIwSF8EObZ03NO9ae+L0f7ItBx
         OoBOdeNka8+C4QJ8wwNtbhTJwWd15eQa43V4zx2ahmZYrdhe8nzF/HZxOtMdT1a6NRS1
         OjI/JFrGw4qUHHJRDM0fbqE+mX+BkWy9JkKAfAYo+3nq6LwYVgLVcz4DSDHNZLLEpQSq
         yQ2M5rPiZUzO+2s57SRHUMkBuXw4R9M1M7DIZAHkzIGgl8n7P9XQmisPemnpeDxKLDDZ
         ck4A==
X-Gm-Message-State: APjAAAUg7fd7dN6uxjNHvGcg9Nb1w+VoIHPUcq3fv4rEZco/XBqYlga/
        L2VupsBkTF2V8w3/XJ1pUqdsMnVFDDttRsjjJS8=
X-Google-Smtp-Source: APXvYqwhpGKT7zSA9mD05iko8/JxymPyqR8SfuFym9s9fXdmypb7BApcUOD8RFbAF7Y64iyunzIOn2UQJBP4Vo9uteI=
X-Received: by 2002:a37:4ac3:: with SMTP id x186mr37928430qka.138.1563630917260;
 Sat, 20 Jul 2019 06:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNASyzmYjjBkFxRc06rqf36-en-bvJvrKcg6iiRfjoPCxhQ@mail.gmail.com>
In-Reply-To: <CAK7LNASyzmYjjBkFxRc06rqf36-en-bvJvrKcg6iiRfjoPCxhQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 20 Jul 2019 15:54:59 +0200
Message-ID: <CAK8P3a2AeUpmNfFLJSvHT=AJ0kFRT2B=TWDm0HsTwoHt2jQ0gQ@mail.gmail.com>
Subject: Re: [Question] orphan platform data header
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 20, 2019 at 5:26 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> masahiro@grover:~/ref/linux$ git grep netxbig_led_platform_data
> drivers/leds/leds-netxbig.c:                          struct
> netxbig_led_platform_data *pdata,
> drivers/leds/leds-netxbig.c:                                 struct
> netxbig_led_platform_data *pdata)
> drivers/leds/leds-netxbig.c:                      struct
> netxbig_led_platform_data *pdata)
> drivers/leds/leds-netxbig.c:    struct netxbig_led_platform_data
> *pdata = dev_get_platdata(&pdev->dev);
> include/linux/platform_data/leds-kirkwood-netxbig.h:struct
> netxbig_led_platform_data {
>
>
>
> So, what shall we do?
>
> Drop the board-file support? Or, keep it
> in case somebody is still using their board-files
> in downstream?

Generally speaking, I'd remove the board file support in another
case like this, but it's worth looking at when it was last used and by
what.

For this file, all boards got converted to DT, and the old setup
code removed in commit ebc278f15759 ("ARM: mvebu: remove static
LED setup for netxbig boards"), four years ago, so it's a fairly
easy decision to make it DT only.

      Arnd
