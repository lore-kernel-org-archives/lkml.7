Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF54C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C28222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbfJDVNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 17:13:12 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59102 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfJDVNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 17:13:12 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5A2B314F0E356;
        Fri,  4 Oct 2019 14:13:11 -0700 (PDT)
Date:   Fri, 04 Oct 2019 14:13:10 -0700 (PDT)
Message-Id: <20191004.141310.289047091310558678.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        linux-kernel@vger.kernel.org, hkallweit1@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        manasa.mudireddy@broadcom.com, ray.jui@broadcom.com,
        olteanv@gmail.com, rafal@milecki.pl
Subject: Re: [PATCH 0/2] net: phy: broadcom: RGMII delays fixes
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191003184352.24356-1-f.fainelli@gmail.com>
References: <20191003184352.24356-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 04 Oct 2019 14:13:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu,  3 Oct 2019 11:43:50 -0700

> This patch series fixes the BCM54210E RGMII delay configuration which
> could only have worked in a PHY_INTERFACE_MODE_RGMII configuration.
> There is a forward declaration added such that the first patch can be
> picked up for -stable and apply fine all the way back to when the bug
> was introduced.
> 
> The second patch eliminates duplicated code that used a different kind
> of logic and did not use existing constants defined.

Based upon the discussion with Andrew, I am applying this to net-next.

Thanks.
