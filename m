Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83199C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 21:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D37920830
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 21:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfCCVCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 16:02:05 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:53114 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfCCVCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 16:02:04 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AB3BB146C1E02;
        Sun,  3 Mar 2019 13:02:03 -0800 (PST)
Date:   Sun, 03 Mar 2019 13:02:03 -0800 (PST)
Message-Id: <20190303.130203.157736686386510021.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     joe@perches.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 0/2] appletalk: small cleanup and bugfix
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190301025757.27592-1-yuehaibing@huawei.com>
References: <20190301025757.27592-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 03 Mar 2019 13:02:03 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Haibing <yuehaibing@huawei.com>
Date: Fri, 1 Mar 2019 10:57:55 +0800

> From: YueHaibing <yuehaibing@huawei.com>
> 
> v2:
> - Add cover letter log
> 
> This patch series mainly fix a use-after-free bug in atalk_proc_exit.
> patch 1 use remove_proc_subtree helper to simplify atalk_proc fs code,
> also some other cleanup.
> patch 2 add proper error cleanup path in atalk_init to fix the issue, which
> based on the patch 1 because of the change of atalk_proc_exit context.

Series applied, thanks.
