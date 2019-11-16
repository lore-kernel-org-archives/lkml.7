Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1337BC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 20:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D901D20740
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 20:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfKPUS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 15:18:56 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:53248 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfKPUS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 15:18:56 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AC79015172247;
        Sat, 16 Nov 2019 12:18:55 -0800 (PST)
Date:   Sat, 16 Nov 2019 12:18:55 -0800 (PST)
Message-Id: <20191116.121855.39087339208287206.davem@davemloft.net>
To:     andrea.mayer@uniroma2.it
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        dav.lebrun@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net, 0/2] seg6: fixes to Segment Routing in IPv6
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191116150553.17497-1-andrea.mayer@uniroma2.it>
References: <20191116150553.17497-1-andrea.mayer@uniroma2.it>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 16 Nov 2019 12:18:55 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Mayer <andrea.mayer@uniroma2.it>
Date: Sat, 16 Nov 2019 16:05:51 +0100

> This patchset is divided in 2 patches and it introduces some fixes
> to Segment Routing in IPv6, which are:
> 
> - in function get_srh() fix the srh pointer after calling
>   pskb_may_pull();
> 
> - fix the skb->transport_header after calling decap_and_validate()
>   function;
> 
> Any comments on the patchset are welcome.

Series applied and queued up for -stable, thanks.
