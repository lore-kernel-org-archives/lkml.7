Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE64C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A942089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbfG3PXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:23:41 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43446 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730013AbfG3PXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:23:41 -0400
Received: by mail-qt1-f194.google.com with SMTP id w17so19103289qto.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 08:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QfRDMATF/mD0ld+JXOHOTIFlNh/Cdg0uTO/akzNNHqM=;
        b=YCMEkeShRKYHL1fAITQSHrm6GKBzWOi9Cj5BMTQ/wsewHD0oGTkGsR2KTPcsSzBSlv
         SRHGapq6m98wElol4lk+W2MNYgZSs9i6S1E/bgAs31n+cWePXQF9Nlc7JbvS/7FaYnk+
         +as6+qiPlitksrSD72nb0OyQNx099Iev1rjnyErJiGXJ7UCPPBZf9+8Dgos9Mp2jUSyu
         bpG13qEUC1ewkBA+yUMYOZsvWE0d/OReLm0K1rqF99DdcDUZRwo1WObNXqMc5dv10OBT
         16Oa15cXnKxJ5nnEUH/nJN7woB1oKBHOOstA8ktVSyLH84tYL3wGB3NL2A7UYSOr40xo
         Ohyw==
X-Gm-Message-State: APjAAAWEmOjh1nYCwBqPkwXmrBXH/nT/+ZKvuvUhfEpSvX9c49bSxqH7
        3l4cc9DbyK0FXQ3YZ3G2gy7fgLgB4lPyz5HDQdQ=
X-Google-Smtp-Source: APXvYqwDK/J3NCjNWITj7Ip0SyX5Ri5CKH+r2xLJkFHtEoRIvmzE++N6L56dMPBT75xhK9Us76wxfBPEk3mS6pYxIdo=
X-Received: by 2002:aed:33a4:: with SMTP id v33mr79997791qtd.18.1564500220464;
 Tue, 30 Jul 2019 08:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3jjDh6aEVf0bBFYc=8GtB38kL6sWVZGJiUe427A7m2ng@mail.gmail.com>
 <CAK8P3a1ss9-G_mr48-UMOenrA0XDGWUFik4TC=m0WFfimoFdnQ@mail.gmail.com>
 <CAK8P3a3VsArSUgMwoPVxm8JcTPAQDoztg22MGqX4Vj5cjtADZg@mail.gmail.com> <CAKKbWA6aUBec8tTQNCJow8c6=SyS-y4HUC=3sMJp6_Oz51iF=A@mail.gmail.com>
In-Reply-To: <CAKKbWA6aUBec8tTQNCJow8c6=SyS-y4HUC=3sMJp6_Oz51iF=A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 30 Jul 2019 17:23:24 +0200
Message-ID: <CAK8P3a07KOgXKksbtQceqAKiZ-ykr4nDoM2xvb+WXtrXmNn2uA@mail.gmail.com>
Subject: Re: RFC: remove Nuvoton w90x900/nuc900 platform?
To:     Avi Fishman <avifishman70@gmail.com>
Cc:     Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Wanzongshun (Vincent)" <wanzongshun@huawei.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Nancy Yuen <yuenn@google.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Benjamin Fair <benjaminfair@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 3:59 PM Avi Fishman <avifishman70@gmail.com> wrote:
>
> Note that we we are going to add soon drivers/net/ethernet/nuvoton/npcm7xx_emc.c
> so maybe don't remove drivers/net/ethernet/nuvoton

Ok, thanks for a taking a look. I can leave an empty Makefile/Kconfig
pair there then.

     Arnd
