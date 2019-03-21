Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03212C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC57C218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfCUVB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:01:28 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53266 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfCUVB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 17:01:27 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D89B3133E977A;
        Thu, 21 Mar 2019 14:01:24 -0700 (PDT)
Date:   Thu, 21 Mar 2019 14:01:24 -0700 (PDT)
Message-Id: <20190321.140124.1481717582980534288.davem@davemloft.net>
To:     neilb@suse.com
Cc:     tgraf@suug.ch, netdev@vger.kernel.org, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Two clean-ups for rhashtable.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <155313966311.31132.17461701268394583387.stgit@noble.brown>
References: <155313966311.31132.17461701268394583387.stgit@noble.brown>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 21 Mar 2019 14:01:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.com>
Date: Thu, 21 Mar 2019 14:42:39 +1100

> These two patches make small improvements to
> rhashtable, but are otherwise unrelated.
> 
> Thanks to Herbert, Miguel, and Paul for the review.

Series applied, thanks Neil.
