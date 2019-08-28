Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873A9C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DF222CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfH1HY3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:24:29 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:37878 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfH1HY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:24:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 75B906083139;
        Wed, 28 Aug 2019 09:24:26 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id BohZBxlg8vLS; Wed, 28 Aug 2019 09:24:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id BB38E608313E;
        Wed, 28 Aug 2019 09:24:25 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Scw3hM_Av0Sa; Wed, 28 Aug 2019 09:24:25 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 84A0A6083139;
        Wed, 28 Aug 2019 09:24:25 +0200 (CEST)
Date:   Wed, 28 Aug 2019 09:24:25 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     chengzhihao1 <chengzhihao1@huawei.com>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        yi zhang <yi.zhang@huawei.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <990736007.75294.1566977065451.JavaMail.zimbra@nod.at>
In-Reply-To: <0B80F9D4116B2F4484E7279D5A66984F7D875E@dggemi524-mbx.china.huawei.com>
References: <1565431061-145460-1-git-send-email-chengzhihao1@huawei.com> <CAFLxGvzOMfqJJ+ZKTUavxEx+0_OJO_VcrNu1nn2rrvcypAxAAA@mail.gmail.com> <0B80F9D4116B2F4484E7279D5A66984F7D875E@dggemi524-mbx.china.huawei.com>
Subject: =?utf-8?Q?Re:_=E7=AD=94=E5=A4=8D:_[PATCH_RFC_v2]_?=
 =?utf-8?Q?ubi:_ubi=5Fwl=5Fget=5Fpeb:_In?=
 =?utf-8?Q?crease_the_number_of_attempts_while_getting_PEB?=
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubi_wl_get_peb: Increase the number of attempts while getting PEB
Thread-Index: AQHVT2EsTJNmHoCNk0y5Wp2VB7/tCKb5GeuAgBbPnRBaZNfHxQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
> An: "Richard Weinberger" <richard.weinberger@gmail.com>
> CC: "richard" <richard@nod.at>, "yi zhang" <yi.zhang@huawei.com>, "linux-mtd" <linux-mtd@lists.infradead.org>,
> "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Mittwoch, 28. August 2019 03:59:37
> Betreff: 答复: [PATCH RFC v2] ubi: ubi_wl_get_peb: Increase the number of attempts while getting PEB

> This patch missed the fixes pull request(5.3-rc6), will it be in v5.3-rc7?

This was on purpose. It will be part of the next merge window.

Thanks,
//richard
