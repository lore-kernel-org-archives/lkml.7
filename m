Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8A9C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA5B2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f7rFTPmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfDLP4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:56:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53458 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfDLP4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ieaNL9xoFtN+ckG62a9dnkgMnVgjTThPhbkh1gxR73k=; b=f7rFTPmgu8GKAjysL5GLfQXB/
        CpiKYuQHgaNz7ptBzUx64ZjnLqKA6aQNAZxBaTwz35mWJtw/TjAlrUBKpmuq8iRKz1wTuwiXMKSU9
        dWKB5cqfN2RsjcnTjpvR11wyKfsRf5X17hX2skY99EO6soLsfTR1b2Cq8oQ93cVYUHiZ322/I+cFU
        QZwsWE7ciJMmuT/hJZSpFN3BZuWRuZwzz9yDrHwmH3SDvrhyhgusJmxqyv9T9IHeQw6cV/w8uTLkY
        qynb0vIwXiO1dpfUOXxsoGYzKG9Kb8qjEnygi06ZJzHaGXqLEQhetZOOO2xEgUj/tMMISa1w1q3xQ
        U6MT0vHng==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEyXZ-0004gx-Ri; Fri, 12 Apr 2019 15:56:33 +0000
Subject: Re: linux-next: Tree for Apr 12 (orangefs)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devel@lists.orangefs.org
References: <20190412181707.51c073c3@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c3628696-c14a-09a8-3cdf-0b5da5b7df64@infradead.org>
Date:   Fri, 12 Apr 2019 08:56:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412181707.51c073c3@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/19 1:17 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190411:
> 
> The orangefs tree lost its build failure.

Not really.  In some config/options, it still has a few thousand
build errors.  Out of 20 randconfig builds, there was one large
failure in i386 and one in x86_64:

linux-next-20190412> grep -c "orangefs.*error:" X*/build*.out
X32/build-r4840.out:0
X32/build-r4841.out:0
X32/build-r4842.out:0
X32/build-r4843.out:0
X32/build-r4844.out:0
X32/build-r4845.out:0
X32/build-r4846.out:0
X32/build-r4847.out:1118
X32/build-r4848.out:0
X32/build-r4849.out:0
X64/build-r4850.out:0
X64/build-r4851.out:0
X64/build-r4852.out:0
X64/build-r4853.out:0
X64/build-r4854.out:0
X64/build-r4855.out:0
X64/build-r4856.out:0
X64/build-r4857.out:0
X64/build-r4858.out:2236
X64/build-r4859.out:0

as well as this warning on i386:
fs/orangefs/inode.c:544:8: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 3 has type ‘size_t’ [-Wformat=]



But the build errors are easily fixed:

---
From: Randy Dunlap <rdunlap@infradead.org>

#include the hashtable.h header file before it is needed/used.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mike Marshall <hubcap@omnibond.com>
Cc: Martin Brandenburg <martin@omnibond.com>
Cc: devel@lists.orangefs.org
---
 fs/orangefs/orangefs-kernel.h |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20190412.orig/fs/orangefs/orangefs-kernel.h
+++ linux-next-20190412/fs/orangefs/orangefs-kernel.h
@@ -27,6 +27,7 @@
 #include <linux/mpage.h>
 #include <linux/namei.h>
 #include <linux/errno.h>
+#include <linux/hashtable.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/slab.h>






-- 
~Randy
