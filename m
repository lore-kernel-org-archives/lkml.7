Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801E5C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4472067B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfKLTcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 14:32:09 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48368 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfKLTcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 14:32:09 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4B95D154CF011;
        Tue, 12 Nov 2019 11:32:08 -0800 (PST)
Date:   Tue, 12 Nov 2019 11:32:07 -0800 (PST)
Message-Id: <20191112.113207.2302490162902408721.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        irtimmer@gmail.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net: dsa: mv88e6xxx: fix broken if statement
 because of a stray semicolon
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191112130523.232461-1-colin.king@canonical.com>
References: <20191112130523.232461-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 12 Nov 2019 11:32:08 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Tue, 12 Nov 2019 13:05:23 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a stray semicolon in an if statement that will cause a dev_err
> message to be printed unconditionally. Fix this by removing the stray
> semicolon.
> 
> Addresses-Coverity: ("Stay semicolon")
> Fixes: f0942e00a1ab ("net: dsa: mv88e6xxx: Add support for port mirroring")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks.
