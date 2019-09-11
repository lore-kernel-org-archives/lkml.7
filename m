Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9CCECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 08:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5E22168B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 08:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfIKIag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 04:30:36 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40174 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfIKIaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 04:30:35 -0400
Received: from localhost (unknown [148.69.85.38])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 97D4015567B3E;
        Wed, 11 Sep 2019 01:30:34 -0700 (PDT)
Date:   Wed, 11 Sep 2019 10:30:33 +0200 (CEST)
Message-Id: <20190911.103033.1889508833586793614.davem@davemloft.net>
To:     rdunlap@infradead.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiri@mellanox.com, idosch@mellanox.com
Subject: Re: [PATCH] lib/Kconfig: fix OBJAGG in lib/ menu structure
From:   David Miller <davem@davemloft.net>
In-Reply-To: <34674398-54dc-a4d1-6052-67ad1a3b2fe9@infradead.org>
References: <34674398-54dc-a4d1-6052-67ad1a3b2fe9@infradead.org>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 11 Sep 2019 01:30:35 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>
Date: Mon, 9 Sep 2019 14:54:21 -0700

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Keep the "Library routines" menu intact by moving OBJAGG into it.
> Otherwise OBJAGG is displayed/presented as an orphan in the
> various config menus.
> 
> Fixes: 0a020d416d0a ("lib: introduce initial implementation of object aggregation manager")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Applied, thanks Randy.
