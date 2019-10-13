Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D007C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 18:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48050206A3
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 18:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbfJMSP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 14:15:56 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42644 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfJMSP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 14:15:56 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6B609146D3308;
        Sun, 13 Oct 2019 11:15:55 -0700 (PDT)
Date:   Sun, 13 Oct 2019 11:15:53 -0700 (PDT)
Message-Id: <20191013.111553.1514414602719474672.davem@davemloft.net>
To:     alexandre.belloni@bootlin.com
Cc:     vz@mleia.com, slemieux.tyco@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] net: lpc_eth: avoid resetting twice
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191010204606.15279-1-alexandre.belloni@bootlin.com>
References: <20191010204606.15279-1-alexandre.belloni@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 13 Oct 2019 11:15:55 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Thu, 10 Oct 2019 22:46:06 +0200

> __lpc_eth_shutdown is called after __lpc_eth_reset but it is already
> calling __lpc_eth_reset. Avoid resetting the IP twice.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Applied.
