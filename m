Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3A8C606D1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C64216C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfGHWfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 18:35:40 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59632 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbfGHWfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 18:35:37 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CD2AC12D6BBEF;
        Mon,  8 Jul 2019 15:35:36 -0700 (PDT)
Date:   Mon, 08 Jul 2019 15:35:36 -0700 (PDT)
Message-Id: <20190708.153536.95559795393042220.davem@davemloft.net>
To:     sgarzare@redhat.com
Cc:     netdev@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        linux-kernel@vger.kernel.org, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, stefanha@redhat.com
Subject: Re: [PATCH v3 0/3] vsock/virtio: several fixes in the .probe() and
 .remove()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190705110454.95302-1-sgarzare@redhat.com>
References: <20190705110454.95302-1-sgarzare@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 08 Jul 2019 15:35:37 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri,  5 Jul 2019 13:04:51 +0200

> During the review of "[PATCH] vsock/virtio: Initialize core virtio vsock
> before registering the driver", Stefan pointed out some possible issues
> in the .probe() and .remove() callbacks of the virtio-vsock driver.
 ...

Series applied to net-next, thanks.
