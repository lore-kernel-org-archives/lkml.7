Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BE1C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 01:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD4E2073B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 01:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfLEBJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 20:09:30 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38530 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbfLEBJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 20:09:29 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2927814F35C6E;
        Wed,  4 Dec 2019 17:09:29 -0800 (PST)
Date:   Wed, 04 Dec 2019 17:09:28 -0800 (PST)
Message-Id: <20191204.170928.536021818533653039.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     aelior@marvell.com, GR-everest-linux-l2@marvell.com,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] qed: remove redundant assignments to rc
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191204114442.1413895-1-colin.king@canonical.com>
References: <20191204114442.1413895-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 04 Dec 2019 17:09:29 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Wed,  4 Dec 2019 11:44:42 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable rc is assigned with a value that is never read and
> it is re-assigned a new value later on.  The assignment is redundant
> and can be removed.  Clean up multiple occurrances of this pattern.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

This really is a cleanup, and doesn't fix any bugs.

Therefore, please resubmit this when net-next opens back up.

Thank you.
