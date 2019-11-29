Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BA8C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 20:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03E32075C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 20:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfK2Ulu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 15:41:50 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:34054 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfK2Ulu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 15:41:50 -0500
Received: from localhost (c-73-35-209-67.hsd1.wa.comcast.net [73.35.209.67])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7A33114051729;
        Fri, 29 Nov 2019 12:41:49 -0800 (PST)
Date:   Fri, 29 Nov 2019 12:30:31 -0800 (PST)
Message-Id: <20191129.123031.1495258469954154946.davem@davemloft.net>
To:     cascardo@canonical.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        sbrivio@redhat.com
Subject: Re: [PATCH] selftests: pmtu: use -oneline for ip route list cache
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191128185806.23706-1-cascardo@canonical.com>
References: <20191128185806.23706-1-cascardo@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 29 Nov 2019 12:41:49 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Date: Thu, 28 Nov 2019 15:58:06 -0300

> Some versions of iproute2 will output more than one line per entry, which
> will cause the test to fail, like:
> 
> TEST: ipv6: list and flush cached exceptions                        [FAIL]
>   can't list cached exceptions
> 
> That happens, for example, with iproute2 4.15.0. When using the -oneline
> option, this will work just fine:
> 
> TEST: ipv6: list and flush cached exceptions                        [ OK ]
> 
> This also works just fine with a more recent version of iproute2, like
> 5.4.0.
> 
> For some reason, two lines are printed for the IPv4 test no matter what
> version of iproute2 is used. Use the same -oneline parameter there instead
> of counting the lines twice.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

Applied with Fixes: tag added and queued up for -stable.

Thanks.
