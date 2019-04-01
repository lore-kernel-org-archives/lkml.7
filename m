Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776EEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0372084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbfDAGB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 02:01:27 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50232 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731160AbfDAGB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 02:01:26 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0F09414F6F6D0;
        Sun, 31 Mar 2019 23:01:26 -0700 (PDT)
Date:   Sun, 31 Mar 2019 23:01:23 -0700 (PDT)
Message-Id: <20190331.230123.1312457672309077256.davem@davemloft.net>
To:     lifonghsu@synology.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: net: fix routing encapsulated packets when binding a socket to
 a tunnel interface
From:   David Miller <davem@davemloft.net>
In-Reply-To: <e87a85a8c91d96951c4fa923d1563dcd@synology.com>
References: <6143cbeaab4f37bc2314caa3690063d4@synology.com>
        <20190329.104026.2135814725468775566.davem@davemloft.net>
        <e87a85a8c91d96951c4fa923d1563dcd@synology.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 31 Mar 2019 23:01:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lifonghsu <lifonghsu@synology.com>
Date: Mon, 01 Apr 2019 11:00:22 +0800

> Since we are not sure whether there is any code referring to the
> value of skb_iff in transmit site or not, it is risky to set an
> invalid interface

If you are no confident in how the value is used on TX, then I can't
consider your change with confidence either.

Think about what you are saying to me here.  You basically do not know
whether you are adding a bug or not.
