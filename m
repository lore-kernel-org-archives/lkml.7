Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5E4C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 20:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2732620838
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 20:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfGNUHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 16:07:32 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43266 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbfGNUHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 16:07:32 -0400
Received: by mail-qk1-f196.google.com with SMTP id m14so10122550qka.10
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 13:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bfoyMA7g1w51HUrGmtfSjBB3Vcx0aRvt9dP00QQ+dYc=;
        b=i3J+8mdFZ9j6EbLkxEu6KBqgCTN+UthIteuAlaUxZA04Vg29ZAr0Cqv1dwCiP7MWGT
         of8Zk4JmdGHkVtQGSl3GLwRedvHOzKjkyjrFREt6kwlJx1DOa9BCieIl2iqxHMt2L59K
         sNLu/KKqEOZOtkaJt4FpzMbC9L1DNXmzaZEcSELpBf8jyYf8TjxnLhMQNrYC+P+ClQqw
         VerdFId2fCKZxP2pFnZ2oG9EbI55NvetJxANYFicL+XexKKBU4nSkdoOZZkpHH6buoYj
         Nabv4FvHTaHx1p5xn5UIq2AYXuy6dLW3FPIWYu7iTGfRWGVKpMa+spk6Y+0yQAvkQF4i
         bttw==
X-Gm-Message-State: APjAAAWoY3rc9InSxdPO2En/C7ukiJB2E9m/J4W6sSIRHXQvjbUJti1o
        1VnM2B5J5oDeNtPOEOPTzAK9ikkGq8QBBp+EeljWMk74
X-Google-Smtp-Source: APXvYqztFYGlPtgx/3yaV6VwqI4yJ+/27KE62Ixbn7Z/GwQptLKsYOUyyCWWSST0G5XJ6gVr/aK3aGSk0LOP1BfO/yM=
X-Received: by 2002:a37:76c5:: with SMTP id r188mr13861509qkc.394.1563134851204;
 Sun, 14 Jul 2019 13:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190714192205.27190-1-christian@brauner.io>
In-Reply-To: <20190714192205.27190-1-christian@brauner.io>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 14 Jul 2019 22:07:13 +0200
Message-ID: <CAK8P3a23y0UFbu-po-Umh-=9DUTpRyzRkB=RxJd1A+YJVTTGrA@mail.gmail.com>
Subject: Re: [PATCH 0/2] clone3 fixes
To:     Christian Brauner <christian@brauner.io>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2019 at 9:22 PM Christian Brauner <christian@brauner.io> wrote:
>
> Hey everyone,
>
> Here are two small fixes/improvements for the clone3 syscall that I plan
> on sending soon.
>
> The first patches reserves the clone3 syscalls number 435 across all
> architectures by placing a commit in the corresponding syscall tables of
> architectures that do not yet implement clone3. This is done to preserve
> the identical numbering for all new syscalls that Arnd introduced.
>
> The second patch dates back to a discussion with Arnd when I suggested
> reserving the syscall number. Arnd suggested to ensure that we catch all
> arches that do implement clone3 without explicitly setting
> __ARCH_WANT_SYS_CLONE3.

Both patches

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
