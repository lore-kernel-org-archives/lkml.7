Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75020C31E54
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 22:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CAB220866
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 22:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfFPWBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 18:01:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42113 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbfFPWBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 18:01:07 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hcdCt-0000KR-Bn; Mon, 17 Jun 2019 00:00:59 +0200
Date:   Mon, 17 Jun 2019 00:00:58 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v7 18/18] x86/fsgsbase/64: Add documentation for
 FSGSBASE
In-Reply-To: <9DA78352-E4B8-4548-A593-35F4339AB1F9@intel.com>
Message-ID: <alpine.DEB.2.21.1906162356390.1760@nanos.tec.linutronix.de>
References: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com> <1557309753-24073-19-git-send-email-chang.seok.bae@intel.com> <alpine.DEB.2.21.1906132246310.1791@nanos.tec.linutronix.de> <EEACF240-4772-417A-B516-95D9003D0D11@intel.com>
 <89BE934A-A392-4CED-83E5-CA4FADDAE6DF@intel.com> <alpine.DEB.2.21.1906161038160.1760@nanos.tec.linutronix.de> <alpine.DEB.2.21.1906161433390.1760@nanos.tec.linutronix.de> <62430B9C-95B6-4EB3-94FA-C16A02B9BD7C@intel.com> <alpine.DEB.2.21.1906161804570.1760@nanos.tec.linutronix.de>
 <9DA78352-E4B8-4548-A593-35F4339AB1F9@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jun 2019, Bae, Chang Seok wrote:
> > On Jun 16, 2019, at 09:05, Thomas Gleixner <tglx@linutronix.de> wrote:
> diff --git a/Documentation/x86/x86_64/fsgs.rst b/Documentation/x86/x86_64/fsgs.rst
> index 380c0b5..d5588e00 100644
> --- a/Documentation/x86/x86_64/fsgs.rst
> +++ b/Documentation/x86/x86_64/fsgs.rst
> @@ -125,7 +125,7 @@ FSGSBASE instructions enablement
>  FSGSBASE instructions compiler support
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  
> -GCC version 4.6.4 and newer provide instrinsics for the FSGSBASE
> +GCC version 6 and newer provide instrinsics for the FSGSBASE
>  instructions. Clang supports them as well.
>  
>    =================== ===========================
> @@ -141,7 +141,7 @@ code and the compiler option -mfsgsbase has to be added.
>  Compiler support for FS/GS based addressing
>  -------------------------------------------
>  
> -GCC version 6 and newer provide support for FS/GS based addressing via
> +GCC version 4.6.4 and newer provide support for FS/GS based addressing via
>  Named Address Spaces. GCC implements the following address space
>  identifiers for x86:

That's close to what I pushed out earlier into tip WIP.x86/cpu

Please check against that version including the Clang part about address
spaces close to the end.

Thanks, 

	tglx
