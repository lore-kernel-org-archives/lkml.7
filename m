Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F6DC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 16:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723F321920
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 16:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394837AbfIGQD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 12:03:28 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46546 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394779AbfIGQD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 12:03:27 -0400
Received: from localhost (unknown [88.214.184.0])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 51E5213EB2C91;
        Sat,  7 Sep 2019 09:03:26 -0700 (PDT)
Date:   Sat, 07 Sep 2019 18:03:24 +0200 (CEST)
Message-Id: <20190907.180324.2086722384944546511.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        lipeng321@huawei.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: hns3: make array spec_opcode static const, makes
 object smaller
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190906112804.7812-1-colin.king@canonical.com>
References: <20190906112804.7812-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 07 Sep 2019 09:03:27 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Fri,  6 Sep 2019 12:28:04 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the array spec_opcode on the stack but instead make it
> static const. Makes the object code smaller by 48 bytes.
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>    6914	   1040	    128	   8082	   1f92	hns3/hns3vf/hclgevf_cmd.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>    6866	   1040	    128	   8034	   1f62	hns3/hns3vf/hclgevf_cmd.o
> 
> (gcc version 9.2.1, amd64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
