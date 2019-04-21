Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC2AC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 03:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FD4218A1
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 03:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfDUD3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 23:29:23 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55982 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDUD3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 23:29:23 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D810D1034AEF0;
        Sat, 20 Apr 2019 20:29:22 -0700 (PDT)
Date:   Sat, 20 Apr 2019 20:29:20 -0700 (PDT)
Message-Id: <20190420.202920.2293248605361106810.davem@davemloft.net>
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
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 20 Apr 2019 20:29:23 -0700 (PDT)
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

Applied, thanks.
