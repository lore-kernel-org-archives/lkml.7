Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11023C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1281218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbfB1Skx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:40:53 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36668 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfB1Skw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:40:52 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D671614BA0BCD;
        Thu, 28 Feb 2019 10:40:51 -0800 (PST)
Date:   Thu, 28 Feb 2019 10:40:51 -0800 (PST)
Message-Id: <20190228.104051.1946425715498350215.davem@davemloft.net>
To:     antoine.tenart@bootlin.com
Cc:     linux@armlinux.org.uk, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net-next 14/15] net: mvpp2: set the XPCS and MPCS in
 reset when not used
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190228132128.30154-15-antoine.tenart@bootlin.com>
References: <20190228132128.30154-1-antoine.tenart@bootlin.com>
        <20190228132128.30154-15-antoine.tenart@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 28 Feb 2019 10:40:52 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Thu, 28 Feb 2019 14:21:27 +0100

> +static void mvpp22_pcs_reset(struct mvpp2_port *port)
> +{
> +	struct mvpp2 *priv = port->priv;
> +	void __iomem *mpcs = priv->iface_base + MVPP22_MPCS_BASE(port->gop_id);
> +	void __iomem *xpcs = priv->iface_base + MVPP22_XPCS_BASE(port->gop_id);
> +	u32 val;

Reverse christmas tree please.

 ...
> +static void mvpp22_pcs_unreset(struct mvpp2_port *port)
> +{
> +	struct mvpp2 *priv = port->priv;
> +	void __iomem *mpcs = priv->iface_base + MVPP22_MPCS_BASE(port->gop_id);
> +	void __iomem *xpcs = priv->iface_base + MVPP22_XPCS_BASE(port->gop_id);
> +	u32 val;

Likewise.
