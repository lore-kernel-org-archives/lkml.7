Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723F9C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1B22087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfEGPtL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 11:49:11 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:50932 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfEGPtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 11:49:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 58C0B608F446;
        Tue,  7 May 2019 17:49:07 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8Su0dz-W26oG; Tue,  7 May 2019 17:49:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0322C6083105;
        Tue,  7 May 2019 17:49:06 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 31Kf02fmxQu5; Tue,  7 May 2019 17:49:05 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id C33C26083104;
        Tue,  7 May 2019 17:49:05 +0200 (CEST)
Date:   Tue, 7 May 2019 17:49:05 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Message-ID: <785015370.48464.1557244145722.JavaMail.zimbra@nod.at>
In-Reply-To: <3034821c-3cd0-b0c5-a6fd-548fd87486a4@embeddedor.com>
References: <20190208180202.GA16603@embeddedor> <69083203-0720-1943-8549-ddf3cea6060e@embeddedor.com> <71df15e7-af2e-0326-78fe-0271a1e240fe@embeddedor.com> <20190415104458.7faeec57@xps13> <ee1f8c4a-92b0-db9d-6110-3acadeb9e457@embeddedor.com> <20190416192408.0e321563@xps13> <8df20a3a-3068-1fb7-0421-e6c417550125@embeddedor.com> <3034821c-3cd0-b0c5-a6fd-548fd87486a4@embeddedor.com>
Subject: Re: [PATCH] mtd: cfi_util: mark expected switch fall-throughs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.8_GA_3025 (ZimbraWebClient - FF60 (Linux)/8.8.8_GA_1703)
Thread-Topic: cfi_util: mark expected switch fall-throughs
Thread-Index: c1PkOuWOdQy8fEL4I6CUz4FzFPRcPA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> An: "Miquel Raynal" <miquel.raynal@bootlin.com>
> CC: "David Woodhouse" <dwmw2@infradead.org>, "Brian Norris" <computersforpeace@gmail.com>, "Boris Brezillon"
> <bbrezillon@kernel.org>, "Marek Vasut" <marek.vasut@gmail.com>, "richard" <richard@nod.at>, "linux-mtd"
> <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "Kees Cook" <keescook@chromium.org>
> Gesendet: Dienstag, 7. Mai 2019 16:54:12
> Betreff: Re: [PATCH] mtd: cfi_util: mark expected switch fall-throughs

> Hi all,
> 
> Thanks a lot for this, Richard:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/log/?h=mtd%2Fnext&qt=grep&q=fall-through
> 
> There are only two of these warnings left to be addressed in
> MTD[1]:
> 
>        > @@ -3280,12 +3280,14 @@ static void onenand_check_features(struct mtd_info *mtd)
>        >                       if ((this->version_id & 0xf) == 0xe)
>        >                               this->options |= ONENAND_HAS_NOP_1;
>        >               }
>        > +             /* fall through */
>        >
>        >       case ONENAND_DEVICE_DENSITY_2Gb:
>        >               /* 2Gb DDP does not have 2 plane */
>        >               if (!ONENAND_IS_DDP(this))
>        >                       this->options |= ONENAND_HAS_2PLANE;
>        >               this->options |= ONENAND_HAS_UNLOCK_ALL;
>        > +             /* fall through */
> 
>        This looks strange.
> 
>        In ONENAND_DEVICE_DENSITY_2Gb:
>        ONENAND_HAS_UNLOCK_ALL is set unconditionally.
> 
>        But then, under ONENAND_DEVICE_DENSITY_1Gb, the same option is set only
>        if process is evaluated to true.
> 
>        Same problem with ONENAND_HAS_2PLANE:
>        - it is set in ONENAND_DEVICE_DENSITY_4Gb only if ONENAND_IS_DDP()
>        - it is unset in ONENAND_DEVICE_DENSITY_2Gb only if !ONENAND_IS_DDP()
> 
>        Maybe this portion should be reworked because I am unsure if this is a
>        missing fall through or a bug.
> 
> 
> Thanks
> --
> Gustavo
> 
> [1] https://lore.kernel.org/patchwork/patch/1036251/

Did we miss this patch? AFAICT it is in -next too.

Thanks,
//richard
