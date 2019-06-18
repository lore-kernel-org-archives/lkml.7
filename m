Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CD0C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D8220B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbfFRRE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 13:04:57 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50146 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729541AbfFRRE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 13:04:57 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C36E8150AFBD5;
        Tue, 18 Jun 2019 10:04:56 -0700 (PDT)
Date:   Tue, 18 Jun 2019 10:04:56 -0700 (PDT)
Message-Id: <20190618.100456.509667574835376076.davem@davemloft.net>
To:     houjingyi647@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: remove duplicate fetch in sock_getsockopt
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190617065605.GA5924@hjy-HP-Notebook>
References: <20190617065605.GA5924@hjy-HP-Notebook>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 18 Jun 2019 10:04:56 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: JingYi Hou <houjingyi647@gmail.com>
Date: Mon, 17 Jun 2019 14:56:05 +0800

> In sock_getsockopt(), 'optlen' is fetched the first time from userspace.
> 'len < 0' is then checked. Then in condition 'SO_MEMINFO', 'optlen' is
> fetched the second time from userspace.
> 
> If change it between two fetches may cause security problems or unexpected
> behaivor, and there is no reason to fetch it a second time.
> 
> To fix this, we need to remove the second fetch.
> 
> Signed-off-by: JingYi Hou <houjingyi647@gmail.com>

Applied and queued up for -stable, thanks.
