Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC17C4CEC5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D61C20678
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbfILK7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 06:59:16 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55880 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731239AbfILK7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 06:59:16 -0400
Received: from localhost (unknown [148.69.85.38])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BF8D1128F386B;
        Thu, 12 Sep 2019 03:59:14 -0700 (PDT)
Date:   Thu, 12 Sep 2019 12:59:13 +0200 (CEST)
Message-Id: <20190912.125913.284555259841442636.davem@davemloft.net>
To:     navid.emamdoost@gmail.com
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: qrtr: fix memort leak in qrtr_tun_write_iter
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190911150907.18251-1-navid.emamdoost@gmail.com>
References: <20190911.101320.682967997452798874.davem@davemloft.net>
        <20190911150907.18251-1-navid.emamdoost@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 12 Sep 2019 03:59:15 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>
Date: Wed, 11 Sep 2019 10:09:02 -0500

> In qrtr_tun_write_iter the allocated kbuf should be release in case of
> error or success return.
> 
> v2 Update: Thanks to David Miller for pointing out the release on success
> path as well.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

Applied, thanks.
