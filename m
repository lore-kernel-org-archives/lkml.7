Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E3CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2872184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M4EM0xwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfCTPFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:05:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35630 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfCTPFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NU7OCzToea/W2OFZrf3xnbBldScyyakPBNoWNNyNxOY=; b=M4EM0xwe47i6TAXPlgJFnm3cf
        E6tQp1y4sb4Kep0rqkxAAlpd7WqsD/BFKJU6OCKbeFU0zBQ8WFEqR7q/GKkMOrxVjmHA8CDyPLXgE
        YzXsfGYkRLMEpLbIcEFhbzb5Mjo0y9qtpHCiRxx9QGx33w/r+6CnK/CRP0nP69ivP5DSCbZPEPUzb
        CEf8yLMMORUGFtwGktRbBw5J5Zjw93bLw5sBmo8ccrnojzww1xDOdERSQbiR30TRH8abmw6FNLGin
        wgkydOKKMFwVQNln0373W/J5ykaaGSFgXweMBHiPo4MQTkm1UkwZ8tb/J+VVFBVPlIIlU/WQ+lwlq
        O5j4N/EtQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6cmv-0006Ik-07; Wed, 20 Mar 2019 15:05:53 +0000
Subject: Re: [PATCH v2 7/7] x86/boot: Support nocfg parameter for earlyprintk
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
References: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
 <20190319184325.72807-8-andriy.shevchenko@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8742b0a2-de4e-9865-cb3e-dfda0dec6a0a@infradead.org>
Date:   Wed, 20 Mar 2019 08:05:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190319184325.72807-8-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/19 11:43 AM, Andy Shevchenko wrote:
> If by BIOS or by other means the serial port is configured
> user might want to skip reconfiguration in the boot code.
> 
> Add support of 'nocfg' parameter to earlyprintk.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Hi Andy,
Please add "nocfg" to Documentation/admin-guide/kernel-parameters.txt.


-- 
~Randy
