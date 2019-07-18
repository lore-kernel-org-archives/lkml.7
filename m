Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF8CC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D83F21849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391100AbfGRTGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:06:02 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54306 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbfGRTGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:06:01 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3F4E21527DCCF;
        Thu, 18 Jul 2019 12:06:01 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:06:00 -0700 (PDT)
Message-Id: <20190718.120600.607199310950720839.davem@davemloft.net>
To:     thesven73@gmail.com
Cc:     fugang.duan@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: fec: generate warning when using deprecated phy
 reset
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190718143428.2392-1-TheSven73@gmail.com>
References: <20190718143428.2392-1-TheSven73@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 18 Jul 2019 12:06:01 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <thesven73@gmail.com>
Date: Thu, 18 Jul 2019 10:34:28 -0400

> Allowing the fec to reset its PHY via the phy-reset-gpios
> devicetree property is deprecated. To improve developer
> awareness, generate a warning whenever the deprecated
> property is used.
> 
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>

The device tree documentation in the kernel tree is where information
like this belongs.  Yelling at the user in the kernel logs is not.
