Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDA1C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 19:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00024218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 19:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfCPTJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 15:09:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43382 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfCPTJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 15:09:37 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 59E9E108569ED;
        Sat, 16 Mar 2019 12:09:35 -0700 (PDT)
Date:   Sat, 16 Mar 2019 12:09:34 -0700 (PDT)
Message-Id: <20190316.120934.948765192267523842.davem@davemloft.net>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, jon.maloy@ericsson.com, ying.xue@windriver.com,
        netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: tipc: fix a missing check of nla_nest_start
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190315171200.5269-1-kjlu@umn.edu>
References: <1d97622a-6404-6600-c06b-9450b225742b@cogentembedded.com>
        <20190315171200.5269-1-kjlu@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 16 Mar 2019 12:09:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>
Date: Fri, 15 Mar 2019 12:11:59 -0500

> nla_nest_start could fail and requires a check. The fix returns
> -EMSGSIZE if it fails.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Applied.
