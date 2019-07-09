Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF0DC606CF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 03:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6FF2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 03:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfGIDLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 23:11:04 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34284 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfGIDLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 23:11:04 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3FF91133F9EC7;
        Mon,  8 Jul 2019 20:11:03 -0700 (PDT)
Date:   Mon, 08 Jul 2019 20:11:02 -0700 (PDT)
Message-Id: <20190708.201102.1931743973646074575.davem@davemloft.net>
To:     huangfq.daxian@gmail.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/14] net: phy: Make use of linkmode_mod_bit helper
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190708123417.12265-1-huangfq.daxian@gmail.com>
References: <20190708123417.12265-1-huangfq.daxian@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 08 Jul 2019 20:11:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuqian Huang <huangfq.daxian@gmail.com>
Date: Mon,  8 Jul 2019 20:34:17 +0800

> linkmode_mod_bit is introduced as a helper function to set/clear
> bits in a linkmode.
> Replace the if else code structure with a call to the helper
> linkmode_mod_bit.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>

Applied to net-next, thanks.
