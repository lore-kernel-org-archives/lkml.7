Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF49C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E662084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfCATVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:21:52 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56560 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfCATVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 14:21:51 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C82DE14F6CADA;
        Fri,  1 Mar 2019 11:21:50 -0800 (PST)
Date:   Fri, 01 Mar 2019 11:21:47 -0800 (PST)
Message-Id: <20190301.112147.2157462489082210936.davem@davemloft.net>
To:     claudiu.manoil@nxp.com
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, leoyang.li@nxp.com,
        alexandru.marginean@nxp.com, andrew@lunn.ch,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/4] enetc: Add mdio support and device
 tree nodes
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1551188543-28867-1-git-send-email-claudiu.manoil@nxp.com>
References: <1551188543-28867-1-git-send-email-claudiu.manoil@nxp.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 01 Mar 2019 11:21:51 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Manoil <claudiu.manoil@nxp.com>
Date: Tue, 26 Feb 2019 15:42:19 +0200

> This is the missing part to enable PCI probing of the ENETC ethernet
> ports on the LS1028A SoC and external traffic on the LS1028A RDB board.
> It's one of the first items on the TODO list for the recently merged
> ENETC ethernet driver.
> 
> v3: Add DT bindings doc for ENETC connections
> v4: none

Series applied, thank you.
