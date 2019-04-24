Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC01C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A38218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbfDXBgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 21:36:06 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:47478 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729050AbfDXBgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 21:36:06 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B639E1400E1E7;
        Tue, 23 Apr 2019 18:36:05 -0700 (PDT)
Date:   Tue, 23 Apr 2019 18:36:05 -0700 (PDT)
Message-Id: <20190423.183605.258474599142114724.davem@davemloft.net>
To:     sfr@canb.auug.org.au
Cc:     netdev@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: linux-next: build failure after merge of the net-next tree
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190423172524.3bcf6bd0@canb.auug.org.au>
References: <20190423172524.3bcf6bd0@canb.auug.org.au>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 23 Apr 2019 18:36:05 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 23 Apr 2019 17:25:24 +1000

> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 23 Apr 2019 17:12:19 +1000
> Subject: [PATCH] net: fix sparc64 compilation of sock_gettstamp
> 
> Fixes: c7cbdbf29f48 ("net: rework SIOCGSTAMP ioctl handling")
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Applied, thanks Stephen.
