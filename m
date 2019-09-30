Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2A5C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1742822500
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbfI3UzF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:55:05 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:54104 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730539AbfI3UzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 16:55:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 714A06083139;
        Mon, 30 Sep 2019 21:39:35 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NkoqdQgpQWCD; Mon, 30 Sep 2019 21:39:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 110CB608313B;
        Mon, 30 Sep 2019 21:39:35 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XeFpM0PpcIp7; Mon, 30 Sep 2019 21:39:34 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id BE0706083139;
        Mon, 30 Sep 2019 21:39:34 +0200 (CEST)
Date:   Mon, 30 Sep 2019 21:39:34 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Kamal Dasu <kamal.dasu@broadcom.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <724490481.10665.1569872374621.JavaMail.zimbra@nod.at>
In-Reply-To: <CAKekbevBxGh9HRLX_4N98NwKm4GnXWvy9kwi6i=nRVnmfmJ-vw@mail.gmail.com>
References: <20190906194719.15761-1-kdasu.kdev@gmail.com> <20190906194719.15761-2-kdasu.kdev@gmail.com> <CAC=U0a1qvKO+t_62df_JcQBETAuNq0pwRkAb-Ofi3ski2rfdEQ@mail.gmail.com> <20190930182458.761e8077@collabora.com> <CAKekbevBxGh9HRLX_4N98NwKm4GnXWvy9kwi6i=nRVnmfmJ-vw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mtd: rawnand: use bounce buffer when vmalloced data
 buf detected
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: rawnand: use bounce buffer when vmalloced data buf detected
Thread-Index: 59RFbZHlw9bdW9o2LKfMJ7mOlXE2MQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Kamal Dasu" <kamal.dasu@broadcom.com>
> This has been observed on MIPS4K and MIPS5K architectures. There is a
> check on the controller driver to use pio in such cases.

I fear your kernel misses commit:
074a1e1167af ("MIPS: Bounds check virt_addr_valid")

Thanks,
//richard
