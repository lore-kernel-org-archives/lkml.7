Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A5DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 00:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D439622318
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 00:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfKSArP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 19:47:15 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:51764 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfKSArP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 19:47:15 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9CA53150F7646;
        Mon, 18 Nov 2019 16:47:14 -0800 (PST)
Date:   Mon, 18 Nov 2019 16:47:12 -0800 (PST)
Message-Id: <20191118.164712.488135429319455452.davem@davemloft.net>
To:     tdavies@darkphysics.net
Cc:     akpm@linux-foundation.org, julia.lawall@lip6.fr,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] net: Fix comment block per style guide
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191118220609.GA23999@Cheese>
References: <20191118220609.GA23999@Cheese>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 18 Nov 2019 16:47:14 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Travis Davies <tdavies@darkphysics.net>
Date: Mon, 18 Nov 2019 14:06:09 -0800

> This patch places /* and */ on separate lines for a
> multiline block comment, in order to keep code style
> consistant with majority of blocks throughout the file.
> 
> This will prevent a checkpatch.pl warning:
> 'Block comments use a trailing */ on a separate line'
> 
> Signed-off-by: Travis Davies <tdavies@darkphysics.net>
> ---
> -v2: Fix commit description, and subject line as suggested by 
>      Julie Lawall

The comment style used here is so pervasive in the kernel networking,
I'm really not thrilled to start seeing these picked away one by
one.  So much churn...

Sorry I'm not applying this...

