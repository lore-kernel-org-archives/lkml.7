Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84708C32771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 02:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591EA20715
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 02:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbgAGCXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 21:23:03 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57152 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbgAGCXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 21:23:03 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 06F32159E228D;
        Mon,  6 Jan 2020 18:23:01 -0800 (PST)
Date:   Mon, 06 Jan 2020 18:22:59 -0800 (PST)
Message-Id: <20200106.182259.1907306689510314367.davem@davemloft.net>
To:     Jiping.Ma2@windriver.com
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stmmac: debugfs entry name is not be changed when udev
 rename device name.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <15aedd71-e077-4c6c-e30c-9396d16eaeec@windriver.com>
References: <20200106023341.206459-1-jiping.ma2@windriver.com>
        <20200106.134557.2214546621758238890.davem@redhat.com>
        <15aedd71-e077-4c6c-e30c-9396d16eaeec@windriver.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 06 Jan 2020 18:23:02 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiping Ma <Jiping.Ma2@windriver.com>
Date: Tue, 7 Jan 2020 09:00:53 +0800

> 
> 
> On 01/07/2020 05:45 AM, David Miller wrote:
>> From: Jiping Ma <jiping.ma2@windriver.com>
>> Date: Mon, 6 Jan 2020 10:33:41 +0800
>>
>>> Add one notifier for udev changes net device name.
>>>
>>> Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
>> This doesn't apply to 'net' and since this is a bug fix that is where
>> you should target this change.
> What's the next step that I can do?

Respin your patch against the net GIT tree so that it applies clean.y
