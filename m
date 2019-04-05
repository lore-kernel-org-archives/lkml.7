Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6313BC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3A8217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbfDEAhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:37:15 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55302 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730476AbfDEAhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 20:37:12 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AE71C10AB361A;
        Thu,  4 Apr 2019 17:37:11 -0700 (PDT)
Date:   Thu, 04 Apr 2019 17:37:11 -0700 (PDT)
Message-Id: <20190404.173711.500680276072818802.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        tlfalcon@linux.ibm.com, jallen@linux.ibm.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH -next] ibmvnic: remove set but not used variable
 'netdev'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190403075409.29384-1-yuehaibing@huawei.com>
References: <20190403075409.29384-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 04 Apr 2019 17:37:12 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Haibing <yuehaibing@huawei.com>
Date: Wed, 3 Apr 2019 15:54:09 +0800

> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/net/ethernet/ibm/ibmvnic.c: In function '__ibmvnic_reset':
> drivers/net/ethernet/ibm/ibmvnic.c:1971:21: warning: variable 'netdev' set but not used [-Wunused-but-set-variable]
> 
> It's never used since introduction in
> commit ed651a10875f ("ibmvnic: Updated reset handling")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
