Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5F9C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF252063F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732794AbfHOU6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 16:58:53 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50208 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfHOU6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 16:58:52 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3A4AB1402BC49;
        Thu, 15 Aug 2019 13:58:52 -0700 (PDT)
Date:   Thu, 15 Aug 2019 13:58:51 -0700 (PDT)
Message-Id: <20190815.135851.1942927063321516679.davem@davemloft.net>
To:     hayeswang@realtek.com
Cc:     netdev@vger.kernel.org, nic_swsd@realtek.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] r8152: divide the tx and rx bottom functions
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1394712342-15778-301-Taiwan-albertk@realtek.com>
References: <1394712342-15778-301-Taiwan-albertk@realtek.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 15 Aug 2019 13:58:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hayes Wang <hayeswang@realtek.com>
Date: Wed, 14 Aug 2019 16:30:17 +0800

> Move the tx bottom function from NAPI to a new tasklet. Then, for
> multi-cores, the bottom functions of tx and rx may be run at same
> time with different cores. This is used to improve performance.
> 
> Signed-off-by: Hayes Wang <hayeswang@realtek.com>

Theoretically, yes.

But do you have actual performance numbers showing this to be worth
the change?

Always provide performance numbers with changes that are supposed to
improve performance.
