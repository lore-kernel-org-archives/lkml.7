Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C303AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954AA214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfCKUet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:34:49 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:41374 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKUet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:34:49 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A532914C68359;
        Mon, 11 Mar 2019 13:34:48 -0700 (PDT)
Date:   Mon, 11 Mar 2019 13:34:44 -0700 (PDT)
Message-Id: <20190311.133444.1845411430150527645.davem@davemloft.net>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, sgoutham@cavium.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: thunder: fix a potential NULL pointer dereference
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190311060541.16287-1-kjlu@umn.edu>
References: <20190311060541.16287-1-kjlu@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 11 Mar 2019 13:34:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>
Date: Mon, 11 Mar 2019 01:05:41 -0500

> In case alloc_ordered_workqueue fails, the fix reports the error
> and returns -ENOMEM.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Applied.
