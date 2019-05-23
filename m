Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460EBC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252402175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbfEWQTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 12:19:50 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48336 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731254AbfEWQTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 12:19:49 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 12E461509B033;
        Thu, 23 May 2019 09:19:49 -0700 (PDT)
Date:   Thu, 23 May 2019 09:19:48 -0700 (PDT)
Message-Id: <20190523.091948.2094790534090543013.davem@davemloft.net>
To:     christophe.leroy@c-s.fr
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: phy: lxt: Add suspend/resume support
 to LXT971 and LXT973.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <eb206b659fcae041be38d583ff139ca73e9e03c3.1558601485.git.christophe.leroy@c-s.fr>
References: <eb206b659fcae041be38d583ff139ca73e9e03c3.1558601485.git.christophe.leroy@c-s.fr>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 23 May 2019 09:19:49 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Thu, 23 May 2019 08:55:32 +0000 (UTC)

> All LXT PHYs implement the standard "power down" bit 11 of
> BMCR, so this patch adds support using the generic
> genphy_{suspend,resume} functions added by
> commit 0f0ca340e57b ("phy: power management support").
> 
> LXT970 is left aside because all registers get cleared upon
> "power down" exit.
> 
> Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  I'd be happy if you could also merge that into 4.19
> 
>  v2: revised commit log without the Fixes: tag.

Applied, thanks.
