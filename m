Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867D8C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450E42171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="eOtQLN25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfDSA3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:29:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42232 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfDSA3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 20:29:13 -0400
Received: from zn.tnic (p200300EC2F112E00C9E732E76EE3BD2F.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:c9e7:32e7:6ee3:bd2f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C7F2C1EC0104;
        Fri, 19 Apr 2019 02:29:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555633752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RxKUIpvjvgXYX9B/9KHWJx5B06b1S/YvXSu0e53/xQE=;
        b=eOtQLN25lUTI4/Q80tuH9FHMP+VAWdTI2e3w/18x/7/g8GVUvPtz1s+Jrcbo1wcdbnAYBy
        4iI+xwIX3/dVEzELIXs7APPpQ8YjPwgJoKiRFhyJ98PpJp16g1cFON9KUBSmY7X8o4iQhK
        uFQgz0OaM4Nlea+OSV8hJ3c6/+xHmeg=
Date:   Fri, 19 Apr 2019 02:29:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RAS/CEC: Add debugfs switch to disable at run time
Message-ID: <20190419002911.GB559@zn.tnic>
References: <20190418220229.32133-1-tony.luck@intel.com>
 <CAM_iQpUAfiP2pitFpc-wSy4f_JQo_Wh3BQDxEsT2wwSHDPERow@mail.gmail.com>
 <20190418232910.GR27160@zn.tnic>
 <20190419000745.GA12291@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190419000745.GA12291@agluck-desk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 05:07:45PM -0700, Luck, Tony wrote:
> On Fri, Apr 19, 2019 at 01:29:10AM +0200, Borislav Petkov wrote:
> > Which reminds me, Tony, I think all those debugging files "pfn"
> > and "array" and the one you add now, should all be under a
> > CONFIG_RAS_CEC_DEBUG which is default off and used only for development.
> > Mind adding that too pls?
> 
> Patch below, on top of previous patch.  Note that I didn't move "enable"
> into the RAS_CEC_DEBUG code. I think it has some value even on
> production systems.

And that value is? Usecase?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
