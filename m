Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B30C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544A32084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="f7jE8eVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfDIUNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:13:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48494 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbfDIUNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 16:13:31 -0400
Received: from zn.tnic (p200300EC2F0F850034F9F589D882639B.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:8500:34f9:f589:d882:639b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5349B1EC00FF;
        Tue,  9 Apr 2019 22:13:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554840810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TJTV5PNZEol+XmBW62N/1p2Fum6+baujgu7QCqCSxJQ=;
        b=f7jE8eVjZVzyPEKHECaWkWciS3sTygjLeAT8BLG40AGalDiiTNcU584CBs7qfBj0C0+K+m
        Rk6r3+zAR0PJpcBAtQxim1JAUAv+4Z6AA7/Y4VNFd5Pk64SIQ1CO2DUz1hB7bFbyAnl/8e
        sRWwq9vdw8OX2h0dCBzDr1TLWFGY5Ys=
Date:   Tue, 9 Apr 2019 22:13:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thor Thayer <thor.thayer@linux.intel.com>
Cc:     dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, james.morse@arm.com,
        devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCHv3 0/3] Update Stratix10 EDAC Bindings
Message-ID: <20190409201323.GD6150@zn.tnic>
References: <1554388597-28019-1-git-send-email-thor.thayer@linux.intel.com>
 <fa5b2837-9cb0-517c-c491-9b5d3ae0a3a5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fa5b2837-9cb0-517c-c491-9b5d3ae0a3a5@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 02:11:58PM -0500, Thor Thayer wrote:
> If possible, I'd like this series to go through the EDAC tree since future
> patches will follow this format.

You know how that works - I need ACKs.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
