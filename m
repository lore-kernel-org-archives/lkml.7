Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7A1C33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 22:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFA220848
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 22:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgAEW1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 17:27:22 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:40670 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgAEW1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 17:27:21 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3EF1F1573FC16;
        Sun,  5 Jan 2020 14:27:20 -0800 (PST)
Date:   Sun, 05 Jan 2020 14:27:19 -0800 (PST)
Message-Id: <20200105.142719.2267255724230212968.davem@davemloft.net>
To:     dmitry.torokhov@gmail.com
Cc:     netdev@vger.kernel.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com, linux@armlinux.org.uk
Subject: Re: [PATCH v3 0/3] net: phy: switch to using fwnode_gpiod_get_index
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200103010320.245675-1-dmitry.torokhov@gmail.com>
References: <20200103010320.245675-1-dmitry.torokhov@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 05 Jan 2020 14:27:20 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu,  2 Jan 2020 17:03:17 -0800

> This series switches phy drivers form using fwnode_get_named_gpiod() and
> gpiod_get_from_of_node() that are scheduled to be removed in favor
> of fwnode_gpiod_get_index() that behaves more like standard
> gpiod_get_index() and will potentially handle secondary software
> nodes in cases we need to augment platform firmware.
> 
> Now that the dependencies have been merged into networking tree the
> patches can be applied there as well.
> 
> v3:
>         - rebased on top of net-next
> 
> v2:
>         - rebased on top of Linus' W devel branch
>         - added David's ACKs

Series applied, thanks.
