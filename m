Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663CCC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5872084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfDIKOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:14:10 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32933 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfDIKOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:14:09 -0400
Received: by mail-qt1-f194.google.com with SMTP id k14so19043158qtb.0;
        Tue, 09 Apr 2019 03:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kdv7E7EQtES4EqqVPGiQ+deLRkk2VGik0/rCDbn7V0E=;
        b=JJ+b7KepsXSQTfaL7eUw0LdaVbxcViiHzO2tV04SPjAiQ5APKFFN7DCYlYlFdxiVtv
         AI+w+zHeQdHsD2Ws5fawRv/vGJ0v5wDC0dyu8WoSSI9My31DhDXdizUcAxN+nFvvM1yZ
         o5YGxfJGOh5wcwUoKLsaTAm2gG64rTZ5bxP4F9Kz0pHtNKaC+uKqUoH27Ia/FoaBMQSw
         xRW3c3z9skAjzS639Pk/QEN9P1KDu2gfBS8uMKjiJeiTW6SKcaEh0qnN6ab9lM1SDFG2
         lpbdvOqJsxiyRP4H63athh7j22cYUcTe/3Z53e8F3p3oqmK3HWahI5XMajDjgflIrbub
         oCbg==
X-Gm-Message-State: APjAAAVzRH5KDtwtS1MByFilZk9mAecCleRxdjjS1SUOI+brbNgIvmrE
        g4icVypEk48vU0swb3X+ENgJh1P5m0RIzKkhpMY=
X-Google-Smtp-Source: APXvYqwpCbGlumwUVi8/Zid+BGHAVH1lHax30gk0+17mJan+98MUN5xy7w9qmB0FavqDrp4wmbEisecVgp+I5gZcrIg=
X-Received: by 2002:aed:35e4:: with SMTP id d33mr28977275qte.58.1554804848704;
 Tue, 09 Apr 2019 03:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190408212648.2407234-1-arnd@arndb.de> <20190408212648.2407234-5-arnd@arndb.de>
 <8875e0b6-00b4-884d-fd6a-a5a144543559@linux.ibm.com>
In-Reply-To: <8875e0b6-00b4-884d-fd6a-a5a144543559@linux.ibm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 9 Apr 2019 12:13:52 +0200
Message-ID: <CAK8P3a1Ckp+RMCUzB+KoUUSL9ExRc5TkU7qC8hcscm9yLnGcxg@mail.gmail.com>
Subject: Re: [PATCH 05/12] s390: zcrypt: initialize variables before_use
To:     Harald Freudenberger <freude@linux.ibm.com>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Ingo Franzki <ifranzki@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 11:54 AM Harald Freudenberger
<freude@linux.ibm.com> wrote:
> On 08.04.19 23:26, Arnd Bergmann wrote:

> Thanks Arnd, but as Nathan already wrote, I'd prefer to have the
> variable initialized with 0 instead of -1.
> If you agree with this, I'll rewrite the patch and apply it to our
> internal git and it will appear at kernel org with the next s390 code merge then.

That's fine with me, I don't care about the specific value that gets
assigned here.

Thanks,

      Arnd
