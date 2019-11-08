Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2C6FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 03:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060B020865
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 03:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbfKHDmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 22:42:00 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52632 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfKHDl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 22:41:59 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C32C514EBB7A9;
        Thu,  7 Nov 2019 19:41:58 -0800 (PST)
Date:   Thu, 07 Nov 2019 19:41:56 -0800 (PST)
Message-Id: <20191107.194156.2189564128567853310.davem@davemloft.net>
To:     michael@walle.cc
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        claudiu.manoil@nxp.com, andrew@lunn.ch
Subject: Re: [PATCH] enetc: fix return value for enetc_ioctl()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191107235821.12767-1-michael@walle.cc>
References: <20191107235821.12767-1-michael@walle.cc>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 07 Nov 2019 19:41:59 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>
Date: Fri,  8 Nov 2019 00:58:21 +0100

> Return -EOPNOTSUPP instead of -EINVAL if the requested ioctl is not
> implemented.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Always specificy explcitly the target tree for your change, in the
Subject line, which in this case should have been:

	[PATCH net-next] enetc: ...
