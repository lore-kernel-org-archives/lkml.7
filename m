Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB7BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCB52184E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfC2AC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:02:59 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59010 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbfC2AC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:02:59 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 052BD14D6763C;
        Thu, 28 Mar 2019 17:02:57 -0700 (PDT)
Date:   Thu, 28 Mar 2019 17:02:57 -0700 (PDT)
Message-Id: <20190328.170257.1630360267676400395.davem@davemloft.net>
To:     maxime.chevallier@bootlin.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, mw@semihalf.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        andrew@lunn.ch
Subject: Re: [PATCH net-next] net: mvneta: Add 2500BaseT support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190327163107.11642-1-maxime.chevallier@bootlin.com>
References: <20190327163107.11642-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 28 Mar 2019 17:02:58 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Wed, 27 Mar 2019 17:31:06 +0100

> Some PHYs will use the 2500BaseX PHY_INTERFACE_MODE when being linked
> with a partner using 2.5GBaseT.
> 
> Since we can't autonegotiate this speed between the MAC and the PHY, we
> need to have the proper comphy support enabled, to make sure we can
> safely advertise 2.5G and 1G in BaseT and be able to switch between both
> corresponding PHY interface modes. This is now possible since comphy
> support was added to this driver.
> 
> This commit adds the 2500BaseT mode to the list of supported modes when
> using 2500BaseX, and was tested on a setup with an Armada385 and a
> 88E2010 PHY, both with and without the comphy node in the DT.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Applied.
