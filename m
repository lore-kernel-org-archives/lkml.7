Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D602C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 01:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681BD206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 01:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfLKBch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 20:32:37 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:51126 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfLKBch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 20:32:37 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 981B815039439;
        Tue, 10 Dec 2019 17:32:36 -0800 (PST)
Date:   Tue, 10 Dec 2019 17:32:36 -0800 (PST)
Message-Id: <20191210.173236.1849931419980155783.davem@davemloft.net>
To:     michael@walle.cc
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        claudiu.manoil@nxp.com
Subject: Re: [PATCH net-next] enetc: add software timestamping
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191210001537.25630-1-michael@walle.cc>
References: <20191210001537.25630-1-michael@walle.cc>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 10 Dec 2019 17:32:36 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>
Date: Tue, 10 Dec 2019 01:15:37 +0100

> Provide a software TX timestamp and add it to the ethtool query
> interface.
> 
> skb_tx_timestamp() is also needed if one would like to use PHY
> timestamping.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thanks.
