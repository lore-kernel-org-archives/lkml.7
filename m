Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37E7C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 19:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C43A21835
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 19:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfLGTwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 14:52:40 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42752 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbfLGTwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 14:52:39 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3F27615420D23;
        Sat,  7 Dec 2019 11:52:39 -0800 (PST)
Date:   Sat, 07 Dec 2019 11:52:38 -0800 (PST)
Message-Id: <20191207.115238.784174182997766329.davem@davemloft.net>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, mostrows@earthlink.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pppoe: remove redundant BUG_ON() check in pppoe_pernet
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191205230450.8614-1-pakki001@umn.edu>
References: <20191205230450.8614-1-pakki001@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 07 Dec 2019 11:52:39 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>
Date: Thu,  5 Dec 2019 17:04:49 -0600

> Passing NULL to pppoe_pernet causes a crash via BUG_ON.
> Dereferencing net in net_generici() also has the same effect. This patch
> removes the redundant BUG_ON check on the same parameter.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Applied.
