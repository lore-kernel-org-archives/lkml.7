Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C24C46470
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F7121773
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbfEWQJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 12:09:32 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48098 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730980AbfEWQJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 12:09:31 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D58651509A0E9;
        Thu, 23 May 2019 09:09:30 -0700 (PDT)
Date:   Thu, 23 May 2019 09:09:28 -0700 (PDT)
Message-Id: <20190523.090928.974790678055823460.davem@davemloft.net>
To:     Jose.Abreu@synopsys.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Joao.Pinto@synopsys.com, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, clabbe.montjoie@gmail.com, andrew@lunn.ch
Subject: Re: [PATCH net-next 00/18] net: stmmac: Improvements and Selftests
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1558596599.git.joabreu@synopsys.com>
References: <cover.1558596599.git.joabreu@synopsys.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 23 May 2019 09:09:31 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>
Date: Thu, 23 May 2019 09:36:50 +0200

> [ Thanks to the introducion of selftests this series ended up being a misc
> of improvements and the selftests additions per-se. ]
> 
> This introduces selftests support in stmmac driver. We add 9 basic sanity
> checks and MAC loopback support for all cores within the driver. This way
> more tests can easily be added in the future and can be run in virtually
> any MAC/GMAC/QoS/XGMAC platform.
> 
> Having this we can find regressions and missing features in the driver
> while at the same time we can check if the IP is correctly working.
> 
> We have been using this for some time now and I do have more tests to
> submit in the feature. My experience is that although writing the tests
> adds more development time, the gain results are obvious.
> 
> I let this feature optional within the driver under a Kconfig option.

Series applied.
