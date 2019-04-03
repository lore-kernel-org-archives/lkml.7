Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB69C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F6B2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="JHCyQh3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfDCISY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:18:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59698 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfDCISX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:18:23 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ABD4E1EC05DE;
        Wed,  3 Apr 2019 10:18:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554279502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Z8dgp1oLwkwlcZxZ+JTiNwN9zTfhBi78d+da12rCjQ4=;
        b=JHCyQh3ycm52ah/aTRlEvvXxgzPljJFFoSNuxB5k6fp+JFpQFapMlhs+O+PBUnUi1PMWCU
        C1yIyA866TA0ypa3LZE4zhoYHWxDo6nPAZT80bymuTXYgYs3uDf7kbaysn+YM9REwX6M37
        KmyYsql0PyagYT7Fcq5R8sovHskqSFI=
Date:   Wed, 3 Apr 2019 10:18:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>
Subject: Re: [PATCH] x86/microcode: Remove useless code after early microcode
 support added
Message-ID: <20190403081751.GA6970@zn.tnic>
References: <1554108412-22229-1-git-send-email-zhenzhong.duan@oracle.com>
 <20190402153524.GH6826@zn.tnic>
 <4c12556d-9663-5cc9-bf0a-b2032110b0cb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c12556d-9663-5cc9-bf0a-b2032110b0cb@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 03:40:24PM +0800, Zhenzhong Duan wrote:
> I remember microcode could be module before early loading was added.

You've remembered it wrongly, it is the other way around:

9a2bc335f100 ("x86/microcode: Unmodularize the microcode driver")

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
