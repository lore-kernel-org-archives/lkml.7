Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAE0C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 20:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969D4208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 20:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbfFGUtz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 16:49:55 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:46594 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbfFGUtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 16:49:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 88DA9608310F;
        Fri,  7 Jun 2019 22:49:53 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rHXN-8rB8r0w; Fri,  7 Jun 2019 22:49:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D7FA46074CFD;
        Fri,  7 Jun 2019 22:49:52 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JNgeMnXRlRNU; Fri,  7 Jun 2019 22:49:52 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id AEF6A608310F;
        Fri,  7 Jun 2019 22:49:52 +0200 (CEST)
Date:   Fri, 7 Jun 2019 22:49:52 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Emil Lenngren <emil.lenngren@gmail.com>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michele Dionisio <michele.dionisio@gmail.com>
Message-ID: <1342653998.84700.1559940592644.JavaMail.zimbra@nod.at>
In-Reply-To: <CAO1O6scuNXfgtaex_Ty4-5=DmBV43Sg28ntkzNgB5T2KwfXG3g@mail.gmail.com>
References: <20190515210202.21169-1-richard@nod.at> <CAO1O6sdU=kAYS2sTKwiagxrbg+fMer9nvbwA9C4LoFMgH7e1dQ@mail.gmail.com> <1644731533.84685.1559938164477.JavaMail.zimbra@nod.at> <CAO1O6scuNXfgtaex_Ty4-5=DmBV43Sg28ntkzNgB5T2KwfXG3g@mail.gmail.com>
Subject: Re: [PATCH] ubifs: Add support for zstd compression.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.8_GA_3025 (ZimbraWebClient - FF60 (Linux)/8.8.8_GA_1703)
Thread-Topic: ubifs: Add support for zstd compression.
Thread-Index: i0naAnpf5ado1iIuaToqoo7bNUnLng==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Emil Lenngren" <emil.lenngren@gmail.com>
> An: "richard" <richard@nod.at>
> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "Sebastian Andrzej Siewior" <sebastian@breakpoint.cc>, "linux-kernel"
> <linux-kernel@vger.kernel.org>, "Michele Dionisio" <michele.dionisio@gmail.com>
> Gesendet: Freitag, 7. Juni 2019 22:27:09
> Betreff: Re: [PATCH] ubifs: Add support for zstd compression.
>> So I'm not sure what is the best choice for the default filesystem.
> 
> My idea was at the end, i.e. it will only be used when LZO and ZLIB
> are not selected to be included for UBIFS, for example when someone
> compiles a minimal kernel who knows exactly which compression
> algorithms will be used on that system.

BTW: you can always select the compressor using the compr= mount option.
Also for the default filesystem.

Putting it at the end does not harm but IMHO the use is little.
But for the sake of completes, I agree with you. Can you send a follow-up
patch? 

> I did a single test today and compared lzo and zstd and on that test
> lzo had faster decompression speed but resulted in larger space. I'll
> do more tests later.

Can you please share more details? I'm interested what CPU this was.

Thanks,
//richard
