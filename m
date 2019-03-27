Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F8FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144532147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391987AbfC0S31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:29:27 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56538 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391694AbfC0S3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:29:24 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A080F14C850BB;
        Wed, 27 Mar 2019 11:29:23 -0700 (PDT)
Date:   Wed, 27 Mar 2019 11:29:23 -0700 (PDT)
Message-Id: <20190327.112923.2284635623125598604.davem@davemloft.net>
To:     Kavyasree.Kotagiri@microchip.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        quentin.schulz@bootlin.com
Subject: Re: [PATCH v1 1/2] net: phy: mscc: add support for VSC8514 PHY
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190327095553.6234-1-kavyasree.kotagiri@microchip.com>
References: <20190327095553.6234-1-kavyasree.kotagiri@microchip.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 27 Mar 2019 11:29:24 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: <Kavyasree.Kotagiri@microchip.com>
Date: Wed, 27 Mar 2019 09:56:13 +0000

> +static u32 vsc85xx_csr_ctrl_phy_read(struct phy_device *phydev,
> +				     u32 target, u32 reg)
> +{
> +	u32 val, val_l, val_h;
> +	unsigned long deadline;

Please order local variable declarations from longest to shortest
line, ie. reverse christmas tree.

> +static int vsc8514_config_init(struct phy_device *phydev)
> +{
> +	int ret, i;
> +	u16 val, addr;
> +	u32 reg;
> +	unsigned long deadline;
> +	struct vsc8531_private *vsc8531 = phydev->priv;

Likewise.
