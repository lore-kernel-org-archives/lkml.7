Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58169C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 22:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FCF206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 22:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfLIWnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 17:43:43 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36778 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfLIWnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 17:43:42 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E0F77154A52AE;
        Mon,  9 Dec 2019 14:43:41 -0800 (PST)
Date:   Mon, 09 Dec 2019 14:43:41 -0800 (PST)
Message-Id: <20191209.144341.154593651924539444.davem@davemloft.net>
To:     mst@redhat.com
Cc:     linux-kernel@vger.kernel.org, jcfaracco@gmail.com,
        netdev@vger.kernel.org, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, dnmendes76@gmail.com
Subject: Re: [PATCH net-next v9 0/3] netdev: ndo_tx_timeout cleanup
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191209162727.10113-1-mst@redhat.com>
References: <20191209162727.10113-1-mst@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 09 Dec 2019 14:43:42 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Mon, 9 Dec 2019 11:28:57 -0500

> A bunch of drivers want to know which tx queue triggered a timeout,
> and virtio wants to do the same.
> We actually have the info to hand, let's just pass it on to drivers.
> Note: tested with an experimental virtio patch by Julio.
> That patch itself isn't ready yet though, so not included.
> Other drivers compiled only.

Besides the "int" --> "unsigned int" typing issue, I never saw patch #2
neither on the mailing list nor directly sent to me.
