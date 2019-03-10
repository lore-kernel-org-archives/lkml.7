Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42116C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 17:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A537207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 17:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfCJR6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 13:58:25 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57978 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfCJR6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 13:58:25 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EED8D14769046;
        Sun, 10 Mar 2019 10:58:24 -0700 (PDT)
Date:   Sun, 10 Mar 2019 10:58:24 -0700 (PDT)
Message-Id: <20190310.105824.2118241432723559738.davem@davemloft.net>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, isdn@linux-pingi.de, gustavo@embeddedor.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isdn: mISDNinfineon: fix potential NULL pointer
 dereference
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190309054936.24784-1-kjlu@umn.edu>
References: <20190309054936.24784-1-kjlu@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 10 Mar 2019 10:58:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>
Date: Fri,  8 Mar 2019 23:49:34 -0600

> In case ioremap fails, the fix returns -ENOMEM to avoid NULL
> pointer dereference.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Applied.
