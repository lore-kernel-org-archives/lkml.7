Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D26C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 01:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525D8222B0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 01:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfKSBIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 20:08:48 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52032 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfKSBIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 20:08:48 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2D56E150FA0F8;
        Mon, 18 Nov 2019 17:08:47 -0800 (PST)
Date:   Mon, 18 Nov 2019 17:08:46 -0800 (PST)
Message-Id: <20191118.170846.498950498885489049.davem@davemloft.net>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, idosch@mellanox.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, dsahern@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: atm: Reduce the severity of logging in
 unlink_clip_vcc
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191117202837.7462-1-pakki001@umn.edu>
References: <20191117202837.7462-1-pakki001@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 18 Nov 2019 17:08:47 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>
Date: Sun, 17 Nov 2019 14:28:36 -0600

> In case of errors in unlink_clip_vcc, the logging level is set to
> pr_crit but failures in clip_setentry are handled by pr_err().
> The patch changes the severity consistent across invocations.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Applied.
