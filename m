Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D84EC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F189420693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbfG3R2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:28:52 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52494 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfG3R2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:28:52 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B7B571239C4CE;
        Tue, 30 Jul 2019 10:28:51 -0700 (PDT)
Date:   Tue, 30 Jul 2019 10:28:51 -0700 (PDT)
Message-Id: <20190730.102851.1996008524459618236.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     claudiu.manoil@nxp.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] enetc: Fix build error without PHYLIB
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190730142959.50892-1-yuehaibing@huawei.com>
References: <20190730142959.50892-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 30 Jul 2019 10:28:51 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 30 Jul 2019 22:29:59 +0800

> If PHYLIB is not set, build enetc will fails:
> 
> drivers/net/ethernet/freescale/enetc/enetc.o: In function `enetc_open':
> enetc.c: undefined reference to `phy_disconnect'
> enetc.c: undefined reference to `phy_start'
> drivers/net/ethernet/freescale/enetc/enetc.o: In function `enetc_close':
> enetc.c: undefined reference to `phy_stop'
> enetc.c: undefined reference to `phy_disconnect'
> drivers/net/ethernet/freescale/enetc/enetc_ethtool.o: undefined reference to `phy_ethtool_get_link_ksettings'
> drivers/net/ethernet/freescale/enetc/enetc_ethtool.o: undefined reference to `phy_ethtool_set_link_ksettings'
> drivers/net/ethernet/freescale/enetc/enetc_mdio.o: In function `enetc_mdio_probe':
> enetc_mdio.c: undefined reference to `mdiobus_alloc_size'
> enetc_mdio.c: undefined reference to `mdiobus_free'
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
