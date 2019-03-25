Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F296BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09CF206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="cUtIW5VZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbfCYVuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:50:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48292 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729106AbfCYVt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:49:59 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4180C1EC058B;
        Mon, 25 Mar 2019 22:49:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553550598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=s9H0oUNY6HRHpq2P75yYndYzWuvUMTce9l9uMjVl7ZU=;
        b=cUtIW5VZ4IGHufkzwQPl9FHQObqLSRc+yOicDnoxVbsaYFD2ddC/R8u/uzGcrjAiQFvTn+
        0Tu8nHkOlauRjaVVp9oXO0oqjvTc6BG/IszGNRhbMAlrPQtB7KQU+vDtepKoTfpcdslM4O
        OAWDlnQ2x3bIIqQHR+lqMcZVMgCXQc4=
Date:   Mon, 25 Mar 2019 22:50:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Yash Shah <yash.shah@sifive.com>, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, palmer@sifive.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, aou@eecs.berkeley.edu, mchehab@kernel.org,
        devicetree@vger.kernel.org, sachin.ghadi@sifive.com
Subject: Re: [PATCH 2/2] edac: sifive: Add EDAC driver for SiFive FU540-C000
 chip
Message-ID: <20190325215005.GU12016@zn.tnic>
References: <1553082728-9232-1-git-send-email-yash.shah@sifive.com>
 <1553082728-9232-3-git-send-email-yash.shah@sifive.com>
 <alpine.DEB.2.21.9999.1903241558210.8028@viisi.sifive.com>
 <20190325065737.GD12016@zn.tnic>
 <alpine.DEB.2.21.9999.1903251418440.8028@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1903251418440.8028@viisi.sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 02:26:52PM -0700, Paul Walmsley wrote:
> We'll definitely take the RAM savings that a few #ifdefs will deliver to 
> us.  They add up.  We're selling chips for embedded use cases, not just 
> big-iron x86 systems.

Fair enough.

Btw, while we're at it, this driver would need a MAINTAINERS entry so
that you guys can get CCed on bugs.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
