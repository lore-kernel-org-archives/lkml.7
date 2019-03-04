Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18036C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 05:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4D120863
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 05:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfCDFF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 00:05:29 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56928 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfCDFF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 00:05:29 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8707D14D0CEE8;
        Sun,  3 Mar 2019 21:05:28 -0800 (PST)
Date:   Sun, 03 Mar 2019 21:05:28 -0800 (PST)
Message-Id: <20190303.210528.1372000300324935473.davem@davemloft.net>
To:     fruggeri@arista.com
Cc:     yoshfuji@linux-ipv6.org, kuznet@ms2.inr.ac.ru, maxim@arista.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net: ipv6: add socket option IPV6_ROUTER_ALERT_ISOLATE
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190301233103.B4EE095C2D16@us180.sjc.aristanetworks.com>
References: <20190301233103.B4EE095C2D16@us180.sjc.aristanetworks.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 03 Mar 2019 21:05:28 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: fruggeri@arista.com (Francesco Ruggeri)
Date: Fri, 01 Mar 2019 15:31:03 -0800

> By default IPv6 socket with IPV6_ROUTER_ALERT socket option set will
> receive all IPv6 RA packets from all namespaces.
> IPV6_ROUTER_ALERT_ISOLATE socket option restricts packets received by
> the socket to be only from the socket's namespace.
> 
> Signed-off-by: Maxim Martynov <maxim@arista.com>
> Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>

Applied to net-next, thanks.
