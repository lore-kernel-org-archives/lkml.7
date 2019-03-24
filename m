Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99606C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 01:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7BC2183E
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 01:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfCXBQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 21:16:19 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35074 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbfCXBQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 21:16:19 -0400
Received: from localhost (unknown [50.233.106.125])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 96B0314B4763D;
        Sat, 23 Mar 2019 18:16:18 -0700 (PDT)
Date:   Sat, 23 Mar 2019 21:16:18 -0400 (EDT)
Message-Id: <20190323.211618.873690390112372595.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: Re-parent menus for MDIO bus drivers
 correctly
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190321233445.11526-1-f.fainelli@gmail.com>
References: <20190321233445.11526-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 23 Mar 2019 18:16:18 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu, 21 Mar 2019 16:34:44 -0700

> After 90eff9096c01 ("net: phy: Allow splitting MDIO bus/device support
> from PHYs") the various MDIO bus drivers were no longer parented with
> config PHYLIB but with config MDIO_BUS which is not a menuconfig, fix
> this by depending on MDIO_DEVICE which is a menuconfig.
> 
> This is visually nicer and less confusing for users.
> 
> Fixes: 90eff9096c01 ("net: phy: Allow splitting MDIO bus/device support from PHYs")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied.
