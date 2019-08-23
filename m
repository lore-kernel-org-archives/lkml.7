Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A75C3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D588F23404
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390118AbfHWC10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:27:26 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51980 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729716AbfHWC1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:27:25 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EEF17153ABADF;
        Thu, 22 Aug 2019 19:27:24 -0700 (PDT)
Date:   Thu, 22 Aug 2019 19:27:24 -0700 (PDT)
Message-Id: <20190822.192724.1052619848261339045.davem@davemloft.net>
To:     Justin.Lee1@Dell.com
Cc:     netdev@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, sam@mendozajonas.com
Subject: Re: [PATCH] net/ncsi: Fix the payload copying for the request
 coming from Netlink
From:   David Miller <davem@davemloft.net>
In-Reply-To: <a94e5fa397a64ae3a676ec11ea09aaba@AUSX13MPS302.AMER.DELL.COM>
References: <a94e5fa397a64ae3a676ec11ea09aaba@AUSX13MPS302.AMER.DELL.COM>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 22 Aug 2019 19:27:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: <Justin.Lee1@Dell.com>
Date: Wed, 21 Aug 2019 21:24:52 +0000

> The request coming from Netlink should use the OEM generic handler.
> 
> The standard command handler expects payload in bytes/words/dwords
> but the actual payload is stored in data if the request is coming from Netlink.
> 
> Signed-off-by: Justin Lee <justin.lee1@dell.com>

Applied, thank you.
