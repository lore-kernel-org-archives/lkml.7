Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8F8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1230C2183E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfCUUlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:41:46 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53060 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfCUUlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:41:46 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 51A28133E9775;
        Thu, 21 Mar 2019 13:41:45 -0700 (PDT)
Date:   Thu, 21 Mar 2019 13:41:44 -0700 (PDT)
Message-Id: <20190321.134144.761406273634827228.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        linux-kernel@vger.kernel.org, hkallweit1@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        murali.policharla@broadcom.com, arun.parameswaran@broadcom.com
Subject: Re: [PATCH net-next 0/2] net: phy: Move Omega PHY entry to Cygnus
 PHY driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190320195313.15658-1-f.fainelli@gmail.com>
References: <20190320195313.15658-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 21 Mar 2019 13:41:45 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 20 Mar 2019 12:53:11 -0700

> In order to pave the way for adding some specific Omega PHY features
> that may not be desirable on other products covered by the bcm7xxx PHY
> driver, split the Omega PHY entry into the Cygnus PHY driver such that
> the PHY drivers are reflective of product lines/business units
> maintaining them within Broadcom.
> 
> No functional changes intended.

Series applied, thanks Florian.
