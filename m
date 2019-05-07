Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6769DC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47287206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfEGTPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 15:15:04 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33030 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfEGTPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 15:15:03 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4114A14B666A1;
        Tue,  7 May 2019 12:15:03 -0700 (PDT)
Date:   Tue, 07 May 2019 12:15:02 -0700 (PDT)
Message-Id: <20190507.121502.2281459100872862589.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     maxime.chevallier@bootlin.com, antoine.tenart@bootlin.com,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net: mvpp2: cls: fix less than zero check on a
 u32 variable
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190505213814.4220-1-colin.king@canonical.com>
References: <20190505213814.4220-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 07 May 2019 12:15:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Sun,  5 May 2019 22:38:14 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> The signed return from the call to mvpp2_cls_c2_port_flow_index is being
> assigned to the u32 variable c2.index and then checked for a negative
> error condition which is always going to be false. Fix this by assigning
> the return to the int variable index and checking this instead.
> 
> Addresses-Coverity: ("Unsigned compared against 0")
> Fixes: 90b509b39ac9 ("net: mvpp2: cls: Add Classification offload support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
