Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C94C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2968E21744
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394366AbfHVXXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 19:23:12 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50498 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394345AbfHVXXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 19:23:06 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 84EF61539D836;
        Thu, 22 Aug 2019 16:23:04 -0700 (PDT)
Date:   Thu, 22 Aug 2019 16:23:04 -0700 (PDT)
Message-Id: <20190822.162304.1167740070295559909.davem@davemloft.net>
To:     Markus.Elfring@web.de
Cc:     netdev@vger.kernel.org, alexios.zavras@intel.com,
        allison@lohutok.net, armijn@tjaldur.nl, arnd@arndb.de,
        huangfq.daxian@gmail.com, gregkh@linuxfoundation.org,
        hkallweit1@gmail.com, kjlu@umn.edu, isdn@linux-pingi.de,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mISDN: Delete unnecessary checks before the macro call
 =?iso-2022-jp?B?GyRCIUgbKEJkZXZfa2ZyZWVfc2tiGyRCIUkbKEI=?=
From:   David Miller <davem@davemloft.net>
In-Reply-To: <689e51d5-9a43-45a4-5d33-75a34eba928a@web.de>
References: <689e51d5-9a43-45a4-5d33-75a34eba928a@web.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 22 Aug 2019 16:23:05 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <Markus.Elfring@web.de>
Date: Wed, 21 Aug 2019 20:45:09 +0200

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 21 Aug 2019 20:10:56 +0200
> 
> The dev_kfree_skb() function performs also input parameter validation.
> Thus the test around the shown calls is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied.
