Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86CDC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907C121850
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbfDWRFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:05:00 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49940 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfDWRFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:05:00 -0400
Received: from marcel-macpro.fritz.box (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id 12B41CF2DA;
        Tue, 23 Apr 2019 19:13:09 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] Bluetooth: hidp: fix buffer overflow
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1555053870-31588-1-git-send-email-92siuyang@gmail.com>
Date:   Tue, 23 Apr 2019 19:04:58 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, viro@zeniv.linux.org.uk,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Young Xiao <YangX92@hotmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <558EAA47-F2D4-4DA0-8C95-B5440AE4F3DE@holtmann.org>
References: <1555053870-31588-1-git-send-email-92siuyang@gmail.com>
To:     Young Xiao <92siuyang@gmail.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Young,


> Struct ca is copied from userspace. It is not checked whether the "name"
> field is NULL terminated, which allows local users to obtain potentially
> sensitive information from kernel stack memory, via a HIDPCONNADD command.
> 
> This vulnerability is similar to CVE-2011-1079.
> 
> Signed-off-by: Young Xiao <YangX92@hotmail.com>
> ---
> net/bluetooth/hidp/sock.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

