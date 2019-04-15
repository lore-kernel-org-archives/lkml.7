Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864F7C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4862520818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="dzyguiH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfDOPLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:11:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42710 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727326AbfDOPLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:11:21 -0400
Received: from zn.tnic (p4FED3D80.dip0.t-ipconnect.de [79.237.61.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3C20C1EC0104;
        Mon, 15 Apr 2019 17:11:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555341080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QCLMoMsTKAXmw0y+yefNuUjq7iuC6JX/R0IqnnaMksM=;
        b=dzyguiH94vqpLzkGfsKjhWkhr4Xnk3B08NAUsK6+zAWS6J9ON4n5VLZts64P5nbBPLvlhr
        17qXqzSdJp5yrUWXBkZwjhm58LsNIs9cIRtak7E8EVGLW8Q0gWHUMVl/SLLlvnNaeQI9p0
        cUE2EVzrGXSyZcFIufCRvAG+HDD7uAQ=
Date:   Mon, 15 Apr 2019 17:09:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Hao Feng <fenghao@hygon.cn>
Cc:     'Joerg Roedel ' <joro@8bytes.org>,
        'Paolo Bonzini ' <pbonzini@redhat.com>,
        ' Radim =?utf-8?B?S3LEjW3DocWZ?= ' <rkrcmar@redhat.com>,
        'Thomas Gleixner ' <tglx@linutronix.de>,
        'Ingo Molnar ' <mingo@redhat.com>,
        "' H. Peter Anvin '" <hpa@zytor.com>,
        'Zhaohui Du ' <duzhaohui@hygon.cn>,
        'Zhiwei Ying ' <yingzhiwei@hygon.cn>,
        'Wen Pu ' <puwen@hygon.cn>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] KVM: SVM: Add support for KVM_SEV_GM_GET_DIGEST
 command
Message-ID: <20190415150910.GE29317@zn.tnic>
References: <1555329868-17895-1-git-send-email-fenghao@hygon.cn>
 <1555329868-17895-6-git-send-email-fenghao@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1555329868-17895-6-git-send-email-fenghao@hygon.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 08:04:27PM +0800, Hao Feng wrote:
> The command is used to get the key digest from SEV firmware, guest
> owner will check the key digest to see if the key negotiation is
> successful or not.
> 
> Signed-off-by: Hao Feng <fenghao@hygon.cn>
> Signed-off-by: Pu Wen <puwen@hygon.cn>

Your both SOB chains are wrong. See:

  11) Sign your work - the Developer's Certificate of Origin
  12) When to use Acked-by:, Cc:, and Co-developed-by:
  13) Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:

sections in

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
