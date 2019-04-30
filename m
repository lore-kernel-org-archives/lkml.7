Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D163C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0F520652
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfD3OQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 10:16:17 -0400
Received: from nautica.notk.org ([91.121.71.147]:54866 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfD3OQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 10:16:16 -0400
X-Greylist: delayed 413 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Apr 2019 10:16:16 EDT
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 8370AC01A; Tue, 30 Apr 2019 16:09:22 +0200 (CEST)
Date:   Tue, 30 Apr 2019 16:09:07 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, ericvh@gmail.com, lucho@ionkov.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH] 9p/virtio: Add cleanup path in p9_virtio_init
Message-ID: <20190430140907.GA19422@nautica>
References: <20190430115942.41840-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190430115942.41840-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YueHaibing wrote on Tue, Apr 30, 2019:
> KASAN report this:

That's not KASAN, but fair enough - fix looks good. I'll queue this for
5.2 unless you absolutely want this in 5.1

If you're feeling nice p9_trans_xen_init has the exact same problem and
could use the same fix :)

-- 
Dominique
