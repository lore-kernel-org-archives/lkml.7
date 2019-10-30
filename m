Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF874CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 01:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D73A20856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 01:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfJ3Bx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 21:53:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:44226 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfJ3Bx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 21:53:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x9U1rieG014755;
        Tue, 29 Oct 2019 20:53:45 -0500
Message-ID: <9ed07f451759bb3400e5456af09874161b204acd.camel@kernel.crashing.org>
Subject: Re: [PATCH] net: ethernet: ftgmac100: Fix DMA coherency issue with
 SW checksum
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        vijaykhemka@fb.com, openbmc@lists.ozlabs.org, joel@jms.id.au,
        linux-aspeed@lists.ozlabs.org
Date:   Wed, 30 Oct 2019 12:53:43 +1100
In-Reply-To: <20191028.162410.844978847156294593.davem@davemloft.net>
References: <572a7d510ace5e5a5ba41c4774d330133291c82a.camel@kernel.crashing.org>
         <20191028.162410.844978847156294593.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-28 at 16:24 -0700, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Fri, 25 Oct 2019 13:47:24 +1100
> 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Fixes: 05690d633f30 ftgmac100: Upgrade to NETIF_F_HW_CSUM
> 
> Please put the commit header string inside double quotes and
> parenthesis
> (" ")

Will do next time, I had just copy/pasted the git shortlog :-)

> > CC: stable@vger.kernel.org [v4.12+]
> 
> Do not CC: stable for networking submissions as per the netdev FAQ.

Ah oops, learned.

> All fixed up, and queued up for -stable, thanks Ben.

Thanks.

Cheers,
Ben.


