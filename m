Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3B0C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 09:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D1521479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 09:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="hSuCLOy0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfDTJNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 05:13:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60502 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbfDTJNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 05:13:20 -0400
Received: from zn.tnic (p200300EC2F112E00B067E07BEB9599DE.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:b067:e07b:eb95:99de])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 12EE71EC082D;
        Sat, 20 Apr 2019 11:13:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555751599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9lq1QY4aLxLxt4rpqRYu+zgSErytXR/0FmvyrTNQodM=;
        b=hSuCLOy0pn0kjiSc659mrmDwu+l2FeCQ3X0EtXaKgLSMSXaQ5bxtDAPnYpXtMgMod5rm0D
        RfqwBNwva86BmRAnhZ2AdG0HtG3hPiUeVaC6qtkQ7+j7i4aCnsXIzeXieyVLG2Mylibp/b
        o1BtLaEHczPB+1vQIlFmaxqVThP8za8=
Date:   Sat, 20 Apr 2019 11:13:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RAS/CEC: Add debugfs switch to disable at run time
Message-ID: <20190420091313.GA29704@zn.tnic>
References: <20190418220229.32133-1-tony.luck@intel.com>
 <CAM_iQpUAfiP2pitFpc-wSy4f_JQo_Wh3BQDxEsT2wwSHDPERow@mail.gmail.com>
 <20190418232910.GR27160@zn.tnic>
 <CAM_iQpVWvg-U6hzKsCPXdObiwKJhQ=BkGDDeP+p671cCWK7QFA@mail.gmail.com>
 <20190419002645.GA559@zn.tnic>
 <CAM_iQpVk564gCu_FBKvYVQjA1hGZ4YXB6ogrSFt=qZwiWen2tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM_iQpVk564gCu_FBKvYVQjA1hGZ4YXB6ogrSFt=qZwiWen2tw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 10:43:03PM -0700, Cong Wang wrote:
> With this change, although not even compiled, mcelog should still
> receive correctable memory errors like before, even when we have
> CONFIG_RAS_CEC=y.
> 
> Does this make any sense to you?

Yes, the answer is in the mail you snipped. Did you read it?

Hint: disable CONFIG_RAS_CEC.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
