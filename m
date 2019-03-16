Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19B7C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE8C218D4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfCPSox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 14:44:53 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43226 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbfCPSow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 14:44:52 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4EE7810856AFA;
        Sat, 16 Mar 2019 11:44:52 -0700 (PDT)
Date:   Sat, 16 Mar 2019 11:44:51 -0700 (PDT)
Message-Id: <20190316.114451.517512703233262132.davem@davemloft.net>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, sam@mendozajonas.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ncsi: fix a missing check for nla_nest_start
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190315061433.15662-1-kjlu@umn.edu>
References: <20190315061433.15662-1-kjlu@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 16 Mar 2019 11:44:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>
Date: Fri, 15 Mar 2019 01:14:33 -0500

> nla_nest_start may fail and thus deserves a check.
> 
> The fix returns -EMSGSIZE in case it fails.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Applied.
