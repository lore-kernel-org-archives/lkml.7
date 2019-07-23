Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BBFC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 01:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F317E21955
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 01:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387715AbfGWBOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 21:14:06 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52374 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfGWBOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 21:14:06 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 26999153053F1;
        Mon, 22 Jul 2019 18:14:05 -0700 (PDT)
Date:   Mon, 22 Jul 2019 18:14:04 -0700 (PDT)
Message-Id: <20190722.181404.2250205918210350551.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     netdev@vger.kernel.org, linux-serial@vger.kernel.org,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] [net-next] net: remove netx ethernet driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190722191304.164929-1-arnd@arndb.de>
References: <20190722191304.164929-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 22 Jul 2019 18:14:05 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 22 Jul 2019 21:12:31 +0200

> The ARM netx platform got removed in 5.3, so this driver
> is now useless.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: David S. Miller <davem@davemloft.net>

(btw two copies of this went out for some reason)
