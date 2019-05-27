Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A37C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCA22081C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="lMEKz0zD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfE0WnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 18:43:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42374 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbfE0WnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 18:43:22 -0400
Received: from cz.tnic (ip65-44-65-130.z65-44-65.customer.algx.net [65.44.65.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 074BE1EC0235;
        Tue, 28 May 2019 00:43:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1558997001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=A3lxvIsrPSbg0ZQOpn4IF3bUM+OBWu1SGzd8ZU1ihFQ=;
        b=lMEKz0zD5CRezR3l0MBGTmLSk+azH65NAI7l/ARNpaJDGyc2H1VbmyF8nRFw9Yg6kM3XZ0
        FL7nee6YoTQ+qJvB0dVpewEPz6jNZYHb9jkuhzq3XYDBXDbt2yJGllaDTKW+gzv0E3Lz/o
        UKWVQF7bSa6EuAWCZsqfKVPrtC6RAuY=
Date:   Tue, 28 May 2019 00:43:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Zhao, Yakui" <yakui.zhao@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: Re: [PATCH v6 3/4] x86/acrn: Use HYPERVISOR_CALLBACK_VECTOR for ACRN
 guest upcall vector
Message-ID: <20190527224316.GA8209@cz.tnic>
References: <1556595926-17910-1-git-send-email-yakui.zhao@intel.com>
 <1556595926-17910-4-git-send-email-yakui.zhao@intel.com>
 <20190515172356.GL24212@zn.tnic>
 <27c20325-61b7-994f-2781-f4bc41badc6f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27c20325-61b7-994f-2781-f4bc41badc6f@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 10:21:20AM +0800, Zhao, Yakui wrote:
> Very sorry that this issue is not triggered as the used .config in my test
> doesn't enable the check of "-Werror=implict-function-declaration".

It is more like, you're not building this particular .config.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply. Srsly.
