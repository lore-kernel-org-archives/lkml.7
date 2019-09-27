Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD37C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3860F21655
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfI0S2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 14:28:55 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35244 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfI0S2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:28:54 -0400
Received: from localhost (231-157-167-83.reverse.alphalink.fr [83.167.157.231])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C779C153EF900;
        Fri, 27 Sep 2019 11:28:53 -0700 (PDT)
Date:   Fri, 27 Sep 2019 20:28:52 +0200 (CEST)
Message-Id: <20190927.202852.1300255842604350143.davem@davemloft.net>
To:     hayashi.kunihiko@socionext.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: socionext: ave: Avoid using netdev_err()
 before calling register_netdev()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1569479710-32314-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1569479710-32314-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 27 Sep 2019 11:28:54 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Date: Thu, 26 Sep 2019 15:35:10 +0900

> Until calling register_netdev(), ndev->dev_name isn't specified, and
> netdev_err() displays "(unnamed net_device)".
> 
>     ave 65000000.ethernet (unnamed net_device) (uninitialized): invalid phy-mode setting
>     ave: probe of 65000000.ethernet failed with error -22
> 
> This replaces netdev_err() with dev_err() before calling register_netdev().
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Applied.
