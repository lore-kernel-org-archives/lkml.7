Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBDAC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 06:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A457D20684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 06:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mnnr3wTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfCGGUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 01:20:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53982 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfCGGUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 01:20:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=48BRb9x1Sx2NO4Di+s1s7UlWFBaijF1pvM6EeNGjTC0=; b=mnnr3wTg9sSyL/zHWI+kLhwTw
        AvqUPIL2blcmLX91XT13gin9iLEwHmafUTrDvzJ08ck48IjowX933bM4M4MDA1nC+59hz3ARQH0ce
        Bc1c45FwrtZ4Dk4wxjV7kxsFWN8rENd9BKofoJ5GYPZ7QvoHstvDUa8aL+lXRDHuMG0PcZExemZAD
        368HGXYkNvO/dwtYzlX9hQCxAMDAoz5gQOz1njU3W7lyk451DY2jefdBEgSa722d4dnq4ptZ6rOja
        AqTEhCrse/Mnk91jkx506wH4ze5pN+aIkj2SgHMIhEIQRNUMLyUbbeYiDo0tC11ep7MfzR+uXjCiB
        e8r0dxAsA==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1mOW-00084L-Pv; Thu, 07 Mar 2019 06:20:40 +0000
Date:   Wed, 6 Mar 2019 22:20:39 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Mattias Jacobsson <2pi@mok.nu>
Cc:     andy@infradead.org, mario.limonciello@dell.com,
        michal.lkml@markovi.net, mjg59@srcf.ucam.org, pali.rohar@gmail.com,
        yamada.masahiro@socionext.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/8] platform/x86: wmi: add WMI support to
Message-ID: <20190307062039.GG44339@wrath>
References: <cover.1550603967.git.2pi@mok.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1550603967.git.2pi@mok.nu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 08:59:48PM +0100, Mattias Jacobsson wrote:
> The kernel provides the macro MODULE_DEVICE_TABLE() which can help
> driver authors to generate the appropriate MODULE_ALIAS() output. The
> WMI device type is currently not supported by MODULE_DEVICE_TABLE().

Thanks Mattias. I have this queued up for testing, and with an ack from
Masahiro for 2/8, I'll pull this in. Thanks for the patches.

-- 
Darren Hart
VMware Open Source Technology Center
