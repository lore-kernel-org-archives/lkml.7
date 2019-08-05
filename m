Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD93C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49DB520B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfHERrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:47:05 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59818 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfHERrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:47:05 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CED81154086FA;
        Mon,  5 Aug 2019 10:47:04 -0700 (PDT)
Date:   Mon, 05 Aug 2019 10:47:04 -0700 (PDT)
Message-Id: <20190805.104704.1943402179346616570.davem@davemloft.net>
To:     Jose.Abreu@synopsys.com
Cc:     netdev@vger.kernel.org, Joao.Pinto@synopsys.com,
        peppe.cavallaro@st.com, alexandre.torgue@st.com,
        mcoquelin.stm32@gmail.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 00/26] net: stmmac: Misc improvements for XGMAC
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1565022597.git.joabreu@synopsys.com>
References: <cover.1565022597.git.joabreu@synopsys.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 05 Aug 2019 10:47:05 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch series is way too large.

Break it down into smaller collections of changes, say a dozen at a time or so.

Thank you.

