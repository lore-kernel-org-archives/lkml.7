Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4C0C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D1E217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfDKCPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 22:15:48 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50756 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfDKCPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 22:15:47 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 14E7414C7F10F;
        Wed, 10 Apr 2019 19:15:47 -0700 (PDT)
Date:   Wed, 10 Apr 2019 19:15:44 -0700 (PDT)
Message-Id: <20190410.191544.1296092837344962963.davem@davemloft.net>
To:     neilb@suse.com
Cc:     linux@roeck-us.net, tgraf@suug.ch, herbert@gondor.apana.org.au,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] rhashtable: use bit_spin_locks to protect hash
 bucket.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <87r2a9xt79.fsf@notabene.neil.brown.name>
References: <155416006521.9540.5662092375167065834.stgit@noble.brown>
        <20190410193418.GA32402@roeck-us.net>
        <87r2a9xt79.fsf@notabene.neil.brown.name>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 10 Apr 2019 19:15:47 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.com>
Date: Thu, 11 Apr 2019 10:48:42 +1000

> I might be able to find a different way forward, but for now I think we
> need to drop this series.

You need to send me an explicit revert of all of the changes then.

Thank you.
