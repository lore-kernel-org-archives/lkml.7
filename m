Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2AAC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 23:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9E320830
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 23:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfFEX5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 19:57:50 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42522 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfFEX5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 19:57:50 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AFB03136E16AB;
        Wed,  5 Jun 2019 16:57:49 -0700 (PDT)
Date:   Wed, 05 Jun 2019 16:57:49 -0700 (PDT)
Message-Id: <20190605.165749.2259729983869090689.davem@davemloft.net>
To:     info@metux.net
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net: socket: drop unneeded likely() call around
 IS_ERR()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1559768330-15678-1-git-send-email-info@metux.net>
References: <1559768330-15678-1-git-send-email-info@metux.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 05 Jun 2019 16:57:49 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Date: Wed,  5 Jun 2019 22:58:50 +0200

> From: Enrico Weigelt <info@metux.net>
> 
> IS_ERR() already calls unlikely(), so this extra likely() call
> around the !IS_ERR() is not needed.
> 
> Signed-off-by: Enrico Weigelt <info@metux.net>

Applied.
