Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EA1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D714020830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="WI2SAqow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfCYGkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:40:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51972 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729631AbfCYGkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:40:40 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 38FFA1EC0104;
        Mon, 25 Mar 2019 07:40:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553496039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SiRFajHdGoJEAoe1idIfGofcQCwIJttW+DllrXcgtm0=;
        b=WI2SAqowlMoLt+cP0ZuyBZoMSdd86sFLoNVbkoO2767V9F0b9AcvczSzM7PZ8aEStcHrdp
        9M7tmbM46bc1L41Nv5okP+5smJgh4e1iwbB+ylFSf1FYDxSFWS3GDxDtdEC8SAEsdE5V/w
        QmU1hNZHhCkXSr306YU//txMhnreZ/E=
Date:   Mon, 25 Mar 2019 07:40:46 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH 1/3 v9] x86/mm: Change the examination condition to avoid
 confusion
Message-ID: <20190325064046.GB12016@zn.tnic>
References: <20190321103309.27883-1-lijiang@redhat.com>
 <20190321103309.27883-2-lijiang@redhat.com>
 <20190322175114.GL12472@zn.tnic>
 <aa4af285-0aa2-3477-76a8-87f93d4db599@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa4af285-0aa2-3477-76a8-87f93d4db599@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 11:11:45AM +0800, lijiang wrote:
> I mean it needs to find all the value of the 'IORES_DESC_ACPI_*' type.

A function called __ioremap_check_desc_other() needs to find
IORES_DESC_ACPI_* types...

No, still don't know what you're trying to do.

> As above mentioned, it needs to find all the value of the 'IORES_DESC_ACPI_*'
> type, so we should explicitly use the 'IORES_DESC_ACPI_*' type as the check
> condition instead of the 'IORES_DESC_NONE'.

And now the same question I'm asking you each time: WHY does it need to find
the ACPI types?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
