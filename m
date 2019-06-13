Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AF9C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723F121473
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbfFMVMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 17:12:51 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60398 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729897AbfFMVMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 17:12:48 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 478D4149B35A7;
        Thu, 13 Jun 2019 14:12:48 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:12:47 -0700 (PDT)
Message-Id: <20190613.141247.955308190761079084.davem@davemloft.net>
To:     thuth@redhat.com
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc: Remove redundant copy of the LGPL-2.0
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190527163253.27203-1-thuth@redhat.com>
References: <20190527163253.27203-1-thuth@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 13 Jun 2019 14:12:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Huth <thuth@redhat.com>
Date: Mon, 27 May 2019 18:32:53 +0200

> We already provide the LGPL-2.0 text in LICENSES/preferred/LGPL-2.0,
> so there is no need for this additional copy here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied.
