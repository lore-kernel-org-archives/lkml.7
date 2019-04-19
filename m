Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F190EC282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CA221736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfDSVkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:40:08 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35656 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfDSVkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 17:40:08 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 83BA614DAB8B0;
        Fri, 19 Apr 2019 14:40:07 -0700 (PDT)
Date:   Fri, 19 Apr 2019 14:40:06 -0700 (PDT)
Message-Id: <20190419.144006.2099381369535226239.davem@davemloft.net>
To:     po-hsu.lin@canonical.com
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/net: correct the return value for
 run_afpackettests
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190419110113.21883-1-po-hsu.lin@canonical.com>
References: <20190419110113.21883-1-po-hsu.lin@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 19 Apr 2019 14:40:07 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Fri, 19 Apr 2019 19:01:13 +0800

> The run_afpackettests will be marked as passed regardless the return
> value of those sub-tests in the script:
>     --------------------
>     running psock_tpacket test
>     --------------------
>     [FAIL]
>     selftests: run_afpackettests [PASS]
> 
> Fix this by changing the return value for each tests.
> 
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>

Applied, thank you.
