Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC5BC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9050F21850
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfGCUx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:53:29 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34790 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfGCUx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:53:29 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BBD2F144B3812;
        Wed,  3 Jul 2019 13:53:28 -0700 (PDT)
Date:   Wed, 03 Jul 2019 13:53:28 -0700 (PDT)
Message-Id: <20190703.135328.756462803106168925.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     csully@google.com, sagis@google.com, jonolson@google.com,
        willemb@google.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] gve: fix -ENOMEM null check on a page allocation
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190703165037.3041-1-colin.king@canonical.com>
References: <20190703165037.3041-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 03 Jul 2019 13:53:29 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Wed,  3 Jul 2019 17:50:37 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the check to see if a page is allocated is incorrect
> and is checking if the pointer page is null, not *page as
> intended.  Fix this.
> 
> Addresses-Coverity: ("Dereference before null check")
> Fixes: f5cedc84a30d ("gve: Add transmit and receive support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
