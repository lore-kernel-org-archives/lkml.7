Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99993C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737E62184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfCTVFI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 17:05:08 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:47868 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfCTVFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 17:05:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 087FE609187F;
        Wed, 20 Mar 2019 22:05:07 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xPnqxsYI2Co5; Wed, 20 Mar 2019 22:05:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id BE98F60ED8A7;
        Wed, 20 Mar 2019 22:05:06 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9eGmChzciKqE; Wed, 20 Mar 2019 22:05:06 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 464D0609187F;
        Wed, 20 Mar 2019 22:05:06 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] mtd: cfi_util: mark expected switch fall-throughs
Date:   Wed, 20 Mar 2019 22:05:05 +0100
Message-ID: <3141647.IxSqQhjO87@blindfold>
In-Reply-To: <69083203-0720-1943-8549-ddf3cea6060e@embeddedor.com>
References: <20190208180202.GA16603@embeddedor> <69083203-0720-1943-8549-ddf3cea6060e@embeddedor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Am Mittwoch, 20. März 2019, 21:20:51 CET schrieb Gustavo A. R. Silva:
> Hi all,
> 
> Friendly ping:
> 
> Who can take this?

Hmmm, for MTD I think we can schedule these patches for the next merge window.
But I'm not sure whether these comments are a good solution.
I much more prefer the compiler attribute solution.
Also a tree-wide (sane) coccinelle script would be better IMHO,
and not zillions of individual patches via different trees.

Thanks,
//richard




