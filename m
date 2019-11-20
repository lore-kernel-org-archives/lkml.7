Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E344BC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADCA92075E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKTUkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:40:13 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:59812 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfKTUkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 15:40:13 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7186214C24B32;
        Wed, 20 Nov 2019 12:40:12 -0800 (PST)
Date:   Wed, 20 Nov 2019 12:40:11 -0800 (PST)
Message-Id: <20191120.124011.1174279012914659296.davem@davemloft.net>
To:     sgarzare@redhat.com
Cc:     netdev@vger.kernel.org, arnd@arndb.de, maowenan@huawei.com,
        jhansen@vmware.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH net-next] vsock/vmci: make vmci_vsock_cb_host_called
 static
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191120155634.43936-1-sgarzare@redhat.com>
References: <20191120155634.43936-1-sgarzare@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 20 Nov 2019 12:40:12 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 20 Nov 2019 16:56:34 +0100

> From: Mao Wenan <maowenan@huawei.com>
> 
> When using make C=2 drivers/misc/vmw_vmci/vmci_driver.o
> to compile, below warning can be seen:
> drivers/misc/vmw_vmci/vmci_driver.c:33:6: warning:
> symbol 'vmci_vsock_cb_host_called' was not declared. Should it be static?
> 
> This patch make symbol vmci_vsock_cb_host_called static.
> 
> Fixes: b1bba80a4376 ("vsock/vmci: register vmci_transport only when VMCI guest/host are active")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> Hi Dave,
> do you think it could go through net-next since it solves a problem
> introduced by "vsock: add multi-transports support" series?
> 
> Adding R-b from "kbuild test robot" that found the same issue.

Applied to net-next.
