Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD32C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AFA82071B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfKVRg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 12:36:59 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38024 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVRg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 12:36:58 -0500
Received: from localhost (c-73-35-209-67.hsd1.wa.comcast.net [73.35.209.67])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A474A1527B1C2;
        Fri, 22 Nov 2019 09:36:57 -0800 (PST)
Date:   Fri, 22 Nov 2019 09:36:57 -0800 (PST)
Message-Id: <20191122.093657.95680289541075120.davem@davemloft.net>
To:     bot@kernelci.org
Cc:     hulkci@huawei.com, tomeu.vizoso@collabora.com,
        guillaume.tucker@collabora.com, broonie@kernel.org,
        khilman@baylibre.com, mgalka@collabora.com,
        enric.balletbo@collabora.com, yuehaibing@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com
Subject: Re: net-next/master bisection: boot on beaglebone-black
From:   David Miller <davem@davemloft.net>
In-Reply-To: <5dd7d181.1c69fb81.64fbc.cd8a@mx.google.com>
References: <5dd7d181.1c69fb81.64fbc.cd8a@mx.google.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 22 Nov 2019 09:36:58 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "kernelci.org bot" <bot@kernelci.org>
Date: Fri, 22 Nov 2019 04:16:01 -0800 (PST)

>     mdio_bus: Fix PTR_ERR applied after initialization to constant
>     
>     Fix coccinelle warning:
>     
>     ./drivers/net/phy/mdio_bus.c:67:5-12: ERROR: PTR_ERR applied after initialization to constant on line 62
>     ./drivers/net/phy/mdio_bus.c:68:5-12: ERROR: PTR_ERR applied after initialization to constant on line 62

The kernelci.org bot has posted at least a half dozen of these bisection
results for the same exact bug, which we've fixed two days ago....

This is becomming more like spam and not very useful....
