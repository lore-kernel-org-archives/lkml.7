Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837BDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1422147C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfCDVNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 16:13:04 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39374 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDVND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 16:13:03 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 13E0010713A96;
        Mon,  4 Mar 2019 13:13:03 -0800 (PST)
Date:   Mon, 04 Mar 2019 13:13:02 -0800 (PST)
Message-Id: <20190304.131302.1804370918769438243.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@roeck-us.net, pankaj.bansal@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: mdio-mux: fix Kconfig dependencies
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190304203554.2017178-1-arnd@arndb.de>
References: <20190304203554.2017178-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 04 Mar 2019 13:13:03 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon,  4 Mar 2019 21:35:10 +0100

> MDIO_BUS_MUX can only be selected if OF_MDIO is already turned on:
> 
> WARNING: unmet direct dependencies detected for MDIO_BUS_MUX
>   Depends on [n]: NETDEVICES [=y] && MDIO_BUS [=m] && OF_MDIO [=n]
>   Selected by [m]:
>   - MDIO_BUS_MUX_MULTIPLEXER [=m] && NETDEVICES [=y] && MDIO_BUS [=m] && OF [=y]
> 
> Fixes: 7865ad6551c9 ("drivers: net: phy: mdio-mux: Add support for Generic Mux controls")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
