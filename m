Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D63C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E73207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfCJSCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:02:32 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:58034 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbfCJSCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:02:32 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8DD1114769053;
        Sun, 10 Mar 2019 11:02:31 -0700 (PDT)
Date:   Sun, 10 Mar 2019 11:02:31 -0700 (PDT)
Message-Id: <20190310.110231.436843080539934421.davem@davemloft.net>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, dchickles@marvell.com, sburla@marvell.com,
        fmanlunas@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: liquidio: fix a NULL pointer dereference
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190310081915.7024-1-kjlu@umn.edu>
References: <20190310081915.7024-1-kjlu@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 10 Mar 2019 11:02:31 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>
Date: Sun, 10 Mar 2019 03:19:15 -0500

> +		netif_info(lio, rx_err, lio->netdev,
> +				"Failed to allocate octeon_soft_command\n");

When a function call straddles mutliple lines, the second and subsequent lines
containing argument must start precisely at the first column after the openning
parenthesis of the first line.

You must use the appropriate number of TAB and SPACE characters necessary to
achieve this.
