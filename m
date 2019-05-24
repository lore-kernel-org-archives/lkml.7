Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFBEC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 20:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75D62133D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 20:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404063AbfEXUQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 16:16:52 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42590 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391739AbfEXUQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 16:16:52 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6363514DE103B;
        Fri, 24 May 2019 13:16:51 -0700 (PDT)
Date:   Fri, 24 May 2019 13:16:50 -0700 (PDT)
Message-Id: <20190524.131650.1001639096871571503.davem@davemloft.net>
To:     yangbo.lu@nxp.com
Cc:     netdev@vger.kernel.org, richardcochran@gmail.com,
        claudiu.manoil@nxp.com, shawnguo@kernel.org, robh+dt@kernel.org,
        alexandru.marginean@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2, 0/4] ENETC: support hardware timestamping
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190523023451.2933-1-yangbo.lu@nxp.com>
References: <20190523023451.2933-1-yangbo.lu@nxp.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 24 May 2019 13:16:51 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Y.b. Lu" <yangbo.lu@nxp.com>
Date: Thu, 23 May 2019 02:33:24 +0000

> This patch-set is to support hardware timestamping for ENETC
> and also to add ENETC 1588 timer device tree node for ls1028a.
> 
> Because the ENETC RX BD ring dynamic allocation has not been
> supported and it is too expensive to use extended RX BDs
> if timestamping is not used, a Kconfig option is used to
> enable extended RX BDs in order to support hardware
> timestamping. This option will be removed once RX BD
> ring dynamic allocation is implemented.

Series applied.
