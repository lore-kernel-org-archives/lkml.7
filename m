Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8801CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 05:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E9320863
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 05:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfCDFK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 00:10:29 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56974 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfCDFK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 00:10:28 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D384D14D08EAE;
        Sun,  3 Mar 2019 21:10:27 -0800 (PST)
Date:   Sun, 03 Mar 2019 21:10:27 -0800 (PST)
Message-Id: <20190303.211027.1155530502701922072.davem@davemloft.net>
To:     joe@perches.com
Cc:     madalin.bucur@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsl/fman: Use vsprintf extension %pM
From:   David Miller <davem@davemloft.net>
In-Reply-To: <b9e4efeeca1ede0ec53043e78b15a6ffd03ed195.camel@perches.com>
References: <b9e4efeeca1ede0ec53043e78b15a6ffd03ed195.camel@perches.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 03 Mar 2019 21:10:28 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Fri, 01 Mar 2019 16:37:25 -0800

> Make logging of an ethernet address more consistent with
> the rest of the kernel.
> 
> Miscellanea:
> 
> The %02hx use also did not quite match the u8 definition
> of addr though that did not actually matter given normal
> integer promotion rules.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied to net-next, thanks Joe.
