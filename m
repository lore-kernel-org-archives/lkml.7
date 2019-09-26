Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4013C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 06:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9183E222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 06:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403921AbfIZGwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 02:52:23 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44424 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730840AbfIZGwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 02:52:23 -0400
Received: from localhost (unknown [65.39.69.237])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5E1DF1264C650;
        Wed, 25 Sep 2019 23:52:20 -0700 (PDT)
Date:   Thu, 26 Sep 2019 08:51:43 +0200 (CEST)
Message-Id: <20190926.085143.1537501301806414720.davem@davemloft.net>
To:     rain.1986.08.12@gmail.com
Cc:     yanjun.zhu@oracle.com, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, robh@kernel.org,
        linus.walleij@linaro.org, nicolas.ferre@microchip.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] MAINTAINERS: add Yanjun to FORCEDETH maintainers
 list
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190923143746.4310-1-rain.1986.08.12@gmail.com>
References: <20190923143746.4310-1-rain.1986.08.12@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 25 Sep 2019 23:52:22 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: rain.1986.08.12@gmail.com
Date: Mon, 23 Sep 2019 22:37:46 +0800

> From: Rain River <rain.1986.08.12@gmail.com>
> 
> Yanjun has been spending quite a lot of time fixing bugs
> in FORCEDETH source code. I'd like to add Yanjun to maintainers
> list.
> 
> Signed-off-by: Rain River <rain.1986.08.12@gmail.com>

Applied, thank you.
