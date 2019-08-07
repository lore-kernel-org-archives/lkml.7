Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9A6C19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9255C217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfHGHmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 03:42:38 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39678 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfHGHmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 03:42:38 -0400
Received: by mail-qt1-f195.google.com with SMTP id l9so87332081qtu.6;
        Wed, 07 Aug 2019 00:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YX5oJHAYwAnKvXPilaQ3uI0rZTwKEluEk/x0jK9UBHc=;
        b=jnP+gg7RLW4s4uJZ/qbzak/gM1fMFdcWTe0h2mEDRmHTFY9FtMl1YGkqd5Q9hV9aBE
         koAF/r4UVGyvraIoY5WXfz3GTnCIDanrjnkyejDrP3eaCaM5IEv5V72q2bYmdCR7wrcP
         V+63VFozE5k/RHq/1qHqYKby/rOZZlU9+IB32+3FawLkA6eZADzJ2E3F/ky4TdwwXX2R
         T8Pg/l+FG/R9aaT+7kf55xpYsIACDIGL1mKuYv/w9e18e9ZKXqv7JOdXHhnjwWFJX31r
         aujgbSZa8QhuBdx5gjUnRntoRCHdoDUqGt5oueTtNoFtRkpZMNl8H6sJVM5Pw6MjAJy2
         Mpug==
X-Gm-Message-State: APjAAAW9YvJLasZ9a/jv+Bj/0FDARpVEy6inUTWA8bOyQMV5HNBMeEZ9
        pDllymnsZtKpaE26zf1I7ysefEjqR4MO1GpbdsVxFp0xOIE=
X-Google-Smtp-Source: APXvYqyKB2tVYAAT3rlbv0b6ctqmVwAp8nB6JmQP5aZNXyqWzCt97zXDWHk7SuHH/7noDZYiNVXF5UDbXIxTh43hCSs=
X-Received: by 2002:a0c:ba2c:: with SMTP id w44mr6658392qvf.62.1565163757053;
 Wed, 07 Aug 2019 00:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190807102517.5d2c2873@canb.auug.org.au>
In-Reply-To: <20190807102517.5d2c2873@canb.auug.org.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 7 Aug 2019 09:42:20 +0200
Message-ID: <CAK8P3a1cGR5y=EFuAOEXyZExXnVi=JcHvVJ0iw=MyY0rvrAmXg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the mips tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 2:25 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the mips tree got a conflict in:
>
>   arch/mips/include/asm/vdso/vdso.h
> ( arch/mips/vdso/vdso.h in Linus' tree)
>
> between commit:
>
>   ee38d94a0ad8 ("page flags: prioritize kasan bits over last-cpuid")
>
> from Linus' tree and commit:
>
>   6393e6064486 ("mips: fix vdso32 build, again")
>
> from the mips tree.
>
> I fixed it up (I just used the mips tree version) and can carry the fix
> as necessary. This is now fixed as far as linux-next is concerned, but
> any non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Yes, that resolution is correct. My original fix for the issue in ee38d94a0ad8
got folded into that patch when it was merged, but as the vdso is now
completely different in the mips tree, the newer fix is needed there
compared to what is in Linus' tree.

       Arnd
