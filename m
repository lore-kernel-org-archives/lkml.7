Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F70C606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 21:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3700216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 21:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405263AbfGHVPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 17:15:22 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:58494 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbfGHVPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 17:15:21 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A7B14136DDD39;
        Mon,  8 Jul 2019 14:15:19 -0700 (PDT)
Date:   Mon, 08 Jul 2019 14:15:15 -0700 (PDT)
Message-Id: <20190708.141515.1767939731073284700.davem@davemloft.net>
To:     Jose.Abreu@synopsys.com
Cc:     ilias.apalodimas@linaro.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, Joao.Pinto@synopsys.com,
        peppe.cavallaro@st.com, alexandre.torgue@st.com, brouer@redhat.com,
        arnd@arndb.de
Subject: Re: [PATCH net-next v3 3/3] net: stmmac: Introducing support for
 Page Pool
From:   David Miller <davem@davemloft.net>
In-Reply-To: <BN8PR12MB32667BCA58B617432CACE677D3F60@BN8PR12MB3266.namprd12.prod.outlook.com>
References: <BN8PR12MB32666359FABD7D7E55FE4761D3F50@BN8PR12MB3266.namprd12.prod.outlook.com>
        <20190705152453.GA24683@apalos>
        <BN8PR12MB32667BCA58B617432CACE677D3F60@BN8PR12MB3266.namprd12.prod.outlook.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 08 Jul 2019 14:15:20 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>
Date: Mon, 8 Jul 2019 16:08:07 +0000

> From: Ilias Apalodimas <ilias.apalodimas@linaro.org> | Date: Fri, Jul 
> 05, 2019 at 16:24:53
> 
>> Well ideally we'd like to get the change in before the merge window ourselves,
>> since we dont want to remove->re-add the same function in stable kernels. If
>> that doesn't go in i am fine fixing it in the next merge window i guess, since
>> it offers substantial speedups
> 
> I think the series is marked as "Changes Requested" in patchwork. What's 
> the status of this ?

That means I expect a respin based upon feedback or similar.  If Ilias and
you agreed to put this series in as-is, my apologies and just resend the
series with appropriate ACK and Review tags added.

Thanks.
