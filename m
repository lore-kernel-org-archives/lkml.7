Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B6FC43140
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 20:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99A42070C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 20:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="qhDKa5Px"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394561AbfIFUf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 16:35:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34410 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730769AbfIFUf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 16:35:26 -0400
Received: from zn.tnic (p200300EC2F0B9E001838F3417D010484.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:9e00:1838:f341:7d01:484])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2E8211EC02FE;
        Fri,  6 Sep 2019 22:35:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567802125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dynyToDEkqXwuBTxEZf5raaCQrPyEjC2lvqrX9T0IYg=;
        b=qhDKa5PxwlKzLpRwV7fSWcuisldlhxAoo3q+GIuQixpdxXB50O0Fky7WssgZQ9iyX96ONJ
        Pkas+XNJu7AxgbTmOHj0piijEpucsywfI0RQa8SdqAKtdqcVFNNLJ8TIdtnBcmrQysI5VE
        3DXzlZ64aVqI3hAmGPKSzxk2rEObt6k=
Date:   Fri, 6 Sep 2019 22:35:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v3 08/10] EDAC/amd64: Gather hardware information
 early
Message-ID: <20190906203519.GN19008@zn.tnic>
References: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
 <20190821235938.118710-9-Yazen.Ghannam@amd.com>
 <20190829092241.GB1312@zn.tnic>
 <SN6PR12MB26393DDA0F1818DCDD2D7953F8BA0@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB26393DDA0F1818DCDD2D7953F8BA0@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 07:14:57PM +0000, Ghannam, Yazen wrote:
> This struct is used per channel, so we may have 2-8 per system.

Ah, true.

> We could fix it at the max (8). What do you think?

Anything in struct amd64_umc that is shared between those channels or
all max 8 of them can be distinct?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
