Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33018C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 07:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7902053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 07:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJd7FSvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfLCHsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 02:48:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58388 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727376AbfLCHsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 02:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575359333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pkhTpBDfMGilBSgN0jOZ1InPL5ChpTlIvBxpVi2lXMU=;
        b=aJd7FSvtmfc2lkcmNDQL8xy7L2jvMosn0jQh2Yzc6l1NR/6JD68pGfQl7c9pZoM+dmljJI
        lithS9AHysQfeKLGuQjnwiSMGS5r/hmi4tmm6RcLM/7ums3y69fCqT6r9wFeaXrKYODb2d
        AhJoOdKV7t0j1SeEKgT+/FIsODV7d4M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-LQfyTKLMNF22IjYnLy8cjQ-1; Tue, 03 Dec 2019 02:48:50 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62D4218557C0;
        Tue,  3 Dec 2019 07:48:49 +0000 (UTC)
Received: from gondolin (ovpn-116-214.ams2.redhat.com [10.36.116.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86A8D67E5F;
        Tue,  3 Dec 2019 07:48:45 +0000 (UTC)
Date:   Tue, 3 Dec 2019 08:48:43 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     <pbonzini@redhat.com>, <rkrcmar@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>
Subject: Re: [PATCH] KVM: Remove duplicated declaration of kvm_vcpu_kick
Message-ID: <20191203084843.5a397060.cohuck@redhat.com>
In-Reply-To: <20191203074408.1758-1-yuzenghui@huawei.com>
References: <20191203074408.1758-1-yuzenghui@huawei.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: LQfyTKLMNF22IjYnLy8cjQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Dec 2019 15:44:08 +0800
Zenghui Yu <yuzenghui@huawei.com> wrote:

> There are two declarations of kvm_vcpu_kick() in kvm_host.h where
> one of them is redundant. Remove to keep the git grep a bit cleaner.
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  include/linux/kvm_host.h | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

