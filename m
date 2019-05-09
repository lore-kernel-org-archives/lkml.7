Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C9FC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 15:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1E02085A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 15:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="SNSYxjcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfEIP2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 11:28:32 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:22805 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfEIP2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 11:28:32 -0400
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x49FSFFB011121
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 00:28:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x49FSFFB011121
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557415696;
        bh=ic5dJ7jaJHEK/S7TBJJVJSe1EmxiO6oFILIjxc0u/Ko=;
        h=From:Date:Subject:To:Cc:From;
        b=SNSYxjcpjt0v79tnNLCXZfC15aLpwaQxlLdu4DRl2fdYUyaav3d4dMZgp2jGCtYNJ
         lWhH6dawGX75H6dCffC3ahtSwkBt7ILx3UM0FJ3nq67J6rr9gDByXANwWmUnG6VMSz
         KiyszhTTolErCjUVJ1hK1V6P9F7K20e9WBcZepqakeMmHkWxaD6G+KBvq5m7FRs7Gu
         CVicBpXK7+VFnORt2OEc+esfB9OnupijNaBAiKkoQktMREh6sA8jJZxWYxml1q4XeD
         rI5p40goJV8evaMOlTJUC05FHDVYsHn4OfQG84KSgy5LDvZsKYS1BKhZqbcTnH2dAI
         3VIGpkm71Dl2A==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id w13so1687570vsc.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 08:28:16 -0700 (PDT)
X-Gm-Message-State: APjAAAXmycTIf98rsMqn/fQVzvyU2NOZMcjthfIgeeasskEU729LrXkp
        KX6iVXTzlRPB2WTpf8mVlAJGAP7ox9jRp8pGUDw=
X-Google-Smtp-Source: APXvYqyYpni/4HV0hkcuBggju0phhutMUD0Tbiss6wP1TKVZ717xxZz7bl5OyGKaWQuOp6bpWOvpBAyTt0i2p+ZmLGw=
X-Received: by 2002:a67:fc4:: with SMTP id 187mr2622260vsp.215.1557415695320;
 Thu, 09 May 2019 08:28:15 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 10 May 2019 00:27:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR5j1ygbq9TLqUhbJ+tkMdrtD3BgQoUWZErUrnEoWKYMw@mail.gmail.com>
Message-ID: <CAK7LNAR5j1ygbq9TLqUhbJ+tkMdrtD3BgQoUWZErUrnEoWKYMw@mail.gmail.com>
Subject: [Proposal] end of file checks by checkpatch.pl
To:     Joe Perches <joe@perches.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,


Does it make sense to check the following
by checkpatch.pl ?


[1] blank line at end of file

[2] no new line at end of file



When I apply a patch,
I sometimes see the following warning from 'git am'.


Applying: kunit: test: add string_stream a std::stream like string builder
.git/rebase-apply/patch:223: new blank line at EOF.
+


I just thought it could be checked
before the patch submission.


-- 
Best Regards
Masahiro Yamada
