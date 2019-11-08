Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F48FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2E420656
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390522AbfKHTVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:21:41 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36558 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732277AbfKHTVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:21:39 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 89E451539AF1E;
        Fri,  8 Nov 2019 11:21:38 -0800 (PST)
Date:   Fri, 08 Nov 2019 11:21:38 -0800 (PST)
Message-Id: <20191108.112138.629818881403847512.davem@davemloft.net>
To:     alexandre.torgue@st.com
Cc:     christophe.roullier@st.com, robh@kernel.org, joabreu@synopsys.com,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
        peppe.cavallaro@st.com, linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        andrew@lunn.ch
Subject: Re: [PATCH V4 net-next 0/4] net: ethernet: stmmac: cleanup clock
 and optimization
From:   David Miller <davem@davemloft.net>
In-Reply-To: <8c4efcce-b46f-ac94-a367-50ff5d78c8a2@st.com>
References: <20191107084757.17910-1-christophe.roullier@st.com>
        <20191107.152640.1457462659040029467.davem@davemloft.net>
        <8c4efcce-b46f-ac94-a367-50ff5d78c8a2@st.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 08 Nov 2019 11:21:39 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Torgue <alexandre.torgue@st.com>
Date: Fri, 8 Nov 2019 11:35:23 +0100

> Hi David
> 
> On 11/8/19 12:26 AM, David Miller wrote:
>> From: Christophe Roullier <christophe.roullier@st.com>
>> Date: Thu, 7 Nov 2019 09:47:53 +0100
>> 
>>> Some improvements:
>>>   - manage syscfg as optional clock,
>>>   - update slew rate of ETH_MDIO pin,
>>>   - Enable gating of the MAC TX clock during TX low-power mode
>>>
>>> V4: Update with Andrew Lunn remark
>> This is mostly ARM DT updates, which tree should this go through?
>> I don't want to step on toes this time :-)
>> 
> 
> I'll take DT patches in my STM32 tree.

Ok, I took patch #1 into net-next.
