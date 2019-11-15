Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE40C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA132071B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfKOBpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 20:45:13 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57332 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfKOBpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 20:45:13 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9E25714B73C6A;
        Thu, 14 Nov 2019 17:45:12 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:45:12 -0800 (PST)
Message-Id: <20191114.174512.2282984013110706126.davem@davemloft.net>
To:     andrea.mayer@uniroma2.it
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        dav.lebrun@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next, 1/3] seg6: verify srh pointer in get_srh()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191113192912.17546-2-andrea.mayer@uniroma2.it>
References: <20191113192912.17546-1-andrea.mayer@uniroma2.it>
        <20191113192912.17546-2-andrea.mayer@uniroma2.it>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 14 Nov 2019 17:45:12 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Mayer <andrea.mayer@uniroma2.it>
Date: Wed, 13 Nov 2019 20:29:10 +0100

> pskb_may_pull may change pointers in header. For this reason, it is
> mandatory to reload any pointer that points into skb header.
> 
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>

This is a bug fix and must be separated out and submitted to 'net'.

Then you must wait until 'net' is merged into 'net-next' so that you
can cleanly resubmit the other changes in this series which add the
new features.

Actually, patch #2 looks like a bug fix as well.
