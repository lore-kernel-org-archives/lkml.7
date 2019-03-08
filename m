Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00941C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 23:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87FD20684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 23:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfCHXZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 18:25:46 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:41490 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfCHXZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 18:25:45 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 034C01479C97C;
        Fri,  8 Mar 2019 15:25:44 -0800 (PST)
Date:   Fri, 08 Mar 2019 15:25:44 -0800 (PST)
Message-Id: <20190308.152544.1392696861540820759.davem@davemloft.net>
To:     brodie.greenfield@alliedtelesis.co.nz
Cc:     stephen@networkplumber.org, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
        luuk.paulussen@alliedtelesis.co.nz
Subject: Re: [PATCH 0/2] Make ipmr queue length configurable
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190307045729.14972-1-brodie.greenfield@alliedtelesis.co.nz>
References: <20190307045729.14972-1-brodie.greenfield@alliedtelesis.co.nz>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 08 Mar 2019 15:25:45 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brodie Greenfield <brodie.greenfield@alliedtelesis.co.nz>
Date: Thu,  7 Mar 2019 17:57:27 +1300

> We want to have some more space in our queue for processing incoming
> multicast packets, so we can process more of them without dropping
> them prematurely. It is useful to be able to increase this limit on
> higher-spec platforms that can handle more items.
> 
> For the particular use case here at Allied Telesis, we have linux
> running on our switches and routers, with support for the number of
> multicast groups being increased. Basically, this queue length affects
> the time taken to fully learn all of the multicast streams. 
> 
> Changes in v3:
>  - Corrected a v4 to v6 typo.

This is a new feature, and therefore net-next material.  The net-next
tree is closed, please resubmit when it opens back up.
