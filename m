Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9175FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 01:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6677A2133F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 01:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfCXBtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 21:49:20 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35268 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbfCXBtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 21:49:19 -0400
Received: from localhost (unknown [50.233.106.125])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6222014B47A75;
        Sat, 23 Mar 2019 18:49:19 -0700 (PDT)
Date:   Sat, 23 Mar 2019 21:49:19 -0400 (EDT)
Message-Id: <20190323.214919.206895281212558990.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     dhowells@redhat.com, clang-built-linux@googlegroups.com,
        ndesaulniers@google.com, natechancellor@gmail.com,
        yuehaibing@huawei.com, linux-afs@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rxrpc: avoid clang -Wuninitialized warning
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190322141848.659387-1-arnd@arndb.de>
References: <20190322141848.659387-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 23 Mar 2019 18:49:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 22 Mar 2019 15:18:43 +0100

> clang produces a false-positive warning as it fails to notice
> that "lost = true" implies that "ret" is initialized:
 ...
> Rearrange the code to make that more obvious and avoid the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
