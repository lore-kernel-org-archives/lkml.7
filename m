Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD17C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F2820725
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfKOBnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 20:43:12 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57320 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfKOBnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 20:43:11 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E749614B74FCE;
        Thu, 14 Nov 2019 17:43:10 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:43:10 -0800 (PST)
Message-Id: <20191114.174310.641355157514372285.davem@davemloft.net>
To:     dmurphy@ti.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] net: phy: dp83869: Add TI dp83869 phy
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191113164226.3281-2-dmurphy@ti.com>
References: <20191113164226.3281-1-dmurphy@ti.com>
        <20191113164226.3281-2-dmurphy@ti.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 14 Nov 2019 17:43:11 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Murphy <dmurphy@ti.com>
Date: Wed, 13 Nov 2019 10:42:26 -0600

> Add support for the TI DP83869 Gigabit ethernet phy
> device.
> 
> The DP83869 is a robust, low power, fully featured
> Physical Layer transceiver with integrated PMD
> sublayers to support 10BASE-T, 100BASE-TX and
> 1000BASE-T Ethernet protocols.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

Applied to net-next.
