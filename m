Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC861C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 05:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C0E2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 05:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbfB1FmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 00:42:15 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:55958 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfB1FmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 00:42:14 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6CD8414016664;
        Wed, 27 Feb 2019 21:42:13 -0800 (PST)
Date:   Wed, 27 Feb 2019 21:42:12 -0800 (PST)
Message-Id: <20190227.214212.829038269957184424.davem@davemloft.net>
To:     maxime.chevallier@bootlin.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com
Subject: Re: [PATCH net-next 0/2] net: phy: marvell10g: Clean .get_features
 by using C45 helpers
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190225161407.19510-1-maxime.chevallier@bootlin.com>
References: <20190225161407.19510-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 27 Feb 2019 21:42:13 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Mon, 25 Feb 2019 17:14:05 +0100

> Recent work on C45 helpers by Heiner made the
> genphy_c45_pma_read_abilities function generic enough to use as a
> default .get_featutes implementation.
> 
> This series removes the remaining redundant code in
> mv3310_get_features(), and makes the 2110 PHY use
> genphy_c45_pma_read_abilities() directly, since it doesn't have the
> issue with the wrong abilities being reported.

Series applied, thanks Maxime.
