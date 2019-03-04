Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB019C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A138520675
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfCDSQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:16:34 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36976 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCDSQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:16:33 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 61F6714700BB9;
        Mon,  4 Mar 2019 10:16:33 -0800 (PST)
Date:   Mon, 04 Mar 2019 10:16:33 -0800 (PST)
Message-Id: <20190304.101633.1998818339852915958.davem@davemloft.net>
To:     maowenan@huawei.com
Cc:     edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: question about memory leak in ip_mc_del1_src
From:   David Miller <davem@davemloft.net>
In-Reply-To: <91def48c-15be-2bac-7c9b-2cead21b6fa9@huawei.com>
References: <91def48c-15be-2bac-7c9b-2cead21b6fa9@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 04 Mar 2019 10:16:33 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: maowenan <maowenan@huawei.com>
Date: Mon, 4 Mar 2019 20:47:42 +0800

> 			pmc->tomb = psf;
> 			rv = 1;         //if it does not kfree(psf), will it lead to memory leak after this line?

pmc->tomb points to psf, why should we free it?
