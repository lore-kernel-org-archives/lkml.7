Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEE5C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 08:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A73212F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 08:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfFHIq5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 04:46:57 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:55018 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfFHIq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 04:46:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id DC296608310F;
        Sat,  8 Jun 2019 10:46:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zvqCvutu62Nr; Sat,  8 Jun 2019 10:46:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A52876083112;
        Sat,  8 Jun 2019 10:46:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lDWzSDzz8har; Sat,  8 Jun 2019 10:46:54 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 85D98608310F;
        Sat,  8 Jun 2019 10:46:54 +0200 (CEST)
Date:   Sat, 8 Jun 2019 10:46:54 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Emil Lenngren <emil.lenngren@gmail.com>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michele Dionisio <michele.dionisio@gmail.com>
Message-ID: <2132182687.85021.1559983614464.JavaMail.zimbra@nod.at>
In-Reply-To: <CAO1O6seVp0wBVE6AKmu+EYhoghxbErNuK1F=Y5ewzD=CRro24g@mail.gmail.com>
References: <20190515210202.21169-1-richard@nod.at> <CAO1O6sdU=kAYS2sTKwiagxrbg+fMer9nvbwA9C4LoFMgH7e1dQ@mail.gmail.com> <1644731533.84685.1559938164477.JavaMail.zimbra@nod.at> <CAO1O6scuNXfgtaex_Ty4-5=DmBV43Sg28ntkzNgB5T2KwfXG3g@mail.gmail.com> <1342653998.84700.1559940592644.JavaMail.zimbra@nod.at> <CAO1O6seVp0wBVE6AKmu+EYhoghxbErNuK1F=Y5ewzD=CRro24g@mail.gmail.com>
Subject: Re: [PATCH] ubifs: Add support for zstd compression.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.8_GA_3025 (ZimbraWebClient - FF60 (Linux)/8.8.8_GA_1703)
Thread-Topic: ubifs: Add support for zstd compression.
Thread-Index: 1TyPXqVJ7NP9H5VZPOir3EfKZv4bww==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> ARM Cortex-A7. The kernel is compiled with gcc 7.3.1. Next week I'll
> test some more.

Good to know!

> I have a question about how the decompression is done while reading.
> When a large file is read from the filesystem (assuming not in any
> cache), is it the case that first a chunk is read from flash, that
> chunk is then decompressed, later next chunk is read from flash, that
> one is then decompressed and so on, or can the decompression be done
> in parallel while reading the next chunk from flash?

No, this is a serial operation.

Thanks,
//richard
