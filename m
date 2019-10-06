Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7571C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 13:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3D620835
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 13:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfJFN4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 09:56:43 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44386 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfJFN4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 09:56:43 -0400
Received: from localhost (unknown [63.64.162.234])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A3D921429F7D9;
        Sun,  6 Oct 2019 06:56:42 -0700 (PDT)
Date:   Sun, 06 Oct 2019 15:56:42 +0200 (CEST)
Message-Id: <20191006.155642.1768701400675135903.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, h.feurstein@gmail.com, andrew@lunn.ch,
        vivien.didelot@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: b53: Do not clear existing mirrored port
 mask
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191005220518.14008-1-f.fainelli@gmail.com>
References: <20191005220518.14008-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 06 Oct 2019 06:56:42 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Sat,  5 Oct 2019 15:05:18 -0700

> Clearing the existing bitmask of mirrored ports essentially prevents us
> from capturing more than one port at any given time. This is clearly
> wrong, do not clear the bitmask prior to setting up the new port.
> 
> Reported-by: Hubert Feurstein <h.feurstein@gmail.com>
> Fixes: ed3af5fd08eb ("net: dsa: b53: Add support for port mirroring")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied and queued up for -stable, thanks.
