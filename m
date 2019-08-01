Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6E1C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2669F214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbfHAJVE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 05:21:04 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:43476 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbfHAJVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 05:21:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8F9B9608311C;
        Thu,  1 Aug 2019 11:21:01 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id YRXpaPGSw17I; Thu,  1 Aug 2019 11:20:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 23F7760632E8;
        Thu,  1 Aug 2019 11:20:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AmoBxAj1X7tG; Thu,  1 Aug 2019 11:20:55 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id F27E9608311C;
        Thu,  1 Aug 2019 11:20:54 +0200 (CEST)
Date:   Thu, 1 Aug 2019 11:20:54 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     chengzhihao1 <chengzhihao1@huawei.com>
Cc:     yi zhang <yi.zhang@huawei.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1515821930.55881.1564651254907.JavaMail.zimbra@nod.at>
In-Reply-To: <0B80F9D4116B2F4484E7279D5A66984F7A8A13@dggemi524-mbx.china.huawei.com>
References: <1564651065-4585-1-git-send-email-chengzhihao1@huawei.com> <0B80F9D4116B2F4484E7279D5A66984F7A8A13@dggemi524-mbx.china.huawei.com>
Subject: =?utf-8?Q?Re:_=E7=AD=94=E5=A4=8D:_[PATCH_RFC]_ubi:_ub?=
 =?utf-8?Q?i=5Fwl=5Fget=5Fpeb:_Replace_a_lim?=
 =?utf-8?Q?ited_number_of_attempts_with_polling_while_getting_PEB?=
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubi_wl_get_peb: Replace a limited number of attempts with polling while getting PEB
Thread-Index: AQHVSEkuRooM7Daz00mNhjuG43MDw6bmAggAJrEe1mw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
> An: "richard" <richard@nod.at>, "yi zhang" <yi.zhang@huawei.com>
> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Donnerstag, 1. August 2019 11:13:20
> Betreff: 答复: [PATCH RFC] ubi: ubi_wl_get_peb: Replace a limited number of attempts with polling while getting PEB

> I don't quite understand why a limited number of attempts have been made to get
> a free PEB in ubi_wl_get_peb (in fastmap-wl.c). I proposed this PATCH with
> reference to the implementation of ubi_wl_get_peb (in wl.c). As far as I know,
> getting PEB by polling probably won't fall into soft-lockup.
> ubi_update_fastmap may add new tasks (including erase task or wl taskk, wl tasks
> generally do not generate additional free PEBs) to ubi->works, and
> produce_free_peb will eventually complete all tasks in ubi->works or obtain an
> free PEB that can be filled into pool.

You send this patch three times, I guess your mail setup has issues? :-)
 
This is one of the darkest corners of Fastmap where things get messy.
The number of retry attempts was limited to avoid a live lock.

I agree that allowing only one retry is a little to few.
With nandsim, a small nand and a fast PC you can hit that.

Do you have numbers how many attempts were needed to get a free block?

Thanks,
//richard
