Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF04DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8674E206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfCDSzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:55:04 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37636 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfCDSzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:55:03 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AD604147120F6;
        Mon,  4 Mar 2019 10:55:02 -0800 (PST)
Date:   Mon, 04 Mar 2019 10:55:02 -0800 (PST)
Message-Id: <20190304.105502.1287424121311510730.davem@davemloft.net>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, isdn@linux-pingi.de, gustavo@embeddedor.com,
        bigeasy@linutronix.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isdn: mISDN: Fix potential NULL pointer dereference of
 kzalloc
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190302212044.13638-1-pakki001@umn.edu>
References: <20190302212044.13638-1-pakki001@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 04 Mar 2019 10:55:03 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>
Date: Sat,  2 Mar 2019 15:20:43 -0600

> Allocating memory via kzalloc for phi may fail and causes a
> NULL pointer dereference. This patch avoids such a scenario.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Applied.
