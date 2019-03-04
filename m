Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AC9C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 04:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85BC2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 04:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfCDE6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 23:58:48 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56862 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCDE6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 23:58:47 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 17CA7145F297F;
        Sun,  3 Mar 2019 20:58:47 -0800 (PST)
Date:   Sun, 03 Mar 2019 20:58:46 -0800 (PST)
Message-Id: <20190303.205846.1228922880232983914.davem@davemloft.net>
To:     ben.dooks@codethink.co.uk
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@lists.codethink.co.uk
Subject: Re: [PATCH] net: fixup address-space warnings in
 compat_mc_{get,set}sockopt()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190301183944.6260-1-ben.dooks@codethink.co.uk>
References: <20190301183944.6260-1-ben.dooks@codethink.co.uk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 03 Mar 2019 20:58:47 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Fri,  1 Mar 2019 18:39:44 +0000

> Add __user attributes in some of the casts in this function to avoid
> the following sparse warnings:
> 
> net/compat.c:592:57: warning: cast removes address space of expression
> net/compat.c:592:57: warning: incorrect type in initializer (different address spaces)
> net/compat.c:592:57:    expected struct compat_group_req [noderef] <asn:1>*gr32
> net/compat.c:592:57:    got void *<noident>
> net/compat.c:613:65: warning: cast removes address space of expression
> net/compat.c:613:65: warning: incorrect type in initializer (different address spaces)
> net/compat.c:613:65:    expected struct compat_group_source_req [noderef] <asn:1>*gsr32
> net/compat.c:613:65:    got void *<noident>
> net/compat.c:634:60: warning: cast removes address space of expression
> net/compat.c:634:60: warning: incorrect type in initializer (different address spaces)
> net/compat.c:634:60:    expected struct compat_group_filter [noderef] <asn:1>*gf32
> net/compat.c:634:60:    got void *<noident>
> net/compat.c:672:52: warning: cast removes address space of expression
> net/compat.c:672:52: warning: incorrect type in initializer (different address spaces)
> net/compat.c:672:52:    expected struct compat_group_filter [noderef] <asn:1>*gf32
> net/compat.c:672:52:    got void *<noident>
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Applied to net-next, thanks.
