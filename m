Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208C0C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 02:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB27620449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 02:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfGHCX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 22:23:26 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:45296 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbfGHCX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 22:23:26 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 36E2B1528C8AD;
        Sun,  7 Jul 2019 19:23:26 -0700 (PDT)
Date:   Sun, 07 Jul 2019 19:23:25 -0700 (PDT)
Message-Id: <20190707.192325.233803747660583572.davem@davemloft.net>
To:     joe@perches.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 6/8] net: nixge: Fix misuse of strlcpy
From:   David Miller <davem@davemloft.net>
In-Reply-To: <ab064ed18bee3e59431afb742dfe7a570d7d0b58.1562283944.git.joe@perches.com>
References: <cover.1562283944.git.joe@perches.com>
        <ab064ed18bee3e59431afb742dfe7a570d7d0b58.1562283944.git.joe@perches.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 07 Jul 2019 19:23:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Thu,  4 Jul 2019 16:57:46 -0700

> Probable cut&paste typo - use the correct field size.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied.
