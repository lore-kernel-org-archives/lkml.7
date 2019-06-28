Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16757C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D1C2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfF1QYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 12:24:16 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:47016 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfF1QYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:24:16 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8D8E514E03874;
        Fri, 28 Jun 2019 09:24:15 -0700 (PDT)
Date:   Fri, 28 Jun 2019 09:24:15 -0700 (PDT)
Message-Id: <20190628.092415.219171929303857748.davem@davemloft.net>
To:     Jose.Abreu@synopsys.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Joao.Pinto@synopsys.com, peppe.cavallaro@st.com,
        alexandre.torgue@st.com
Subject: Re: [PATCH net-next v2 00/10] net: stmmac: 10GbE using XGMAC
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1561706800.git.joabreu@synopsys.com>
References: <cover.1561706800.git.joabreu@synopsys.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 28 Jun 2019 09:24:15 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>
Date: Fri, 28 Jun 2019 09:29:11 +0200

> Support for 10Gb Link using XGMAC core plus some performance tweaks.
> 
> Tested in a PCI based setup.
> 
> iperf3 TCP results:
> 	TSO ON, MTU=1500, TX Queues = 1, RX Queues = 1, Flow Control ON
> 	Pinned CPU (-A), Zero-Copy (-Z)
> 
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-600.00 sec   643 GBytes  9.21 Gbits/sec    1             sender
> [  5]   0.00-600.00 sec   643 GBytes  9.21 Gbits/sec                  receiver

Series applied, thanks Jose.

About the Kconfig change, maybe it just doesn't make sense to list all
of the various speeds the chip supports... just a thought.
