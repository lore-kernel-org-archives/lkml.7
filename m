Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60C8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD6920830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfDJTLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:11:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:45474 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfDJTL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:11:27 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 705A714C668E0;
        Wed, 10 Apr 2019 12:11:26 -0700 (PDT)
Date:   Wed, 10 Apr 2019 12:11:25 -0700 (PDT)
Message-Id: <20190410.121125.839541085072412175.davem@davemloft.net>
To:     edumazet@google.com
Cc:     juha-matti.tilli@foreca.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, aquini@redhat.com, xzhou@redhat.com,
        yoyang@redhat.com, jiyin@redhat.com
Subject: Re: [PATCH] net: add big honking pfmemalloc OOM warning
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CANn89iK9DcDi68WQn0z2R65L1fQpa88nUnpe_di1OWGhhoqAQw@mail.gmail.com>
References: <20190410101947.8603-1-juha-matti.tilli@foreca.com>
        <CANn89iK9DcDi68WQn0z2R65L1fQpa88nUnpe_di1OWGhhoqAQw@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 10 Apr 2019 12:11:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Apr 2019 07:16:21 -0700

> SNMP counters are per netns, and more useful in the modern computing
> era,  where a host is shared by many different containers.

+1  There is no way I am applying this patch.

The kernel should not "big honking" anything in the logs.
