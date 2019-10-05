Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9DFC4CED1
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 06:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D906222C0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 06:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="m4l9ocyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfJEGKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 02:10:50 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:24596 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfJEGKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 02:10:48 -0400
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x956AbXQ029871;
        Sat, 5 Oct 2019 15:10:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x956AbXQ029871
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570255838;
        bh=P6lR0fwPmcF774RRVWkWdiO5FWfIO6SZQNI4nR6M9uQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m4l9ocyP8vypzVuTWb8G7R+jRSq4sGUd2Qcqqtly6gZ+sDRC6leGwwaAbHAaTojnM
         6E7mlgz5JSixqzUno6Mgny8aVBqNZ1x8WrxNYtFpOkLlIRIDE8k5xTL0Z1mLVMr48J
         W96S8TmUHRkmy+keSHtA/OF2Kld95xALgsLYDPBsDfZVB+CrBQjbpnvf/wJJNFSxc9
         piXJjPAiUkecUFotNfg9P5MjYUEmPzuJWRHwZmWhAus0qPRyydXPTAW2l3iOyKC2Y9
         H24efrrwqVekswbmr3qy4ySANiy5uZRPBU2MJ0aFIJKcd85K5FSd/JQeQgxaKRor4y
         nk+D+goyOYiIw==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id p13so5567430vsr.4;
        Fri, 04 Oct 2019 23:10:38 -0700 (PDT)
X-Gm-Message-State: APjAAAWN9gQ+UlvYRofK2FeD2eDqJeyTjFDx+JAv8GKxu1DHvozdDIsO
        PuPD7xGHpt7mpb+1nymksj2DjnmnFl3jX+gRXdc=
X-Google-Smtp-Source: APXvYqzJipzkL3y2fKhmPoTW4mA8T0rcoLewqzvmmVtk4bnO7DDZKNYQ06Yyrd3bQ+t0aN4w2OFufzQnFSO6gij1sUs=
X-Received: by 2002:a67:88c9:: with SMTP id k192mr9992493vsd.181.1570255837102;
 Fri, 04 Oct 2019 23:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191004160514.238bb6a8@canb.auug.org.au>
In-Reply-To: <20191004160514.238bb6a8@canb.auug.org.au>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 5 Oct 2019 15:10:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS4jo5FM5D=XJZYN3K4_4gNQVuX+7nBvGL0vW0CCYfw8A@mail.gmail.com>
Message-ID: <CAK7LNAS4jo5FM5D=XJZYN3K4_4gNQVuX+7nBvGL0vW0CCYfw8A@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the kbuild-current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 3:05 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   b2b94fe85175 ("scripts/setlocalversion: clear local variable to make it work for sh")
>
> Fixes tag
>
>   Fixes: commit 858805b336be ("kbuild: add $(BASH) to run scripts with bash-extension")
>
> has these problem(s):
>
>   - leading word 'commit' unexpected

Fixed it now.
Thanks Stephen!


> --
> Cheers,
> Stephen Rothwell



-- 
Best Regards
Masahiro Yamada
