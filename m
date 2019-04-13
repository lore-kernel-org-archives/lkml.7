Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8335DC10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 04:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5114721721
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 04:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jpUQ352X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfDMErj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 00:47:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50736 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfDMEri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 00:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2Dh3GGs22YluefED34AX/27KxH9v+gxJ3pkwF7mrTz8=; b=jpUQ352Xw3I2J9xTqK8m+j2mzU
        YXNC/qWmPizrGbRWTpJktLPwUwUSL15M1EGjZ/r52KzRNeqNvPfU5aDRTOaJakTCSxeXfsePTOGXI
        yvjlYd5sbjWbuzAkbz6WvMjI79RflGsRVd9lpG/ujOz2WDs4uWEazk3w/0H9T8/3FZLlrfcYOFnC1
        eXYnJ5KbufASa8o5Daq7NeiuNUZe6ABA6c5DHhi9vdWJWF8y+rYKf7laLqKo/nuAFCcC098y2nexP
        W6ISgxu9qGVMViW/O1fTW4OrAt3kDEifq2dtm7mdn+3kpPaep42O7HPBYCDQ5HlYrMOM6DStgx60G
        C9V0V17A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hFAZX-0006KY-1E; Sat, 13 Apr 2019 04:47:23 +0000
Subject: Re: [PATCH] Documentation: Add ARM64 to kernel-parameters.rst
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jon Masters <jcm@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tyler Hicks <tyhicks@canonical.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Price <steven.price@arm.com>,
        Phil Auld <pauld@redhat.com>, Jonathan Corbet <corbet@lwn.net>
References: <cover.1555085500.git.jpoimboe@redhat.com>
 <24039e1370ed57e8075730c0b88c505afd9e0ab7.1555085500.git.jpoimboe@redhat.com>
 <25174c3c-0e39-0562-7d02-bb7d51cd2b43@infradead.org>
 <20190413035621.tohihjksatqushwf@treble>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b18a62ef-f3b7-4ae7-ad55-820fdd82d9e4@infradead.org>
Date:   Fri, 12 Apr 2019 21:47:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190413035621.tohihjksatqushwf@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/19 8:56 PM, Josh Poimboeuf wrote:
> Add ARM64 to the legend of architectures.  It's already used in several
> places in kernel-parameters.txt.
> 
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
> index b8d0bc07ed0a..0124980dca2d 100644
> --- a/Documentation/admin-guide/kernel-parameters.rst
> +++ b/Documentation/admin-guide/kernel-parameters.rst
> @@ -88,6 +88,7 @@ parameter is applicable::
>  	APIC	APIC support is enabled.
>  	APM	Advanced Power Management support is enabled.
>  	ARM	ARM architecture is enabled.
> +	ARM64	ARM64 architecture is enabled.
>  	AX25	Appropriate AX.25 support is enabled.
>  	CLK	Common clock infrastructure is enabled.
>  	CMA	Contiguous Memory Area support is enabled.
> 


Thanks.

-- 
~Randy
