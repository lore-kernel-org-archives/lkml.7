Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549ECC5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3272F2173E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfGBCFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:05:09 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53828 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfGBCFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:05:09 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9F94514DE97A1;
        Mon,  1 Jul 2019 19:05:08 -0700 (PDT)
Date:   Mon, 01 Jul 2019 19:05:08 -0700 (PDT)
Message-Id: <20190701.190508.1610025995462719506.davem@davemloft.net>
To:     devel@etsukata.com
Cc:     edumazet@google.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/ipv6: Fix misuse of proc_dointvec
 "flowlabel_reflect"
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190628023714.1923-1-devel@etsukata.com>
References: <20190628023714.1923-1-devel@etsukata.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 01 Jul 2019 19:05:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eiichi Tsukata <devel@etsukata.com>
Date: Fri, 28 Jun 2019 11:37:14 +0900

> /proc/sys/net/ipv6/flowlabel_reflect assumes written value to be in the
> range of 0 to 3. Use proc_dointvec_minmax instead of proc_dointvec.
> 
> Fixes: 323a53c41292 ("ipv6: tcp: enable flowlabel reflection in some RST packets")
> Signed-off-by: Eiichi Tsukata <devel@etsukata.com>

Applied, thanks.
