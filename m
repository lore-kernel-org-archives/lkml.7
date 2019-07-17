Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49803C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00087217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbfGQGqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 02:46:46 -0400
Received: from smtprelay0122.hostedemail.com ([216.40.44.122]:42790 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725906AbfGQGqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 02:46:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 17059181D12ED;
        Wed, 17 Jul 2019 06:46:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: copy28_7d036c1ef63
X-Filterd-Recvd-Size: 1561
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Wed, 17 Jul 2019 06:46:43 +0000 (UTC)
Message-ID: <9791d12717bba784f24f35c29ddfaab9ccb78965.camel@perches.com>
Subject: Re: [PATCH v8 4/5] x86/paravirt: Remove const mark from
 x86_hyper_xen_hvm variable
From:   Joe Perches <joe@perches.com>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org
Date:   Tue, 16 Jul 2019 23:46:41 -0700
In-Reply-To: <1563251169-30740-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1563251169-30740-1-git-send-email-zhenzhong.duan@oracle.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-16 at 12:26 +0800, Zhenzhong Duan wrote:
> .. as "nopv" support needs it to be changeable at boot up stage.
> 
> Checkpatch reports warning, so move variable declarations from
> hypervisor.c to hypervisor.h
[]
> diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
[]
> @@ -259,7 +259,7 @@ static __init void xen_hvm_guest_late_init(void)
>  #endif
>  }
>  
> -const __initconst struct hypervisor_x86 x86_hyper_xen_hvm = {
> +struct hypervisor_x86 x86_hyper_xen_hvm __initdata = {

static?


