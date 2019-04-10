Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9079EC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9CB2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="VgQDqn51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfDJTFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:05:06 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55644 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbfDJTFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:05:05 -0400
Received: from zn.tnic (p200300EC2F0CAE0088EC372D30EF1627.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:ae00:88ec:372d:30ef:1627])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 42CE21EC03A0;
        Wed, 10 Apr 2019 21:05:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554923104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CviuCDVo3FiHNRAlNLWZRhOH2BwQ6pdfhdwt4tuFJEM=;
        b=VgQDqn51cCi/ZhDIrV9dNMvDDhkejMB10XujSEZVJRTnGitiaL5pJ1+bBWZn18XNgveccd
        uc7yrbfoqODcZYWF5ydRYuCIUQeL2mwnMHRe3KHZMKMN8jeWAFOk1cQ0yBKMyQp5hSVaLf
        rscgVLCwiJKefOrkec6rBlLbtTL0y7s=
Date:   Wed, 10 Apr 2019 21:04:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thor Thayer <thor.thayer@linux.intel.com>
Cc:     dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, james.morse@arm.com,
        devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCHv3 0/3] Update Stratix10 EDAC Bindings
Message-ID: <20190410190456.GH26580@zn.tnic>
References: <1554388597-28019-1-git-send-email-thor.thayer@linux.intel.com>
 <fa5b2837-9cb0-517c-c491-9b5d3ae0a3a5@linux.intel.com>
 <20190409201323.GD6150@zn.tnic>
 <f843024e-5f06-a566-7ab4-5c3e03e6ed3f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f843024e-5f06-a566-7ab4-5c3e03e6ed3f@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 05:32:07PM -0500, Thor Thayer wrote:
> I have ACKs on patches 1 & 3. Patch 2 has a Reviewed-by from Rob Herring
> which was sufficient in the past.

Sorry about that - I missed those because I looked only at the diffstat
and decided this series is not for me :)

Anyway, all three applied now.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
