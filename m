Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4B7C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 19:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3061C20880
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 19:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="K6kQHa1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfK1TM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 14:12:27 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48604 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfK1TM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 14:12:26 -0500
Received: from zn.tnic (p200300EC2F0E060039EF63088A4922F4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:600:39ef:6308:8a49:22f4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4F46F1EC0CEA;
        Thu, 28 Nov 2019 20:12:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574968345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VO2+3nbvrUPhWFSa9tZrx9TObzJHTuLsupwv5J4Y3KI=;
        b=K6kQHa1WBaoFI36JJUNyFCuq19p0sLeyfmXiiv/V1XqQyilirOzavm9V9Zm40IGCddJOmr
        Md3K+7Z/KxKSpSYCcZ8p6CGkyM5AtA6ttaRx4S39ZnRX+E9tOk0jKX9akCOSY5TwsfC+e5
        TKcz3YjWWKnU/2i0k9MD/SiyBRhRdcQ=
Date:   Thu, 28 Nov 2019 20:12:18 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: unchecked MSR access error in throttle_active_work()
Message-ID: <20191128191218.GG17745@zn.tnic>
References: <20191128085447.GA3682@owl.dominikbrodowski.net>
 <20191128094419.GB17745@zn.tnic>
 <20191128102930.jgra6igtp4rppmis@isilmar-4.linta.de>
 <2859c017f515695eae1de47fdcf34db35bc5be39.camel@linux.intel.com>
 <20191128185607.GA3726@owl.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191128185607.GA3726@owl.dominikbrodowski.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 07:56:07PM +0100, Dominik Brodowski wrote:
> Seems to work fine now. Thanks!

Does that mean I can add Reported-by: and Tested-by: you?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
