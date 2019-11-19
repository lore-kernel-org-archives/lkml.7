Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B0AC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 23:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282D42245F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 23:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfKSXWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 18:22:42 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46472 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbfKSXWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 18:22:38 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6E74B1428DA53;
        Tue, 19 Nov 2019 15:22:38 -0800 (PST)
Date:   Tue, 19 Nov 2019 15:22:38 -0800 (PST)
Message-Id: <20191119.152238.234909279065487800.davem@davemloft.net>
To:     andrea.mayer@uniroma2.it
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        dav.lebrun@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next] seg6: allow local packet processing for SRv6
 End.DT6 behavior
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191118182026.2634-1-andrea.mayer@uniroma2.it>
References: <20191118182026.2634-1-andrea.mayer@uniroma2.it>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 19 Nov 2019 15:22:38 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Mayer <andrea.mayer@uniroma2.it>
Date: Mon, 18 Nov 2019 19:20:26 +0100

> End.DT6 behavior makes use of seg6_lookup_nexthop() function which drops
> all packets that are destined to be locally processed. However, DT* should
> be able to delivery decapsulated packets that are destined to local
> addresses. Function seg6_lookup_nexthop() is also used by DX6, so in order
> to maintain compatibility I created another routing helper function which
> is called seg6_lookup_any_nexthop(). This function is able to take into
> account both packets that have to be processed locally and the ones that
> are destined to be forwarded directly to another machine. Hence,
> seg6_lookup_any_nexthop() is used in DT6 rather than seg6_lookup_nexthop()
> to allow local delivery.
> 
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>

Please address Sergei's feedback and resubmit, thank you.
