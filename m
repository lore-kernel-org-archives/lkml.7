Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60238C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 22:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273CD21872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 22:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfCOWnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 18:43:14 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34604 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfCOWnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 18:43:14 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2E215140F4D21;
        Fri, 15 Mar 2019 15:43:13 -0700 (PDT)
Date:   Fri, 15 Mar 2019 15:43:12 -0700 (PDT)
Message-Id: <20190315.154312.1385290059739603082.davem@davemloft.net>
To:     jose.abreu@synopsys.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, f.fainelli@gmail.com, joao.pinto@synopsys.com,
        hkallweit1@gmail.com
Subject: Re: [PATCH net] net: phy: Don't assume loopback is supported
From:   David Miller <davem@davemloft.net>
In-Reply-To: <eeea080649153eefafef8ff93274733fe8f25b01.1552559796.git.joabreu@synopsys.com>
References: <eeea080649153eefafef8ff93274733fe8f25b01.1552559796.git.joabreu@synopsys.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 15 Mar 2019 15:43:13 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <jose.abreu@synopsys.com>
Date: Thu, 14 Mar 2019 11:37:21 +0100

> Some PHYs may not support loopback mode so we need to check if register
> is read-only.
> 
> Fixes: f0f9b4ed2338 ("net: phy: Add phy loopback support in net phy framework")
> Signed-off-by: Jose Abreu <joabreu@synopsys.com>

Andrew et al., please review.
