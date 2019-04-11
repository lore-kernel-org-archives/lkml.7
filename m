Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14122C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFDD2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fmbZedcv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfDKO6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 10:58:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36510 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfDKO6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 10:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ShZSBivlfqPAGQJ7/AM1/Rc6/8iy5yc9fdVIkozN0Do=; b=fmbZedcvFP9t/lDrVvmPt5v4Wg
        tIzRLn6zE+jvaSvmi4dY7GAJXmYLaAJ/UMc3b9uyisjbhzRay/uSoDx7ghTPQuYrwbHQ+G3iwlAWf
        PtMrqEAAdiEXOBV2nTskIHest87JuNhLoA/LpFApRp3f7tCR56KMn++Lr9ZNt97iDzVq49rYhrk++
        B41vBOkAlV2/qPXLGaid+/RyGqwht2/2pQGLnvzaxO0IjhbfcmSPzqTH9QTiixt7H5Gk69K8AfLsF
        KVT6qA6jLo1751OZB4jtG/SA2fxRYCx/PWSdTCoSCtVITIrCXJ+WGhtLs9SY2nAku1TWg0tFlirt6
        bCok1hCw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEb9U-0002eU-33; Thu, 11 Apr 2019 14:58:08 +0000
Subject: Re: [GIT PULL] <global> global spelling corrections for v5.1.0-rc5
To:     Kenny Van de Maele <kenny.vandemaele@inuits.eu>,
        torvalds@linux-foundation.org
Cc:     torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <0b6539fe5b2741b1327119236ea0e401d02003e6.camel@inuits.eu>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0885bbf9-ccb1-280e-dde1-ffa40282df09@infradead.org>
Date:   Thu, 11 Apr 2019 07:58:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <0b6539fe5b2741b1327119236ea0e401d02003e6.camel@inuits.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/19 2:12 AM, Kenny Van de Maele wrote:
> are available in the Git repository at:
> 
>   git://github.com/vdmkenny/linux-spelling-fix.git tags/common-
> spelling-fixes-5.1.0-rc5
> 
> for you to fetch changes up to
> 6ee0055f3414a64133228e82004ea60d0e659d6d:
> 
>   fix common spelling mistakes (2019-04-11 10:22:24 +0200)
> 
> ----------------------------------------------------------------
> This PR contains a set of global spelling fixes of commonly miss-
> spelled

misspelled


Is there a way for me to review the diff on github?

thanks.


> words. Mostly documentation and comments were impacted, but a few lines
> of code were affected as well.
> 
> ----------------------------------------------------------------
> Kenny Van de Maele (1):
>       fix common spelling mistakes


-- 
~Randy
