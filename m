Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D61CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F09821897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409789AbfJRRUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 13:20:06 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55278 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405285AbfJRRUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 13:20:06 -0400
Received: from localhost (unknown [IPv6:2603:3023:50c:85e1:5314:1b70:2a53:887e])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 66A9C11D4071A;
        Fri, 18 Oct 2019 10:20:05 -0700 (PDT)
Date:   Fri, 18 Oct 2019 13:20:04 -0400 (EDT)
Message-Id: <20191018.132004.44442251462291428.davem@davemloft.net>
To:     sgarzare@redhat.com
Cc:     netdev@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH net 0/2] vsock/virtio: make the credit mechanism more
 robust
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191017124403.266242-1-sgarzare@redhat.com>
References: <20191017124403.266242-1-sgarzare@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 18 Oct 2019 10:20:05 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 17 Oct 2019 14:44:01 +0200

> This series makes the credit mechanism implemented in the
> virtio-vsock devices more robust.
> Patch 1 sends an update to the remote peer when the buf_alloc
> change.
> Patch 2 prevents a malicious peer (especially the guest) can
> consume all the memory of the other peer, discarding packets
> when the credit available is not respected.

Series applied, thanks.
