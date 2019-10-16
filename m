Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234BCC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0029B20854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391168AbfJPD5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 23:57:10 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44286 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfJPD5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 23:57:10 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B66F6108B8674;
        Tue, 15 Oct 2019 20:57:09 -0700 (PDT)
Date:   Tue, 15 Oct 2019 20:57:09 -0700 (PDT)
Message-Id: <20191015.205709.544930489994384528.davem@davemloft.net>
To:     ben.dooks@codethink.co.uk
Cc:     linux-kernel@lists.codethink.co.uk, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: make tc_flow_parsers static
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191015161748.31576-1-ben.dooks@codethink.co.uk>
References: <20191015161748.31576-1-ben.dooks@codethink.co.uk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 15 Oct 2019 20:57:10 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Date: Tue, 15 Oct 2019 17:17:48 +0100

> The tc_flow_parsers is not used outside of the driver, so
> make it static to avoid the following sparse warning:
> 
> drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c:516:3: warning: symbol 'tc_flow_parsers' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Applied.
