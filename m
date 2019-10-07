Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EE4C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1757421655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfJGOBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:01:05 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53004 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfJGOBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:01:04 -0400
Received: from localhost (unknown [144.121.20.163])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C86B61411EAF3;
        Mon,  7 Oct 2019 07:01:03 -0700 (PDT)
Date:   Mon, 07 Oct 2019 16:01:03 +0200 (CEST)
Message-Id: <20191007.160103.449489515941198973.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        tanhuazhong@huawei.com, linyunsheng@huawei.com,
        lipeng321@huawei.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: hns3: make array tick_array static, makes object
 smaller
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191007110935.32607-1-colin.king@canonical.com>
References: <20191007110935.32607-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 07 Oct 2019 07:01:04 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Mon,  7 Oct 2019 12:09:35 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the array tick_array on the stack but instead make it
> static. Makes the object code smaller by 29 bytes.
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   19191	    432	      0	  19623	   4ca7	hisilicon/hns3/hns3pf/hclge_tm.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   19098	    496	      0	  19594	   4c8a	hisilicon/hns3/hns3pf/hclge_tm.o
> 
> (gcc version 9.2.1, amd64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
