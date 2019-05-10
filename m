Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E96C04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 14:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF262175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 14:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="QbiF7HCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfEJON2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 10:13:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59570 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727735AbfEJON1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 10:13:27 -0400
Received: from zn.tnic (p200300EC2F0F4000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:4000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 694991EC09A3;
        Fri, 10 May 2019 16:13:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557497606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tyGuOVHxEH/rHK2/frw1zh0k63kPvLFcLiy/vy/VnPE=;
        b=QbiF7HCBmyWy2lZMwoadGqqCuHDWg6o2wU9DBA4y8EGXaG983gZeu2RPMBwnG9kN42VLPs
        Ua7KyICWWaO2EDWFAdfejbkC6X9AevafrinvwFU3YLeDK/dKIwLtai4yo1dQz0z9Lp42M3
        V6J31cWGW1iTv0pPrCvPdQbi6ORvEds=
Date:   Fri, 10 May 2019 16:13:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Johannes Thumshirn <morbidrsa@gmail.com>,
        linux-edac@vger.kernel.org, mchehab@kernel.org,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] EDAC, mpc85xx: Prevent building as a module
Message-ID: <20190510141320.GB29927@zn.tnic>
References: <20190502141941.12927-1-mpe@ellerman.id.au>
 <20190506065045.GA3901@x250>
 <20190508101238.GB19015@zn.tnic>
 <87o94bvfxm.fsf@concordia.ellerman.id.au>
 <20190509145534.GD17053@zn.tnic>
 <20190509180220.GH17053@zn.tnic>
 <87bm0avb03.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bm0avb03.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 08:50:52PM +1000, Michael Ellerman wrote:
> Yeah that looks better to me. I didn't think about the case where EDAC
> core is modular.
> 
> Do you want me to send a new patch?

Nah, I'll fix it up.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
