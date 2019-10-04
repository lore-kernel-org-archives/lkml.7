Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203ECC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 22:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E306920873
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 22:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vAKh3MuB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfJDWyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 18:54:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51888 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDWyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 18:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=q7cFanO1yPrAL0Ms2pu/t8f2IKPxaooYId2nsISMS/k=; b=vAKh3MuBDu9WH0S4ok4rWz4Mc
        WJgGGH+MGNElCRQKgPVju9QFa7vg+wOsrxqM25Hx+XM4UogePcfrY+TYALAt4t7WjKXq1GIrJEnxa
        p0DOb9O579qZ6mMlfZAUs62HYlXtzLkR9i/ufr/XuN5wpHNC8NMxlK1Wi1aj2qPIJ1fLLj/FooCkH
        IL/+nZUcBfm+3ZmKMdIvnqC2AsQY1TeGJv2efBlXiXiH8HbhO5B5DXz8BlRPtbBBedZne8APQrhpJ
        BHMbXxY1x5VSGJY8hdzmJOISRdNWGcZ7U0aCBgfgcobXV0yGDVh2EMiwwAnGpGV4ekS+EdtkbIBwD
        lfMXu01+Q==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iGWSa-0007mw-Gi; Fri, 04 Oct 2019 22:54:04 +0000
Subject: Re: [PATCH v9 17/17] Documentation/x86/64: Add documentation for
 GS/FS addressing mode
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        Jonathan Corbet <corbet@lwn.net>
References: <1570212969-21888-1-git-send-email-chang.seok.bae@intel.com>
 <1570212969-21888-18-git-send-email-chang.seok.bae@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fa9aca20-fef7-4ef4-7ab7-b5bb55679e24@infradead.org>
Date:   Fri, 4 Oct 2019 15:54:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1570212969-21888-18-git-send-email-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/19 11:16 AM, Chang S. Bae wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> ---

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> 
> Changes from v8:
> * Fixed typos (Randy Dunlap)
> * Massaged a few sentences that were previously edited by Thomas.
> 
> Changes from v7:
> * Rewritten the documentation and changelog by Thomas
> * Included compiler version info additionally
> ---
>  Documentation/x86/x86_64/fsgs.rst  | 199 +++++++++++++++++++++++++++++++++++++
>  Documentation/x86/x86_64/index.rst |   1 +
>  2 files changed, 200 insertions(+)
>  create mode 100644 Documentation/x86/x86_64/fsgs.rst


-- 
~Randy
