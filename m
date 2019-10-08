Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABDAC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B7D206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbfJHLWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 07:22:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52743 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbfJHLWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:22:36 -0400
Received: from p2e585ebf.dip0.t-ipconnect.de ([46.88.94.191] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iHnZM-00036G-Ti; Tue, 08 Oct 2019 11:22:21 +0000
Date:   Tue, 8 Oct 2019 13:22:19 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "cyphar@cyphar.com" <cyphar@cyphar.com>,
        "christian@brauner.io" <christian@brauner.io>,
        "aubrey.li@linux.intel.com" <aubrey.li@linux.intel.com>,
        Mingfangsen <mingfangsen@huawei.com>,
        "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] proc:fix confusing macro arg name
Message-ID: <20191008112218.voltywyzbdulx6iz@wittgenstein>
References: <165631b964b644dfa933653def533e41@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <165631b964b644dfa933653def533e41@huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 06:44:18AM +0000, linmiaohe wrote:
> Add suitable additional cc's as Andrew Morton suggested.
> Get cc list from get_maintainer script:
> [root@localhost mm]# ./scripts/get_maintainer.pl 0001-proc-fix-confusing-macro-arg-name.patch 
> Alexey Dobriyan <adobriyan@gmail.com> (reviewer:PROC FILESYSTEM)
> linux-kernel@vger.kernel.org (open list:PROC FILESYSTEM)
> linux-fsdevel@vger.kernel.org (open list:PROC FILESYSTEM)
> 
> ------------------------------------------------------
> From: Miaohe Lin <linmiaohe@huawei.com>
> Subject: fix confusing macro arg name
> 
> state_size and ops are in the wrong position, fix it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

I thought I already reviewed this weeks ago...
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
