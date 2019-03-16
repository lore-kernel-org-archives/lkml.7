Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EE7C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5A9218A1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfCPSg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 14:36:28 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43142 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfCPSg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 14:36:27 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B986C10856AE0;
        Sat, 16 Mar 2019 11:36:24 -0700 (PDT)
Date:   Sat, 16 Mar 2019 11:36:22 -0700 (PDT)
Message-Id: <20190316.113622.900917714010854876.davem@davemloft.net>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, pshelar@ovn.org, netdev@vger.kernel.org,
        dev@openvswitch.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: openvswitch: fix a NULL pointer dereference
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190315042016.3137-1-kjlu@umn.edu>
References: <20190315042016.3137-1-kjlu@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 16 Mar 2019 11:36:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>
Date: Thu, 14 Mar 2019 23:20:16 -0500

> upcall is dereferenced even when genlmsg_put fails. The fix
> goto out to avoid the NULL pointer dereference in this case.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Applied.
