Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529C0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2883A2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfCOS7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 14:59:14 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60522 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfCOS7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 14:59:13 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1B32A14D9FA6B;
        Fri, 15 Mar 2019 11:59:13 -0700 (PDT)
Date:   Fri, 15 Mar 2019 11:59:12 -0700 (PDT)
Message-Id: <20190315.115912.78487134360712525.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     venza@brownhat.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sis900: fix indentation issues, remove some spaces
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190314235635.11667-1-colin.king@canonical.com>
References: <20190314235635.11667-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 15 Mar 2019 11:59:13 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Thu, 14 Mar 2019 23:56:35 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> There are several statements that contain extra spacing in
> the indentation; clean this up by removing spaces. Also
> add { } braces on if statement to keep to kernel coding
> style.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
