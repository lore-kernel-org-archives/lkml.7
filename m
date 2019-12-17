Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C4AC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 22:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCEF221775
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 22:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfLQWS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 17:18:28 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:43668 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfLQWR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:17:57 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1FD1314747E88;
        Tue, 17 Dec 2019 14:17:57 -0800 (PST)
Date:   Tue, 17 Dec 2019 14:17:56 -0800 (PST)
Message-Id: <20191217.141756.1845364096129658130.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, rmk+kernel@armlinux.org.uk,
        ioana.ciornei@nxp.com, olteanv@gmail.com,
        jakub.kicinski@netronome.com, andrew@lunn.ch,
        vivien.didelot@gmail.com, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: Make PHYLINK related function
 static again
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191216183248.16309-1-f.fainelli@gmail.com>
References: <20191216183248.16309-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 17 Dec 2019 14:17:57 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 16 Dec 2019 10:32:47 -0800

> Commit 77373d49de22 ("net: dsa: Move the phylink driver calls into
> port.c") moved and exported a bunch of symbols, but they are not used
> outside of net/dsa/port.c at the moment, so no reason to export them.
> 
> Reported-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied, thank you.
