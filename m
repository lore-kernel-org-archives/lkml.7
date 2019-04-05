Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6ECC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEA8217D6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbfDEAhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:37:09 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55280 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730476AbfDEAhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 20:37:07 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D3F5D14737C75;
        Thu,  4 Apr 2019 17:37:06 -0700 (PDT)
Date:   Thu, 04 Apr 2019 17:37:06 -0700 (PDT)
Message-Id: <20190404.173706.1182625110292398764.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     dougmill@linux.ibm.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH -next] ehea: remove set but not used variables 'epa'
 and 'cq_handle_ref'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190403075208.30000-1-yuehaibing@huawei.com>
References: <20190403075208.30000-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 04 Apr 2019 17:37:07 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Haibing <yuehaibing@huawei.com>
Date: Wed, 3 Apr 2019 15:52:08 +0800

> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/net/ethernet/ibm/ehea/ehea_qmr.c: In function 'ehea_create_cq':
> drivers/net/ethernet/ibm/ehea/ehea_qmr.c:127:7: warning: variable 'cq_handle_ref' set but not used [-Wunused-but-set-variable]
> drivers/net/ethernet/ibm/ehea/ehea_qmr.c:126:15: warning: variable 'epa' set but not used [-Wunused-but-set-variable]
> 
> They are never used since commit
> 7a291083225a ("[PATCH] ehea: IBM eHEA Ethernet Device Driver")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
