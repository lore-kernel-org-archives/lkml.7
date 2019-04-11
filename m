Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B8BC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD93520850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfDKFqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:46:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52374 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfDKFq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:46:29 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0DE1714C8DE31;
        Wed, 10 Apr 2019 22:46:29 -0700 (PDT)
Date:   Wed, 10 Apr 2019 22:46:28 -0700 (PDT)
Message-Id: <20190410.224628.1651735622261723310.davem@davemloft.net>
To:     jasowang@redhat.com
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost: reject zero size iova range
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190409041025.20922-1-jasowang@redhat.com>
References: <20190409041025.20922-1-jasowang@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 10 Apr 2019 22:46:29 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Tue,  9 Apr 2019 12:10:25 +0800

> We used to accept zero size iova range which will lead a infinite loop
> in translate_desc(). Fixing this by failing the request in this case.
> 
> Reported-by: syzbot+d21e6e297322a900c128@syzkaller.appspotmail.com
> Fixes: 6b1e6cc7 ("vhost: new device IOTLB API")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied and queued up for -stable.
