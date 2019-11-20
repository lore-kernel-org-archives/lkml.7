Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F76AC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 01:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3928722460
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 01:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfKTBPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 20:15:03 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:47970 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfKTBPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 20:15:02 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A8B3E1454E871;
        Tue, 19 Nov 2019 17:15:01 -0800 (PST)
Date:   Tue, 19 Nov 2019 17:15:01 -0800 (PST)
Message-Id: <20191119.171501.666690660172999834.davem@davemloft.net>
To:     sgarzare@redhat.com
Cc:     netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        decui@microsoft.com, stefanha@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        jhansen@vmware.com
Subject: Re: [PATCH net-next 4/6] vsock: add vsock_loopback transport
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191119110121.14480-5-sgarzare@redhat.com>
References: <20191119110121.14480-1-sgarzare@redhat.com>
        <20191119110121.14480-5-sgarzare@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 19 Nov 2019 17:15:02 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 19 Nov 2019 12:01:19 +0100

> +static int vsock_loopback_cancel_pkt(struct vsock_sock *vsk)
> +{
> +	struct vsock_loopback *vsock;
> +	struct virtio_vsock_pkt *pkt, *n;
> +	int ret;
> +	LIST_HEAD(freeme);

Reverse christmas tree ordering of local variables here please.
