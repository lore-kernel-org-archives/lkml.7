Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B65C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 01:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E8B21955
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 01:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387736AbfGWBPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 21:15:46 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52402 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfGWBPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 21:15:45 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DA089153053FA;
        Mon, 22 Jul 2019 18:15:44 -0700 (PDT)
Date:   Mon, 22 Jul 2019 18:15:44 -0700 (PDT)
Message-Id: <20190722.181544.1228798063685831790.davem@davemloft.net>
To:     maxime.chevallier@bootlin.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, nadavh@marvell.com,
        stefanc@marvell.com, mw@semihalf.com, miquel.raynal@bootlin.com
Subject: Re: [PATCH net] net: mvpp2: Don't check for 3 consecutive Idle
 frames for 10G links
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190719143848.3826-1-maxime.chevallier@bootlin.com>
References: <20190719143848.3826-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 22 Jul 2019 18:15:45 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Fri, 19 Jul 2019 16:38:48 +0200

> PPv2's XLGMAC can wait for 3 idle frames before triggering a link up
> event. This can cause the link to be stuck low when there's traffic on
> the interface, so disable this feature.
> 
> Fixes: 4bb043262878 ("net: mvpp2: phylink support")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Applied.
