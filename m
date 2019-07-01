Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A5DC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 17:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCEAF206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 17:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbfGARtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 13:49:08 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46206 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729972AbfGARtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:49:04 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 03A8F14C03B04;
        Mon,  1 Jul 2019 10:49:03 -0700 (PDT)
Date:   Mon, 01 Jul 2019 10:49:03 -0700 (PDT)
Message-Id: <20190701.104903.1353371516845397024.davem@davemloft.net>
To:     bnvandana@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] net: dst.h: Fix shifting signed 32-bit value by 31
 bits problem
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190701115539.6738-1-bnvandana@gmail.com>
References: <20190701115539.6738-1-bnvandana@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 01 Jul 2019 10:49:04 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vandana BN <bnvandana@gmail.com>
Date: Mon,  1 Jul 2019 17:25:39 +0530

> Fix DST_FEATURE_ECN_CA to use "U" cast to avoid shifting signed
> 32-bit value by 31 bits problem.
> 
> Signed-off-by: Vandana BN <bnvandana@gmail.com>

Applied.
