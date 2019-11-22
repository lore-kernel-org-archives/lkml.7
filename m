Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4296CC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224332068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfKVRjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 12:39:09 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38062 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVRjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 12:39:09 -0500
Received: from localhost (c-73-35-209-67.hsd1.wa.comcast.net [73.35.209.67])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7BF601527BEE4;
        Fri, 22 Nov 2019 09:39:08 -0800 (PST)
Date:   Fri, 22 Nov 2019 09:39:07 -0800 (PST)
Message-Id: <20191122.093907.1624421831424016039.davem@davemloft.net>
To:     sgarzare@redhat.com
Cc:     stefanha@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] MAINTAINERS: Add myself as maintainer of virtio-vsock
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191122102010.14346-1-sgarzare@redhat.com>
References: <20191122102010.14346-1-sgarzare@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 22 Nov 2019 09:39:08 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 22 Nov 2019 11:20:10 +0100

> Since I'm actively working on vsock and virtio/vhost transports,
> Stefan suggested to help him to maintain it.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Applied.
