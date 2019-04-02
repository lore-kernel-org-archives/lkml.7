Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CFEC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 01:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5FE2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 01:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfDBBMx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 21:12:53 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:41144 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfDBBMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 21:12:53 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 58546133E9763;
        Mon,  1 Apr 2019 18:12:52 -0700 (PDT)
Date:   Mon, 01 Apr 2019 18:12:51 -0700 (PDT)
Message-Id: <20190401.181251.2216822645358665751.davem@davemloft.net>
To:     hujunwei4@huawei.com
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingfangsen@huawei.com, liuzhiqiang26@huawei.com,
        zhangwenhao8@huawei.com, wangxiaogang3@huawei.com
Subject: Re: [PATCH v2 net] ipv6: Fix dangling pointer when ipv6 fragment
From:   David Miller <davem@davemloft.net>
In-Reply-To: <9104f44b-2ce0-7be9-2fca-8b6c12abbb86@huawei.com>
References: <cbbedd1f-3e99-85f7-86d7-d02a86d59c29@huawei.com>
        <9104f44b-2ce0-7be9-2fca-8b6c12abbb86@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 01 Apr 2019 18:12:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: hujunwei <hujunwei4@huawei.com>
Date: Sun, 31 Mar 2019 17:04:29 +0800

> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index edbd12067170..e51f3c648b09 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -601,7 +601,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
>                  inet6_sk(skb->sk) : NULL;
>      struct ipv6hdr *tmp_hdr;
>      struct frag_hdr *fh;
> -    unsigned int mtu, hlen, left, len;

Your patch was corrupted by your email client.

Please fix this, email a test patch to yourself, and only when you can
successfully apply that test patch should you repost this to the mailing
list.

Thank you.
