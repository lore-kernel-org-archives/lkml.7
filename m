Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25569C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C3321773
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfENWla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 18:41:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59772 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfENWla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 18:41:30 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C0F4D14C048B2;
        Tue, 14 May 2019 15:41:29 -0700 (PDT)
Date:   Tue, 14 May 2019 15:41:29 -0700 (PDT)
Message-Id: <20190514.154129.1092466491484366074.davem@davemloft.net>
To:     luca@lucaceresoli.net
Cc:     netdev@vger.kernel.org, nicolas.ferre@microchip.com,
        linux-kernel@vger.kernel.org, andrew@lunn.ch,
        soren.brinkmann@xilinx.com, cyrille.pitchen@atmel.com,
        shubhrajyoti.datta@xilinx.com, harini.katakam@xilinx.com
Subject: Re: [PATCH net RESEND] net: macb: fix error format in dev_err()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190514132307.15311-1-luca@lucaceresoli.net>
References: <20190514132307.15311-1-luca@lucaceresoli.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 14 May 2019 15:41:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Ceresoli <luca@lucaceresoli.net>
Date: Tue, 14 May 2019 15:23:07 +0200

> Errors are negative numbers. Using %u shows them as very large positive
> numbers such as 4294967277 that don't make sense. Use the %d format
> instead, and get a much nicer -19.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> Fixes: b48e0bab142f ("net: macb: Migrate to devm clock interface")
> Fixes: 93b31f48b3ba ("net/macb: unify clock management")
> Fixes: 421d9df0628b ("net/macb: merge at91_ether driver into macb driver")
> Fixes: aead88bd0e99 ("net: ethernet: macb: Add support for rx_clk")
> Fixes: f5473d1d44e4 ("net: macb: Support clock management for tsu_clk")
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Applied.
