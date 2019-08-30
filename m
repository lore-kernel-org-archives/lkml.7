Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C45C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7CE22CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfH3HND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:13:03 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59598 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfH3HNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:13:02 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::642])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1FC531544E2DD;
        Fri, 30 Aug 2019 00:13:02 -0700 (PDT)
Date:   Fri, 30 Aug 2019 00:13:01 -0700 (PDT)
Message-Id: <20190830.001301.240314079053635859.davem@davemloft.net>
To:     ivecera@redhat.com
Cc:     jiri@resnulli.us, idosch@idosch.org, andrew@lunn.ch,
        horatiu.vultur@microchip.com, alexandre.belloni@bootlin.com,
        UNGLinuxDriver@microchip.com, allan.nielsen@microchip.com,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] net: core: Notify on changes to
 dev->promiscuity.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190830085445.1c28dc02@ceranb>
References: <20190829.230233.287975311556641534.davem@davemloft.net>
        <20190830063624.GN2312@nanopsycho>
        <20190830085445.1c28dc02@ceranb>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 30 Aug 2019 00:13:02 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Vecera <ivecera@redhat.com>
Date: Fri, 30 Aug 2019 08:54:45 +0200

> Promisc is Rx filtering option and should not imply that offloaded
> traffic is trapped to CPU.

Hardware is offloaded based upon an rx filter.

Stop this nonsense.
