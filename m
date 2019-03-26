Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5B7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7739F206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732626AbfCZSm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:42:28 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48620 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732324AbfCZSm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:42:27 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DAB8E14C5E7D7;
        Tue, 26 Mar 2019 11:42:26 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:42:25 -0700 (PDT)
Message-Id: <20190326.114225.1356666185241732947.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     vishal@chelsio.com, clang-built-linux@googlegroups.com,
        ndesaulniers@google.com, natechancellor@gmail.com,
        ganeshgr@chelsio.com, leedom@chelsio.com,
        rahul.lakkireddy@chelsio.com, arjun@chelsio.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] chelsio: use BUG() instead of BUG_ON(1)
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190325124930.1435409-1-arnd@arndb.de>
References: <20190325124930.1435409-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 26 Mar 2019 11:42:27 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 25 Mar 2019 13:49:16 +0100

> clang warns about possible bugs in a dead code branch after
> BUG_ON(1) when CONFIG_PROFILE_ALL_BRANCHES is enabled:
 ...
> Use BUG() here to create simpler code that clang understands
> correctly.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
