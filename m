Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E40C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435F920883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbfDBL5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:57:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfDBL5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:57:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 29105C057F32;
        Tue,  2 Apr 2019 11:57:51 +0000 (UTC)
Received: from gondolin (dhcp-192-213.str.redhat.com [10.33.192.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61F2E60856;
        Tue,  2 Apr 2019 11:57:50 +0000 (UTC)
Date:   Tue, 2 Apr 2019 13:57:48 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] kvm: move KVM_CAP_NR_MEMSLOTS to common code
Message-ID: <20190402135748.5d845872.cohuck@redhat.com>
In-Reply-To: <1553793000-53968-1-git-send-email-pbonzini@redhat.com>
References: <1553793000-53968-1-git-send-email-pbonzini@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 02 Apr 2019 11:57:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2019 18:10:00 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> All architectures except MIPS were defining it in the same way,
> and memory slots are handled entirely by common code so there
> is no point in keeping the definition per-architecture.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Documentation/virtual/kvm/api.txt | 5 ++---
>  arch/powerpc/kvm/powerpc.c        | 3 ---
>  arch/s390/kvm/kvm-s390.c          | 3 ---
>  arch/x86/kvm/x86.c                | 3 ---
>  virt/kvm/arm/arm.c                | 3 ---
>  virt/kvm/kvm_main.c               | 2 ++
>  6 files changed, 4 insertions(+), 15 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
