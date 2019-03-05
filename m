Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCC6C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A742082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfCEVAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 16:00:19 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:54272 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCEVAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 16:00:19 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D0052105D37A3;
        Tue,  5 Mar 2019 13:00:18 -0800 (PST)
Date:   Tue, 05 Mar 2019 13:00:18 -0800 (PST)
Message-Id: <20190305.130018.2101756189161017911.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     yuehaibing@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] appletalk: Fix compile regression
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190305132430.3821758-1-arnd@arndb.de>
References: <20190305132430.3821758-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 05 Mar 2019 13:00:19 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please repost this with netdev@vger.kernel.org CC:'d, so it gets logged in
patchwork.

Thank you Arnd.
