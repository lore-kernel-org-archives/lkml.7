Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94F9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2922077B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfCLVvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:51:32 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54712 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfCLVvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 17:51:32 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9E95114CCE8DA;
        Tue, 12 Mar 2019 14:51:31 -0700 (PDT)
Date:   Tue, 12 Mar 2019 14:51:31 -0700 (PDT)
Message-Id: <20190312.145131.1160021095999433392.davem@davemloft.net>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, sergei.shtylyov@cogentembedded.com,
        vladimir_zapolskiy@mentor.com, geert+renesas@glider.be,
        vladimir.barinov@cogentembedded.com, chris.brandt@renesas.com,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: sh_eth: fix a missing check of of_get_phy_mode
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190312074319.31161-1-kjlu@umn.edu>
References: <902bc3a0-94b5-cf00-6b41-f2724744fbe6@cogentembedded.com>
        <20190312074319.31161-1-kjlu@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 12 Mar 2019 14:51:32 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>
Date: Tue, 12 Mar 2019 02:43:18 -0500

> of_get_phy_mode may fail and return a negative error code;
> the fix checks the return value of of_get_phy_mode and
> returns NULL of it fails.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Applied with Fixes: tag added.
