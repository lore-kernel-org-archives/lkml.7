Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B6DC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B51F20449
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388389AbfFMQ3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:29:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392508AbfFMQ3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:29:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0F151C01F28C;
        Thu, 13 Jun 2019 16:29:30 +0000 (UTC)
Received: from flask (unknown [10.40.205.10])
        by smtp.corp.redhat.com (Postfix) with SMTP id 23A5F5ED3C;
        Thu, 13 Jun 2019 16:29:26 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Thu, 13 Jun 2019 18:29:26 +0200
Date:   Thu, 13 Jun 2019 18:29:26 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: nVMX: use correct clean fields when copying from
 eVMCS
Message-ID: <20190613162926.GA24797@flask>
References: <20190613113502.9535-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190613113502.9535-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 13 Jun 2019 16:29:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019-06-13 13:35+0200, Vitaly Kuznetsov:
> Unfortunately, a couple of mistakes were made while implementing
> Enlightened VMCS support, in particular, wrong clean fields were
> used in copy_enlightened_to_vmcs12():
> - exception_bitmap is covered by CONTROL_EXCPN;
> - vm_exit_controls/pin_based_vm_exec_control/secondary_vm_exec_control
>   are covered by CONTROL_GRP1.
> 
> Fixes: 945679e301ea0 ("KVM: nVMX: add enlightened VMCS state")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---

Reviewed-by: Radim Krčmář <rkrcmar@redhat.com>
