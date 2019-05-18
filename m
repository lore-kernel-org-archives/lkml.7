Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0290C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 20:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8992082C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 20:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfERU1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 16:27:14 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59906 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfERU1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 16:27:14 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 912F614DF4C35;
        Sat, 18 May 2019 13:27:13 -0700 (PDT)
Date:   Sat, 18 May 2019 13:27:12 -0700 (PDT)
Message-Id: <20190518.132712.1971625204431294331.davem@davemloft.net>
To:     jasowang@redhat.com
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        kvm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        stefanha@redhat.com
Subject: Re: [PATCH V2 0/4] Prevent vhost kthread from hogging CPU
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1558067392-11740-1-git-send-email-jasowang@redhat.com>
References: <1558067392-11740-1-git-send-email-jasowang@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 18 May 2019 13:27:13 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Fri, 17 May 2019 00:29:48 -0400

> Hi:
> 
> This series try to prevent a guest triggerable CPU hogging through
> vhost kthread. This is done by introducing and checking the weight
> after each requrest. The patch has been tested with reproducer of
> vsock and virtio-net. Only compile test is done for vhost-scsi.
> 
> Please review.
> 
> This addresses CVE-2019-3900.
> 
> Changs from V1:
> - fix user-ater-free in vosck patch

I am assuming that not only will mst review this, it will also go via
his tree rather than mine.

Thanks.
