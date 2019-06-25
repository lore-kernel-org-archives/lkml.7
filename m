Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03509C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18AE2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbfFYT7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 15:59:22 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50018 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfFYT7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:59:22 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 96697126A2097;
        Tue, 25 Jun 2019 12:59:21 -0700 (PDT)
Date:   Tue, 25 Jun 2019 12:59:21 -0700 (PDT)
Message-Id: <20190625.125921.1977351433337983702.davem@davemloft.net>
To:     devel@etsukata.com
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] net/ipv6: Fix misuse of proc_dointvec
 "skip_notify_on_dev_down"
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190625030801.24538-2-devel@etsukata.com>
References: <20190625030801.24538-1-devel@etsukata.com>
        <20190625030801.24538-2-devel@etsukata.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 25 Jun 2019 12:59:21 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eiichi Tsukata <devel@etsukata.com>
Date: Tue, 25 Jun 2019 12:08:01 +0900

> /proc/sys/net/ipv6/route/skip_notify_on_dev_down assumes given value to be
> 0 or 1. Use proc_dointvec_minmax instead of proc_dointvec.
> 
> Fixes: 7c6bb7d2faaf ("net/ipv6: Add knob to skip DELROUTE message ondevice down")
> Signed-off-by: Eiichi Tsukata <devel@etsukata.com>

Applied.
