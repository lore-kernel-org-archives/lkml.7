Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ACEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46028206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="FzfJULC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfCKTBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:01:48 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38644 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbfCKTBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:01:48 -0400
Received: from zn.tnic (unknown [IPv6:2003:ec:2f05:7900:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 12BB81EC0313;
        Mon, 11 Mar 2019 20:01:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1552330907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZO4kfNaOHX2a+3mIDJ7Qko+Z9r3gfvjLwicBpX2iznI=;
        b=FzfJULC7lzokbaNpMSYx1+UfmawQXpyKHu3ZQNyPMbCBhmcQx4pl2JRtv6nOjCXPZF981m
        VGxVfG37lvH0cI8SG+4yJH9Mm2nPjdJL4cNxMTAO9auS8CafEho0qIEqK661gNKoSC2hPQ
        knXjunryskqRZH9kbVdxQN3oUmdRrVs=
Date:   Mon, 11 Mar 2019 20:01:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "clemej@gmail.com" <clemej@gmail.com>
Subject: Re: [PATCH 2/2] x86/MCE/AMD, EDAC/mce_amd: Don't report L1 BTB MCA
 errors on some Family 17h models
Message-ID: <20190311190145.GE7384@zn.tnic>
References: <20190307212552.8865-1-Yazen.Ghannam@amd.com>
 <20190307212552.8865-2-Yazen.Ghannam@amd.com>
 <20190311182104.GD7384@zn.tnic>
 <SN6PR12MB263931263441531964542EB4F8480@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB263931263441531964542EB4F8480@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 06:52:05PM +0000, Ghannam, Yazen wrote:
> Should I keep the filter in edac_mce_amd? I guess it's not necessary
> if filtered out earlier.

Nah, you don't need to touch that if you filter earlier.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
