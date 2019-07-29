Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601A3C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3799C206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbfG2SBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 14:01:08 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36906 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfG2SBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 14:01:07 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BACAE140505B5;
        Mon, 29 Jul 2019 11:01:06 -0700 (PDT)
Date:   Mon, 29 Jul 2019 11:01:06 -0700 (PDT)
Message-Id: <20190729.110106.1654712144874525336.davem@davemloft.net>
To:     mcroce@redhat.com
Cc:     netdev@vger.kernel.org, antoine.tenart@bootlin.com,
        maxime.chevallier@bootlin.com, mw@semihalf.com,
        stefanc@marvell.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] mvpp2: refactor MTU change code
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190728004645.4807-1-mcroce@redhat.com>
References: <20190728004645.4807-1-mcroce@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 29 Jul 2019 11:01:07 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@redhat.com>
Date: Sun, 28 Jul 2019 02:46:45 +0200

> The MTU change code can call napi_disable() with the device already down,
> leading to a deadlock. Also, lot of code is duplicated unnecessarily.
> 
> Rework mvpp2_change_mtu() to avoid the deadlock and remove duplicated code.
> 
> Fixes: 3f518509dedc ("ethernet: Add new driver for Marvell Armada 375 network unit")
> Signed-off-by: Matteo Croce <mcroce@redhat.com>

Applied and queued up for -stable, thanks.
