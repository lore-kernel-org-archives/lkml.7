Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08B7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEBD2133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfDARBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:01:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbfDARBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:01:10 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E5C3781226;
        Mon,  1 Apr 2019 17:01:09 +0000 (UTC)
Received: from gondolin (ovpn-117-29.ams2.redhat.com [10.36.117.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74B4228547;
        Mon,  1 Apr 2019 17:01:05 +0000 (UTC)
Date:   Mon, 1 Apr 2019 19:01:02 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Parav Pandit <parav@mellanox.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kwankhede@nvidia.com, alex.williamson@redhat.com, cjia@nvidia.com
Subject: Re: [PATCHv1 2/7] vfio/mdev: Removed unused kref
Message-ID: <20190401190102.7f3ffac3.cohuck@redhat.com>
In-Reply-To: <1553658345-43995-3-git-send-email-parav@mellanox.com>
References: <1553658345-43995-1-git-send-email-parav@mellanox.com>
        <1553658345-43995-3-git-send-email-parav@mellanox.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 01 Apr 2019 17:01:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 22:45:40 -0500
Parav Pandit <parav@mellanox.com> wrote:

> Remove unused kref from the mdev_device structure.
> 
> Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
> Reviewed By: Kirti Wankhede <kwankhede@nvidia.com>

Same here (Reviewed-by:).

> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> ---
>  drivers/vfio/mdev/mdev_core.c    | 1 -
>  drivers/vfio/mdev/mdev_private.h | 1 -
>  2 files changed, 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
