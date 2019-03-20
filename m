Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB9CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2022183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfCTXZQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 19:25:16 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:49892 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfCTXZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 19:25:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C6942609187F;
        Thu, 21 Mar 2019 00:25:13 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qNyZQSqBJqO0; Thu, 21 Mar 2019 00:25:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4D26760ED8A9;
        Thu, 21 Mar 2019 00:25:13 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iiCnaDpGURoY; Thu, 21 Mar 2019 00:25:13 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id D3FE8609187F;
        Thu, 21 Mar 2019 00:25:12 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] mtd: cfi_util: mark expected switch fall-throughs
Date:   Thu, 21 Mar 2019 00:25:12 +0100
Message-ID: <16526639.hLaf6TFmul@blindfold>
In-Reply-To: <1b9c6280-f1dc-2381-59d6-dc29fda3a63b@embeddedor.com>
References: <20190208180202.GA16603@embeddedor> <3141647.IxSqQhjO87@blindfold> <1b9c6280-f1dc-2381-59d6-dc29fda3a63b@embeddedor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 20. März 2019, 22:23:21 CET schrieb Gustavo A. R. Silva:
> So, if this is too much of a burden for people, I can add all these
> MTD patches to my own tree for 5.2.

Taking the patches via MTD is not a big deal, let's go that path.
For you it is more work to send many patches and getting them into the individual
trees. :)

Thanks,
//richard


