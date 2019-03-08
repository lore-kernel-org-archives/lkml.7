Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23710C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 23:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E604020879
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 23:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfCHXQj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 18:16:39 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:41370 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfCHXQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 18:16:38 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BC3781479DBE8;
        Fri,  8 Mar 2019 15:16:37 -0800 (PST)
Date:   Fri, 08 Mar 2019 15:16:37 -0800 (PST)
Message-Id: <20190308.151637.1852310112674993852.davem@davemloft.net>
To:     alazar@bitdefender.com
Cc:     stefanha@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        aherghelegiu@bitdefender.com
Subject: Re: [PATCH v2] vsock/virtio: fix kernel panic from
 virtio_transport_reset_no_sock
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190306101353.9938-1-alazar@bitdefender.com>
References: <20190306101353.9938-1-alazar@bitdefender.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 08 Mar 2019 15:16:38 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adalbert Lazãr <alazar@bitdefender.com>
Date: Wed,  6 Mar 2019 12:13:53 +0200

> Previous to commit 22b5c0b63f32 ("vsock/virtio: fix kernel panic
> after device hot-unplug"), vsock_core_init() was called from
> virtio_vsock_probe(). Now, virtio_transport_reset_no_sock() can be called
> before vsock_core_init() has the chance to run.
 ...
> Fixes: 22b5c0b63f32 ("vsock/virtio: fix kernel panic after device hot-unplug")
> Reported-by: Alexandru Herghelegiu <aherghelegiu@bitdefender.com>
> Signed-off-by: Adalbert Lazãr <alazar@bitdefender.com>
> Co-developed-by: Stefan Hajnoczi <stefanha@redhat.com>

Applied and queued up for -stable.
