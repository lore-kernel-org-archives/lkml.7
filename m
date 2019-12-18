Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB59C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 06:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A690521D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 06:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfLRGjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 01:39:22 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:47348 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfLRGjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 01:39:22 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 762971500BB50;
        Tue, 17 Dec 2019 22:39:21 -0800 (PST)
Date:   Tue, 17 Dec 2019 22:39:20 -0800 (PST)
Message-Id: <20191217.223920.2253637492180028793.davem@davemloft.net>
To:     o.rempel@pengutronix.de
Cc:     jcliburn@gmail.com, chris.snook@gmail.com, andrew@lunn.ch,
        kernel@pengutronix.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: ag71xx: fix compile warnings
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191217065145.9329-1-o.rempel@pengutronix.de>
References: <20191217065145.9329-1-o.rempel@pengutronix.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 17 Dec 2019 22:39:21 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Tue, 17 Dec 2019 07:51:45 +0100

> drivers/net/ethernet/atheros/ag71xx.c: In function 'ag71xx_probe':
> drivers/net/ethernet/atheros/ag71xx.c:1776:30: warning: passing argument 2 of
>  'of_get_phy_mode' makes pointer from integer without a cast [-Wint-conversion]
> In file included from drivers/net/ethernet/atheros/ag71xx.c:33:
> ./include/linux/of_net.h:15:69: note: expected 'phy_interface_t *'
>  {aka 'enum <anonymous> *'} but argument is of type 'int'
> 
> Fixes: 0c65b2b90d13c1 ("net: of_get_phy_mode: Change API to solve int/unit warnings")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Applied, thank you.
