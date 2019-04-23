Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E92C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510D020B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbfDWLrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:47:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfDWLrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:47:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D72D7E436;
        Tue, 23 Apr 2019 11:47:49 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D4195D9D4;
        Tue, 23 Apr 2019 11:47:48 +0000 (UTC)
Date:   Tue, 23 Apr 2019 13:47:45 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jiang Biao <benbjiang@tencent.com>
Cc:     <pbonzini@redhat.com>, <rkrcmar@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kvm_main: fix some comments
Message-ID: <20190423134745.01a440d1.cohuck@redhat.com>
In-Reply-To: <20190423114030.75631-1-benbjiang@tencent.com>
References: <20190423114030.75631-1-benbjiang@tencent.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 23 Apr 2019 11:47:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019 19:40:30 +0800
Jiang Biao <benbjiang@tencent.com> wrote:

> is_dirty has been renamed to flush, but the comment for it is
> outdated. And the description about @flush parameter for
> kvm_clear_dirty_log_protect() is missing, add it in this patch
> as well.
> 
> Signed-off-by: Jiang Biao <benbjiang@tencent.com>
> ---
>  virt/kvm/kvm_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
