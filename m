Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF39C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F36521841
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="crMDki9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfCVTxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:53:48 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60200 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfCVTxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 15:53:48 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 60F681EC0AB1;
        Fri, 22 Mar 2019 20:53:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553284427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=W3VeHhP1V9NLwTdiD+9xRkqzcGib+JufCn1BB5KjKT4=;
        b=crMDki9oaYkx6hWBnNzq1Q13Ctcz2qsYZfHVupqG57BdfSlqRYmtsnQ8So04MBgNavMd4G
        zePXg2lVVoaFtYeXr6C1/gMdCxfZ1gScftg3cqPjz7R7KI32fBHb/axNWB9OD4VYPJ7766
        e+p8OgtnDJX4Y3LBvd53lL7RTL4824U=
Date:   Fri, 22 Mar 2019 20:53:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Zhao Yakui <yakui.zhao@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Jason Chen CJ <jason.cj.chen@intel.com>
Subject: Re: [RFC PATCH 2/3] arch/x86/acrn: Use HYPERVISOR_CALLBACK_VECTOR
 for Acrn upcall vector
Message-ID: <20190322195350.GO12472@zn.tnic>
References: <1551924251-19466-1-git-send-email-yakui.zhao@intel.com>
 <1551924251-19466-3-git-send-email-yakui.zhao@intel.com>
 <alpine.DEB.2.21.1903221620150.1729@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903221620150.1729@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 04:44:37PM +0100, Thomas Gleixner wrote:
> > +EXPORT_SYMBOL(acrn_remove_intr_irq);
> 
> Where is the code which uses these exports? We are not adding exports just
> because or for consumption by out of tree modules.

Right, if anything, all new exports should be _GPL.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
