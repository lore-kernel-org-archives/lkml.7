Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D954EC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B380821850
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbfGXW0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 18:26:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52772 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbfGXW00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:26:26 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 742691543BD0E;
        Wed, 24 Jul 2019 15:26:25 -0700 (PDT)
Date:   Wed, 24 Jul 2019 15:26:12 -0700 (PDT)
Message-Id: <20190724.152612.864896276004624257.davem@davemloft.net>
To:     schwab@suse.de
Cc:     netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: mscc: initialize stats array
From:   David Miller <davem@davemloft.net>
In-Reply-To: <mvmh87bih1y.fsf@suse.de>
References: <mvmh87bih1y.fsf@suse.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 24 Jul 2019 15:26:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Schwab <schwab@suse.de>
Date: Wed, 24 Jul 2019 17:32:57 +0200

> The memory allocated for the stats array may contain arbitrary data.
> 
> Signed-off-by: Andreas Schwab <schwab@suse.de>

Applied and queued up for -stable.
