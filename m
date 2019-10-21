Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1938FCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBDB20640
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="e2c8tnig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfJUOsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:48:43 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40360 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfJUOsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:48:42 -0400
Received: from zn.tnic (p2E584653.dip0.t-ipconnect.de [46.88.70.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6C8131EC0A91;
        Mon, 21 Oct 2019 16:48:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571669321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pjWIkpLMK5mOQ/gGlbRrndfhCTK5s+2xhpspK++UbSM=;
        b=e2c8tnig01lPq62gUfXKUHeRqstVfvf8bmZDOdtPP+21mq0A7rp6OB3qsFKSyxodq+hry7
        YMgdR/5h9ebNCzjzYIzN0sDaGc5NR0PJEjAN4P7G3q6Lw4Tu/RSMvN80Fag+eEXSjx+aJc
        Zxa8y4wUfTY3NzlAS4dCQyfkK15iTJQ=
Date:   Mon, 21 Oct 2019 16:48:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/6] AMD64 EDAC: Check for nodes without memory, etc.
Message-ID: <20191021144807.GE7014@zn.tnic>
References: <20191018153114.39378-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018153114.39378-1-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 03:31:25PM +0000, Ghannam, Yazen wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Hi Boris,
> 
> This set contains the next revision of the RFC patches I included with
> the last AMD64 EDAC updates. I dropped the RFC tags, and I added a
> couple of new patches.

Yah, looks pretty much good, modulo the minor things I commented on
earlier.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
