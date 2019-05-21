Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB24AC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB329217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfEUUVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 16:21:38 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44736 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfEUUVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 16:21:38 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BEE1714C7E03D;
        Tue, 21 May 2019 13:21:37 -0700 (PDT)
Date:   Tue, 21 May 2019 13:21:37 -0700 (PDT)
Message-Id: <20190521.132137.1951087110443628106.davem@davemloft.net>
To:     standby24x7@gmail.com
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net-next: net: Fix typos in ip-sysctl.txt
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190521034115.18896-1-standby24x7@gmail.com>
References: <20190521034115.18896-1-standby24x7@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 21 May 2019 13:21:38 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masanari Iida <standby24x7@gmail.com>
Date: Tue, 21 May 2019 12:41:15 +0900

> This patch fixes some spelling typos found in ip-sysctl.txt
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Documentation typos and fixes are always reasonable for 'net' and
therefore that's where I have applied this.

Thanks.
