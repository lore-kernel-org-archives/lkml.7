Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BEDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233DB2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ShxN0dwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbfCYMPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:15:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46270 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730799AbfCYMPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:15:55 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1E7061EC0AB1;
        Mon, 25 Mar 2019 13:15:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553516153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GpwgKkitpK+f0Ey08EjdEFFnzuGSVS8bHxedA0RAm7g=;
        b=ShxN0dwP8ON2/3saF/L2IMkngQOI8dGzPJWBACHrBvN7etvFODl6yoeC9+dcsmIZPu48NN
        b6/mqJtdLsZzVsfWSoZlDxG2sIjqqUkd1NSXp/nWzA0E7byGxgBgUEhVbxEcyVi9Ai4qzY
        XdC3Gk5nVUuHsH/XoQnrEudld7CJUUY=
Date:   Mon, 25 Mar 2019 13:15:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH 1/3 v9] x86/mm: Change the examination condition to avoid
 confusion
Message-ID: <20190325121554.GJ12016@zn.tnic>
References: <20190321103309.27883-1-lijiang@redhat.com>
 <20190321103309.27883-2-lijiang@redhat.com>
 <20190322175114.GL12472@zn.tnic>
 <aa4af285-0aa2-3477-76a8-87f93d4db599@redhat.com>
 <20190325064046.GB12016@zn.tnic>
 <dd7b5fb6-bd77-61a2-afa5-d52137c24cbd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd7b5fb6-bd77-61a2-afa5-d52137c24cbd@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 05:20:43PM +0800, lijiang wrote:
> Let's look at the discussion in patch v8, please refer to this link:
> https://lkml.org/lkml/2019/3/16/15
> 
> I did a test according to Tom's reply, and the test indicated his suggestion was
> correct, we should change this to check for IORES_DESC_ACPI_* values.

I know that discussion - I was on CC.

Your patch still doesn't explain *why* this change is needed and the
fact that you "did a test" and it worked doesn't answer my question a
single bit. In fact, it tells me that you have tried something at random
without even understanding why this is needed and makes me even more
suspicious towards what you're doing.

So slow down pls *think* why this change is needed and then *explain*
that in the commit message.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
