Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7909C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AA320848
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfDOUZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:25:16 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57620 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfDOUZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:25:16 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 87C1F14D8ADBC;
        Mon, 15 Apr 2019 13:25:15 -0700 (PDT)
Date:   Mon, 15 Apr 2019 13:25:15 -0700 (PDT)
Message-Id: <20190415.132515.517676613000816938.davem@davemloft.net>
To:     lukas.bulwahn@gmail.com
Cc:     woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: normalize Woojung Huh's email address
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190413075215.11889-1-lukas.bulwahn@gmail.com>
References: <20190413075215.11889-1-lukas.bulwahn@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 15 Apr 2019 13:25:15 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Sat, 13 Apr 2019 09:52:15 +0200

> MAINTAINERS contains a lower-case and upper-case variant of
> Woojung Huh' s email address.
> 
> Only keep the lower-case variant in MAINTAINERS.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Applied.
