Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853E2C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6E62133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfDARCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:02:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728641AbfDARCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:02:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C738D307D933;
        Mon,  1 Apr 2019 17:02:08 +0000 (UTC)
Received: from gondolin (ovpn-117-29.ams2.redhat.com [10.36.117.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E05675D6A6;
        Mon,  1 Apr 2019 17:02:04 +0000 (UTC)
Date:   Mon, 1 Apr 2019 19:02:01 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Parav Pandit <parav@mellanox.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kwankhede@nvidia.com, alex.williamson@redhat.com, cjia@nvidia.com
Subject: Re: [PATCHv1 3/7] vfio/mdev: Drop redundant extern for exported
 symbols
Message-ID: <20190401190201.1a5c096e.cohuck@redhat.com>
In-Reply-To: <1553658345-43995-4-git-send-email-parav@mellanox.com>
References: <1553658345-43995-1-git-send-email-parav@mellanox.com>
        <1553658345-43995-4-git-send-email-parav@mellanox.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 01 Apr 2019 17:02:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 22:45:41 -0500
Parav Pandit <parav@mellanox.com> wrote:

> There is no need use 'extern' for exported functions.
> 
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> ---
>  include/linux/mdev.h | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>
