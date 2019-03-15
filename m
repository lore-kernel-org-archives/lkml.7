Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B3FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2510121871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfCOS4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 14:56:43 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60488 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbfCOS4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 14:56:42 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 81FE614D9DD42;
        Fri, 15 Mar 2019 11:56:41 -0700 (PDT)
Date:   Fri, 15 Mar 2019 11:56:40 -0700 (PDT)
Message-Id: <20190315.115640.1477522812438525683.davem@davemloft.net>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, shshaikh@marvell.com, manishc@marvell.com,
        GR-Linux-NIC-Dev@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qlcnic: Avoid potential NULL pointer dereference
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190314203140.20039-1-pakki001@umn.edu>
References: <20190314203140.20039-1-pakki001@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 15 Mar 2019 11:56:41 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>
Date: Thu, 14 Mar 2019 15:31:40 -0500

> netdev_alloc_skb can fail and return a NULL pointer which is
> dereferenced without a check. The patch avoids such a scenario.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Applied.
