Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6211C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979CE205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="PxWcdGEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732628AbfDQPB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:01:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60822 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732260AbfDQPB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:01:28 -0400
Received: from zn.tnic (p200300EC2F112E0089A16ED5684D695F.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:89a1:6ed5:684d:695f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 110711EC014A;
        Wed, 17 Apr 2019 17:01:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555513287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NI+YjC2PtAX5QIej0YkyTU6n0AlvI02x5WVTskH3nvA=;
        b=PxWcdGEY/M5qRKmCcNPJzKPj3tsdqUX2t8bOK4umRDGAcJ22dPmzOqYnsfEYhFnoS3RYx2
        460wf9590V9vnH51lLd9nrFo9lHiqcLe1JQBaPM7py3/MHZJ+iN8nynkKUal73nOpHCINk
        pby5zYLN4im3qC5HUARcnf3tD4FwGiQ=
Date:   Wed, 17 Apr 2019 17:01:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, kirill@shutemov.name,
        keescook@chromium.org, peterz@infradead.org, thgarnie@google.com,
        herbert@gondor.apana.org.au, mike.travis@hpe.com,
        frank.ramsay@hpe.com, yamada.masahiro@socionext.com
Subject: Re: [PATCH v2 RESEND 1/2] x86/mm/KASLR: Fix the size of the direct
 mapping section
Message-ID: <20190417150122.GF20492@zn.tnic>
References: <20190414072804.12560-1-bhe@redhat.com>
 <20190414072804.12560-2-bhe@redhat.com>
 <20190415185319.GI29317@zn.tnic>
 <20190417083536.GE7065@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190417083536.GE7065@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 04:35:36PM +0800, Baoquan He wrote:
> I made a new one to add this fact, I can repost if it's OK to you.

No, it looks ok and I can take it from here.

Also, resending too often is annoying, as I'm sure you know. Try to
stick to resending once a week.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
