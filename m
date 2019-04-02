Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CF0C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D0E207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="TjaWSGdW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbfDBPoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:44:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57302 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfDBPop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:44:45 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 509901EC023E;
        Tue,  2 Apr 2019 17:44:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554219884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gMrDWUMzfukWXR0WqAn6zvGDP/FgwHXqnDiKMZ51oEs=;
        b=TjaWSGdWGk0GjtF7ep6yv2WEBaiJRYe6ienOsqYKT46rPhMaEfyotGJncDBbwX54QDI7FZ
        sq/oCdbJdQXVU4tBLPEhnM+qBFB+Y7EqU2fmhRLCpn1hxzhVDSugZxEjK+02t5xU9j5l2m
        dXBNmUqnm4iMHdu5WezA+hweYQ38Gck=
Date:   Tue, 2 Apr 2019 17:44:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thor Thayer <thor.thayer@linux.intel.com>
Cc:     mchehab@kernel.org, james.morse@arm.com, atull@kernel.org,
        richard.gong@intel.com, gregkh@linuxfoundation.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] firmware: Intel: Add Stratix10 ECC DBE SMC call
Message-ID: <20190402154443.GI6826@zn.tnic>
References: <1553870639-23895-1-git-send-email-thor.thayer@linux.intel.com>
 <20190402085529.GC6826@zn.tnic>
 <b250c876-11d8-5558-9650-d75061d67919@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b250c876-11d8-5558-9650-d75061d67919@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 08:34:18AM -0500, Thor Thayer wrote:
> Yes, they can be merged into one. I split into 2 patches since the 1st
> required the firmware directory sign-off and the 2nd required your EDAC
> sign-off. I see your point, it could have been 1 patch.

Ok, merged and applied.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
