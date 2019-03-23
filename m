Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D98C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 11:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8F5218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 11:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="DhlD0O8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfCWLIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 07:08:02 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45386 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfCWLIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 07:08:01 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A313A1EC00FF;
        Sat, 23 Mar 2019 12:08:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553339280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=odrA26MNCMrGoFF4cR49F5G0Rzi28OkVXWWIfqOeh9M=;
        b=DhlD0O8G1EMXZ89OHdX58GeB14oSTiyg3n852sjwoVpyL+/THT8VxGhqGSizw/8jsDQglT
        KOmFVAbFU7x5OQjy2PEguy46+SX1goPvx7yo0C3HGl8C5iOJjAR85PJmQKaNBZ7/9aCvTY
        1zKANl9tjazM4+6qlOODSFVoLOLJYxY=
Date:   Sat, 23 Mar 2019 12:08:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/cpu/hygon: Fix phys_proc_id calculation logic
 for multi-die processor
Message-ID: <20190323110802.GE23698@zn.tnic>
References: <1553251380-7015-1-git-send-email-puwen@hygon.cn>
 <20190322155449.GE12472@zn.tnic>
 <639a5bc6-f821-ee9d-1594-d02701321192@hygon.cn>
 <20190322171632.GI12472@zn.tnic>
 <18e15073-81c2-73a3-abf1-e785d6a5649b@hygon.cn>
 <20190323085934.GB23698@zn.tnic>
 <e181933e-775a-4597-7700-9dde8b98295f@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e181933e-775a-4597-7700-9dde8b98295f@hygon.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 06:56:52PM +0800, Pu Wen wrote:
> Because AMD doesn't have 2-Socket system with 1-Die/2-Die processors(see
> reference [2]). So it will return the right result when getting physical
> ID in AMD system.

There it is! Now add that to the commit message please.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
