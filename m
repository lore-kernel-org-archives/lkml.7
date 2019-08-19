Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E9CC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 06:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88432087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 06:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="cv2oEIev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfHSGRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 02:17:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37678 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfHSGRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 02:17:52 -0400
Received: from zn.tnic (p200300EC2F04B700DD16340F367BA899.dip0.t-ipconnect.de [IPv6:2003:ec:2f04:b700:dd16:340f:367b:a899])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5CA9D1EC072D;
        Mon, 19 Aug 2019 08:17:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566195471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Tij8cUPtjlXBKM4Vt2vKmoASpHF0u05wcnukynHg88Y=;
        b=cv2oEIevx6RQAjKhn9EqEh82mDGBtttH2QjyhXEwIatTUCGo3hIvmlf45xQt8YqYrW5qpI
        l8kk59VaETbHymgum6O2Y8VBEIfC3k8WhgBBqSS73s5abTCQ8O0AzbjNsXmNTlkt/RfyLr
        w2gMqpDhmjOYD3yRf07U/7csjjkRkGs=
Date:   Mon, 19 Aug 2019 08:18:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Zhao, Yakui" <yakui.zhao@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: [RFC PATCH 00/15] acrn: add the ACRN driver module
Message-ID: <20190819061840.GB4841@zn.tnic>
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
 <20190816063925.GB18980@zn.tnic>
 <78897bb2-e6eb-cac2-7166-eccb7cd5c959@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <78897bb2-e6eb-cac2-7166-eccb7cd5c959@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 09:44:25AM +0800, Zhao, Yakui wrote:
> Not sure whether it can be sent in two patch sets?
> The first is to add the required APIs for ACRN driver.
> The second is to add the ACRN driver

One patchset adding the APIs and its user(s).

And make sure to refresh on

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

before sending.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
