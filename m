Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCC6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6C2218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="N69u344i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfCVNze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:55:34 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:31885 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfCVNze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:55:34 -0400
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x2MDtLF7002539
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 22:55:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x2MDtLF7002539
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553262922;
        bh=OuW1INBd4a/Ge5wtM92w3nbQxteq+rD/F2AD5ZHWmpo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N69u344iqVqJb9GkfHRAkuVpf/K7teV+kfgYPKW9X3Lh0ecTb9lgncSaFkaK4QmyM
         2w1eY8YGnq6YbHr4ysK9AN9Xpl1Re6q2jN0Ovg93UWkecvRjvfiW18n+MqLkv6Zo2B
         6q+FNgq7igSrzznJZvVDsUpt2LUaM1cOPONjxGqW+R6EmxLS6Z6D6t96cadjDXzW7w
         S7jzIf2WgfFkOwJ4gA2Qpog9H6sLTKAGQBdVYRoLPAf80BtoYDiARyfjTtEQmi0PFk
         ddQ7oOOS7zYTkGtibMrIMO/NME0JuszTPH0jOFK1f53hLXaEZmcjdII9U9BaDkj76c
         9BiUTCYzQMNIQ==
X-Nifty-SrcIP: [209.85.222.45]
Received: by mail-ua1-f45.google.com with SMTP id r21so746009uan.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 06:55:21 -0700 (PDT)
X-Gm-Message-State: APjAAAWJvYaULegbxqyqhohhwF4SUm0ulofCFYWaHOQGmrz0hoLEYCII
        /tQxzzeAj7EvK8YVEhviJq+0AOsTLhm5jGW+wDI=
X-Google-Smtp-Source: APXvYqzYkzGbV9eOboLOkvi12mqn9fllblFLPTFpYTayc4Kw3UN9f4xGyxkWMgP+Ug/YDGESlMlttS9IX5/jl2YvPoM=
X-Received: by 2002:ab0:28c6:: with SMTP id g6mr1052394uaq.109.1553262920811;
 Fri, 22 Mar 2019 06:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <1553253554-5307-1-git-send-email-yamada.masahiro@socionext.com> <20190322114919.GA17767@guoren-Inspiron-7460>
In-Reply-To: <20190322114919.GA17767@guoren-Inspiron-7460>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 22 Mar 2019 22:54:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNATDSfisxJ77FYXUiJYQt=o_z9Dh6s4qKuz4JRcwRJhCrA@mail.gmail.com>
Message-ID: <CAK7LNATDSfisxJ77FYXUiJYQt=o_z9Dh6s4qKuz4JRcwRJhCrA@mail.gmail.com>
Subject: Re: [PATCH] csky: remove redundant generic-y
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 8:51 PM Guo Ren <guoren@kernel.org> wrote:
>
> Thx Masahiro,
>
> Approved and I'll add it into my tree.


Thanks.

BTW, I sent another patch some time ago,
which has not been picked up.

https://lore.kernel.org/patchwork/patch/1038349/


-- 
Best Regards
Masahiro Yamada
