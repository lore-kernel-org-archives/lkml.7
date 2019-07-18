Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6230AC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42AA121019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391171AbfGRTIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:08:31 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54356 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391028AbfGRTIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:08:30 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 306741527DFBA;
        Thu, 18 Jul 2019 12:08:30 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:08:29 -0700 (PDT)
Message-Id: <20190718.120829.1693127632426510179.davem@davemloft.net>
To:     yanhaishuang@cmss.chinamobile.com
Cc:     pshelar@ovn.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] openvswitch: Fix a possible memory leak on dst_cache
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1563466028-2531-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
References: <1563466028-2531-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 18 Jul 2019 12:08:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Date: Fri, 19 Jul 2019 00:07:08 +0800

> dst_cache should be destroyed when fail to add flow actions.
> 
> Fixes: d71785ffc7e7 ("net: add dst_cache to ovs vxlan lwtunnel")
> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

OVS folks, please review.
