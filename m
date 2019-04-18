Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F388C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6825221479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CMJ5vL4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388438AbfDRJ0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:26:43 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:55316 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfDRJ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:26:43 -0400
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x3I9QLSv014251;
        Thu, 18 Apr 2019 18:26:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x3I9QLSv014251
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555579582;
        bh=mCidIO2kdLrsu0lOZK1cDW6X++3CEu5ocBDg6MWSPR4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CMJ5vL4wUaDAEY8nw9DL3aAJaFwO934GUe/XOUTdgGHQwZoq71nrdD60IdCWJ5XQ9
         xo2gXg1m4nq9RcIuejPHLntqaAawQuifqsSxne+ZoFeSKsbNmffi0wmVFu5SN1Sebf
         iqfZn6b/vMYmP6b7m9OHZzrhlHmzi7YC45nkwKzrGdUnGZksylcEZ7t/v5fOPCc6Du
         voeeTuq8qVcQt4nECgUirNQPPBQ9LerO+Jn67fdNqMs+fXVm77NmZV6nnc4t5eO82+
         W3GHlJL8lNpJ9+E3ZW9C0G9K2ZKixgAGnkf3BKzHWgkkxUbLz4fYi9WGWkN5rbzzdb
         rBemZqTkSg+Lw==
X-Nifty-SrcIP: [209.85.222.54]
Received: by mail-ua1-f54.google.com with SMTP id k32so556985uae.3;
        Thu, 18 Apr 2019 02:26:22 -0700 (PDT)
X-Gm-Message-State: APjAAAWjtiOyWH6yTl8jDdrwqlxZBjss9ev0JIC2stQPArJVTeOIMG4k
        U+leSD6KXLDpmMbXXBHl1uAA3IPiD29H1lkpGGE=
X-Google-Smtp-Source: APXvYqxVdaWJjfJJLAeJy/Oqm2hJrnuAFv6MWyLZLgzi43sa+u93+LQ1lWM4rY0k62AHI1snDMQ9LOyYIufRODczdNA=
X-Received: by 2002:ab0:7008:: with SMTP id k8mr49427876ual.40.1555579581021;
 Thu, 18 Apr 2019 02:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555382110.git.mchehab+samsung@kernel.org> <5cfeb21a8841c1e029e8396bdaa7cd55ac0b08a2.1555382110.git.mchehab+samsung@kernel.org>
In-Reply-To: <5cfeb21a8841c1e029e8396bdaa7cd55ac0b08a2.1555382110.git.mchehab+samsung@kernel.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 18 Apr 2019 18:25:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQUGkW=Mnz-EtUkm=7uBpGLZNgO+3MUTmkWOggo+_eHjw@mail.gmail.com>
Message-ID: <CAK7LNAQUGkW=Mnz-EtUkm=7uBpGLZNgO+3MUTmkWOggo+_eHjw@mail.gmail.com>
Subject: Re: [PATCH 18/57] docs: kbuild: convert it to ReST output
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 12:01 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> The kbuild documentation clearly shows that the documents
> there are written at different times: some use markdown,
> some use their own peculiar logic to split sections.
>
> Convert everything to ReST without affecting too much
> the author's style and avoiding adding uneeded markups.

Sorry for my ignorance, but shouldn't ReST use
the extension '.rst' instead of '.txt' ?



> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/kbuild/headers_install.txt      |   5 +-
>  Documentation/kbuild/kbuild.txt               | 119 ++--
>  Documentation/kbuild/kconfig-language.txt     | 232 ++++----
>  .../kbuild/kconfig-macro-language.txt         |  37 +-
>  Documentation/kbuild/kconfig.txt              | 136 +++--
>  Documentation/kbuild/makefiles.txt            | 518 +++++++++++-------
>  Documentation/kbuild/modules.txt              | 166 +++---
>  7 files changed, 720 insertions(+), 493 deletions(-)
>

-- 
Best Regards
Masahiro Yamada
