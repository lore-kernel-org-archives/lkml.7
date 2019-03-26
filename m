Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906AAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E70206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732701AbfCZSuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:50:52 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48774 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732490AbfCZSuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:50:52 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9DBDF14C5D361;
        Tue, 26 Mar 2019 11:50:51 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:50:51 -0700 (PDT)
Message-Id: <20190326.115051.1713861149387592628.davem@davemloft.net>
To:     mario.limonciello@dell.com
Cc:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hayeswang@realtek.com,
        sjg@google.com, campello@google.com, Ryan.Hong@Dell.com,
        Crag.Wang@dell.com
Subject: Re: [PATCH] r8152: Refresh MAC address during USBDEVFS_RESET
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1553523143-23072-1-git-send-email-mario.limonciello@dell.com>
References: <1553523143-23072-1-git-send-email-mario.limonciello@dell.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 26 Mar 2019 11:50:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mario Limonciello <mario.limonciello@dell.com>
Date: Mon, 25 Mar 2019 09:12:23 -0500

> On some platforms it is possible to dynamically change the policy
> of what MAC address is selected from the ASL at runtime.
> 
> These tools will reset the USB device and expect the change to be
> made immediately.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>

You are going to have to emit CHANGEADDR notifications and such if
necessary when you do this.
