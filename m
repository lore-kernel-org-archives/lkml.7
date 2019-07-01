Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A72C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8DF2064B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbfGAOy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 10:54:56 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38018 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729954AbfGAOyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 10:54:55 -0400
Received: by mail-qt1-f193.google.com with SMTP id n11so14937243qtl.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 07:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bQADhpdv0AdcGJ5CxSSj7Vw+/Bpl7IHt15JAe9Y6HL4=;
        b=qe4EYd51ZlH8l0rQjTBKgjVaGm9r8Ucid2V9O739mvdhW/Oh11+Q5JL1l2dPiwyJBd
         eTY0BEqepQyUXP5DzUTXC9pGG+Z6jTHKJBCzDAT6CeH/9k7bICo8HAZrXMWLWtudogR5
         TqWrS/IdBwTEswyF2Ewny6izSduyCbyRJ59H45gn1WEnXj38utzNhgWo2tASX3HaIta5
         +jMe0aFu/zUxD7RqjQv6zus4N9m7v3OJTjLVz6bFyDaVaRJhK4gTkVVXfbp0eQuD6mxy
         kdOsA6qJoOj7Ke6EqkWPur8tIVxHNfbp/lNmz7G/HMqUza2kavpXIuF0pS0VW1bATyvy
         B3PA==
X-Gm-Message-State: APjAAAVw0MpSZczAHUZC38Cus9Y6WaKfN7B+mQ0H34/1b51dVQHb7Hmm
        hZR54T/wEXJQ82fLP1dMmKrDdMoozjosDW+udl8=
X-Google-Smtp-Source: APXvYqx4jXql4g92uWjBRrGcOulzgb4ho0B27u92U6CQir5dPriC+ckt+BJrI8qUUAGd8rINuInxBQyW2plUqW4nLbw=
X-Received: by 2002:ac8:5311:: with SMTP id t17mr20326781qtn.304.1561992895019;
 Mon, 01 Jul 2019 07:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190628104007.2721479-1-arnd@arndb.de> <20190628155956.GB27114@jaegeuk-macbookpro.roam.corp.google.com>
In-Reply-To: <20190628155956.GB27114@jaegeuk-macbookpro.roam.corp.google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 1 Jul 2019 16:54:38 +0200
Message-ID: <CAK8P3a3c_=3NggcqUBy87ytLVtvGxZiGWmipkgCCGdodYETs9A@mail.gmail.com>
Subject: Re: [PATCH] f2fs: fix 32-bit linking
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>, Qiuyang Sun <sunqiuyang@huawei.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Eric Biggers <ebiggers@google.com>,
        Wang Shilong <wangshilong1991@gmail.com>,
        "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 5:59 PM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> Hi Arnd,
>
> If you don't mind, can I integrate this into the original patch in the queue?

Yes, I think that would be good anyway, it may take a little longer to fix all
the architectures.

        Arnd
