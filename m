Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B687C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 10:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623122075D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 10:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfD1KkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 06:40:17 -0400
Received: from gloria.sntech.de ([185.11.138.130]:47612 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfD1KkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 06:40:17 -0400
Received: from p57b775bf.dip0.t-ipconnect.de ([87.183.117.191] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hKhE9-0005IF-Ax; Sun, 28 Apr 2019 12:40:09 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Yi Wang <wang.yi59@zte.com.cn>
Subject: Re: [v3] ARM: rockchip: Fix a leaked reference by adding of_node_put() in two functions
Date:   Sun, 28 Apr 2019 12:40:08 +0200
Message-ID: <2816348.laE8LpYbrI@phil>
In-Reply-To: <cee2ab03-d0b7-c9c6-acc3-d5aa28979e2b@web.de>
References: <1556262488-21072-1-git-send-email-wen.yang99@zte.com.cn> <cee2ab03-d0b7-c9c6-acc3-d5aa28979e2b@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 28. April 2019, 08:27:05 CEST schrieb Markus Elfring:
> >  arch/arm/mach-rockchip/platsmp.c | 12 ++++++++++--
> >  arch/arm/mach-rockchip/pm.c      |  2 ++
> 
> * Would a commit subject variant be nicer?

yeah, but I'll simply adjust that when applying.

> * I dare to present a reminder for a recurring development topic.
>   How do you think about to adjust the exception handling in these function
>   implementations a bit more according to the Linux coding style
>   (so that the addition of duplicate function calls would be avoided)?

I actually requested not doing wild gotos for of_node_put calls,
as it makes the code harder to read, especially when the "node"
gets reused for a different node-source.


