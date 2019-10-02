Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA21C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E89222BE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfJBXZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 19:25:19 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38012 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbfJBXZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 19:25:19 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6AE3F1551EF10;
        Wed,  2 Oct 2019 16:25:18 -0700 (PDT)
Date:   Wed, 02 Oct 2019 16:25:09 -0700 (PDT)
Message-Id: <20191002.162509.887188013929694661.davem@davemloft.net>
To:     mcroce@redhat.com
Cc:     netdev@vger.kernel.org, antoine.tenart@bootlin.com,
        maxime.chevallier@bootlin.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] mvpp2: remove misleading comment
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191002214904.10887-1-mcroce@redhat.com>
References: <20191002214904.10887-1-mcroce@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 02 Oct 2019 16:25:18 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@redhat.com>
Date: Wed,  2 Oct 2019 23:49:04 +0200

> Recycling in mvpp2 has gone long time ago, but two comment still refers
> to it. Remove those two misleading comments as they generate confusion.
> 
> Fixes: 7ef7e1d949cd ("net: mvpp2: drop useless fields in mvpp2_bm_pool and related code")
> Signed-off-by: Matteo Croce <mcroce@redhat.com>

Applied, thanks.
