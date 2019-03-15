Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93A2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FCD21871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfCOSyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 14:54:13 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60462 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfCOSyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 14:54:12 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1526614D9FA65;
        Fri, 15 Mar 2019 11:54:12 -0700 (PDT)
Date:   Fri, 15 Mar 2019 11:54:11 -0700 (PDT)
Message-Id: <20190315.115411.1313963626415405289.davem@davemloft.net>
To:     jeremy@azazel.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vti4: ipip tunnel deregistration fixes.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190314161333.6550-1-jeremy@azazel.net>
References: <20190314161333.6550-1-jeremy@azazel.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 15 Mar 2019 11:54:12 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Sowden <jeremy@azazel.net>
Date: Thu, 14 Mar 2019 16:13:33 +0000

> If tunnel registration failed during module initialization, the module
> would fail to deregister the IPPROTO_COMP protocol and would attempt to
> deregister the tunnel.
> 
> The tunnel was not deregistered during module-exit.
> 
> Fixes: d9ee3444014e ("vti4: Fix a ipip packet processing bug in 'IPCOMP' virtual tunnel")
> Signed-off-by: Jeremy Sowden <jeremy@azazel.net>

Please resubmit and properly CC: the IPSEC maintainer (as per
MAINTAINERS) on all of your vti changes.

Thank you.
