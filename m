Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637CBC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B49D214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbfDRGXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:23:47 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35548 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfDRGXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:23:46 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 43328103CB429;
        Wed, 17 Apr 2019 23:23:46 -0700 (PDT)
Date:   Wed, 17 Apr 2019 23:23:45 -0700 (PDT)
Message-Id: <20190417.232345.804591663113893969.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     john.hurley@netronome.com, oss-drivers@netronome.com,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfp: abm: fix spelling mistake "offseting" ->
 "offsetting"
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190417131500.4793-1-colin.king@canonical.com>
References: <20190417131500.4793-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 17 Apr 2019 23:23:46 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Wed, 17 Apr 2019 14:15:00 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> There are a couple of spelling mistakes in NL_SET_ERR_MSG_MOD error
> messages. Fix these.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
