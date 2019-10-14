Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C212ECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FF82089C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="KSqc/zaD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732793AbfJNO1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:27:51 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55168 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732589AbfJNO1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:27:51 -0400
Received: from zn.tnic (p200300EC2F065800329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:5800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DC5C21EC06FB;
        Mon, 14 Oct 2019 16:27:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571063270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xnAbQTxxzd5rIOcOu5tUVs/ScOLib3p+kaJk8MwESRY=;
        b=KSqc/zaDPn6v9D5UIZq9wrxPldVUwvdMSEseyWU7S5Wq/+7aEXMA7XiWEAm3lz9KWt35s7
        TCA02Fe5YQlnylwhNI0ui27bYkekf7quKcxw2ZwFDr4y0ZfIvvkSwdMtoDbXG0IIAskTJb
        SB+xxSNls49Nxb1eG9A3O9cgVQ24noY=
Date:   Mon, 14 Oct 2019 16:27:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 07/28] x86/boot: Annotate local functions
Message-ID: <20191014142742.GD4715@zn.tnic>
References: <20191011115108.12392-1-jslaby@suse.cz>
 <20191011115108.12392-8-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191011115108.12392-8-jslaby@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 01:50:47PM +0200, Jiri Slaby wrote:
> .Lrelocated, .Lpaging_enabled, .Lno_longmode, and .Lin_pm32 are
> self-standing local functions, annotate them as such and preserve "no
> alignment".
> 
> The annotations do not generate anything yet.

So the annotation is only documentational, right?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
