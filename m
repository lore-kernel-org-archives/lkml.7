Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B10C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A544C2073B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbfLLTCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 14:02:02 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42688 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730590AbfLLTCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 14:02:02 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C18F6153DFC82;
        Thu, 12 Dec 2019 11:01:59 -0800 (PST)
Date:   Thu, 12 Dec 2019 11:01:59 -0800 (PST)
Message-Id: <20191212.110159.1715559793988195794.davem@davemloft.net>
To:     sgarzare@redhat.com
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        stefanha@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] vhost/vsock: accept only packets with the right dst_cid
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191212131453.yocx6wckoluwofbb@steredhat>
References: <20191212123624.ahyhrny7u6ntn3xt@steredhat>
        <20191212075356-mutt-send-email-mst@kernel.org>
        <20191212131453.yocx6wckoluwofbb@steredhat>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 12 Dec 2019 11:02:00 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 12 Dec 2019 14:14:53 +0100

> On Thu, Dec 12, 2019 at 07:56:26AM -0500, Michael S. Tsirkin wrote:
>> On Thu, Dec 12, 2019 at 01:36:24PM +0100, Stefano Garzarella wrote:
>> I'd say it's better to backport to all stable releases where it applies,
>> but yes it's only a security issue in 5.4.  Dave could you forward pls?
> 
> Yes, I agree with you.
> 
> @Dave let me know if I should do it.

I've queued it up for -stable.
