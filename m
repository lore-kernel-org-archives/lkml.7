Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E343C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79878208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbfDXSpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:45:49 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:32888 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbfDXSpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:45:49 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3ECA614882B90;
        Wed, 24 Apr 2019 11:45:48 -0700 (PDT)
Date:   Wed, 24 Apr 2019 11:45:45 -0700 (PDT)
Message-Id: <20190424.114545.1491189947661702492.davem@davemloft.net>
To:     linmiaohe@huawei.com
Cc:     dsa@cumulusnetworks.com, shrijeet@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingfangsen@huawei.com
Subject: Re: [PATCH] net: vrf: Fix operation not supported when set vrf mac
From:   David Miller <davem@davemloft.net>
In-Reply-To: <4e8a50df-bf96-3ef7-2977-71495d80643c@huawei.com>
References: <4e8a50df-bf96-3ef7-2977-71495d80643c@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 24 Apr 2019 11:45:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: linmiaohe <linmiaohe@huawei.com>
Date: Sat, 20 Apr 2019 12:09:39 +0800

> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> Vrf device is not able to change mac address now because lack of
> ndo_set_mac_address. Complete this in case some apps need to do
> this.
> 
> Reported-by: Hui Wang <wanghui104@huawei.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

It seems useless, but this change is pretty much harmless so I'll
apply it.

Thanks.
