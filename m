Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B632CA9EC8
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9A121D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503771AbfJRABv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:01:51 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44012 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441828AbfJRABu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:01:50 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4026E1433FC59;
        Thu, 17 Oct 2019 17:01:50 -0700 (PDT)
Date:   Thu, 17 Oct 2019 17:01:49 -0700 (PDT)
Message-Id: <20191017.170149.2131317490793787816.davem@davemloft.net>
To:     sean.wang@mediatek.com
Cc:     john@phrozen.org, nbd@openwrt.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Mark-MC.Lee@mediatek.com
Subject: Re: [PATCH net-next] net: Update address for MediaTek ethernet
 driver in MAINTAINERS
From:   David Miller <davem@davemloft.net>
In-Reply-To: <fc0692002216a32b045a69f910e95c83c1ff559c.1571260085.git.sean.wang@mediatek.com>
References: <fc0692002216a32b045a69f910e95c83c1ff559c.1571260085.git.sean.wang@mediatek.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 17 Oct 2019 17:01:50 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: <sean.wang@mediatek.com>
Date: Thu, 17 Oct 2019 05:14:08 +0800

> From: Sean Wang <sean.wang@mediatek.com>
> 
> Update maintainers for MediaTek ethernet driver with Mark Lee.
> He is familiar with MediaTek mt762x series ethernet devices and
> will keep following maintenance from the vendor side.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Mark Lee <Mark-MC.Lee@mediatek.com>

Applied to 'net', thank you.
