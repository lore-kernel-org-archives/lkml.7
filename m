Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD430C4360C
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 00:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F8A206C0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 00:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbfJEA2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 20:28:00 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60396 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJEA2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 20:28:00 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AFE1E14F2D926;
        Fri,  4 Oct 2019 17:27:59 -0700 (PDT)
Date:   Fri, 04 Oct 2019 17:27:59 -0700 (PDT)
Message-Id: <20191004.172759.987507160837677462.davem@davemloft.net>
To:     kai.heng.feng@canonical.com
Cc:     hayeswang@realtek.com, mario.limonciello@dell.com,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] r8152: Set macpassthru in reset_resume callback
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191004125104.13202-1-kai.heng.feng@canonical.com>
References: <20191004125104.13202-1-kai.heng.feng@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 04 Oct 2019 17:27:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Fri,  4 Oct 2019 20:51:04 +0800

> r8152 may fail to establish network connection after resume from system
> suspend.
> 
> If the USB port connects to r8152 lost its power during system suspend,
> the MAC address was written before is lost. The reason is that The MAC
> address doesn't get written again in its reset_resume callback.
> 
> So let's set MAC address again in reset_resume callback. Also remove
> unnecessary lock as no other locking attempt will happen during
> reset_resume.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied.
