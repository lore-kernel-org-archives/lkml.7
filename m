Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6289C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC24C206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfC0V1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 17:27:51 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37408 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfC0V1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 17:27:51 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6F50914D03A42;
        Wed, 27 Mar 2019 14:27:50 -0700 (PDT)
Date:   Wed, 27 Mar 2019 14:27:50 -0700 (PDT)
Message-Id: <20190327.142750.390720588003321523.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: mdio-bcm-unimac: remove redundant !timeout
 check
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190327161520.23064-1-colin.king@canonical.com>
References: <20190327161520.23064-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 27 Mar 2019 14:27:50 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Wed, 27 Mar 2019 16:15:20 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> The check for zero timeout is always true at the end of the proceeding
> while loop; the only other exit path in the loop is if the unimac MDIO
> is not busy.  Remove the redundant zero timeout check and always
> return -ETIMEDOUT on this timeout return path.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to net-next.
