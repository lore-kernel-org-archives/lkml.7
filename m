Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C59AC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 00:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE1F21835
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 00:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfLQAIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 19:08:53 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57564 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbfLQAIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 19:08:52 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EF7AD1556D1E2;
        Mon, 16 Dec 2019 16:08:51 -0800 (PST)
Date:   Mon, 16 Dec 2019 16:08:51 -0800 (PST)
Message-Id: <20191216.160851.2100757770455570941.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, andrew@lunn.ch, vivien.didelot@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: b53: Fix egress flooding settings
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191213200027.20803-1-f.fainelli@gmail.com>
References: <20191213200027.20803-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 16 Dec 2019 16:08:52 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri, 13 Dec 2019 12:00:27 -0800

> There were several issues with 53568438e381 ("net: dsa: b53: Add support for port_egress_floods callback") that resulted in breaking connectivity for standalone ports:
> 
> - both user and CPU ports must allow unicast and multicast forwarding by
>   default otherwise this just flat out breaks connectivity for
>   standalone DSA ports
> - IP multicast is treated similarly as multicast, but has separate
>   control registers
> - the UC, MC and IPMC lookup failure register offsets were wrong, and
>   instead used bit values that are meaningful for the
>   B53_IP_MULTICAST_CTRL register
> 
> Fixes: 53568438e381 ("net: dsa: b53: Add support for port_egress_floods callback")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied and queued up for v5.4 -stable, thanks.
