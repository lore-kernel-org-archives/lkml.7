Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD913CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 23:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93506208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 23:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731302AbfJ1XYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 19:24:12 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46546 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfJ1XYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 19:24:12 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3910E14BE91D7;
        Mon, 28 Oct 2019 16:24:11 -0700 (PDT)
Date:   Mon, 28 Oct 2019 16:24:10 -0700 (PDT)
Message-Id: <20191028.162410.844978847156294593.davem@davemloft.net>
To:     benh@kernel.crashing.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        vijaykhemka@fb.com, openbmc@lists.ozlabs.org, joel@jms.id.au,
        linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH] net: ethernet: ftgmac100: Fix DMA coherency issue with
 SW checksum
From:   David Miller <davem@davemloft.net>
In-Reply-To: <572a7d510ace5e5a5ba41c4774d330133291c82a.camel@kernel.crashing.org>
References: <572a7d510ace5e5a5ba41c4774d330133291c82a.camel@kernel.crashing.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 28 Oct 2019 16:24:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 25 Oct 2019 13:47:24 +1100

> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Fixes: 05690d633f30 ftgmac100: Upgrade to NETIF_F_HW_CSUM

Please put the commit header string inside double quotes and parenthesis
(" ")

> CC: stable@vger.kernel.org [v4.12+]

Do not CC: stable for networking submissions as per the netdev FAQ.

All fixed up, and queued up for -stable, thanks Ben.
