Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45924C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A88F2184E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfC2AKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:10:21 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59116 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbfC2AKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:10:21 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7B8BD14D688B2;
        Thu, 28 Mar 2019 17:10:20 -0700 (PDT)
Date:   Thu, 28 Mar 2019 17:10:19 -0700 (PDT)
Message-Id: <20190328.171019.1513054072749064700.davem@davemloft.net>
To:     aaro.koskinen@iki.fi
Cc:     joabreu@synopsys.com, alexandre.torgue@st.com,
        peppe.cavallaro@st.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, aaro.koskinen@nokia.com
Subject: Re: [PATCH 0/6] net: stmmac: fix handling of oversized frames
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190327203540.1884-1-aaro.koskinen@iki.fi>
References: <20190327203540.1884-1-aaro.koskinen@iki.fi>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 28 Mar 2019 17:10:20 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Wed, 27 Mar 2019 22:35:34 +0200

> I accidentally had MTU size mismatch (9000 vs. 1500) in my network,
> and I noticed I could kill a system using stmmac & 1500 MTU simply
> by pinging it with "ping -s 2000 ...".
> 
> While testing a fix I encountered also some other issues that need fixing.
> 
> I have tested these only with enhanced descriptors, so the normal
> descriptor changes need a careful review.

I really want to see some stmmac developers review and/or test these
changes.

Thanks.
