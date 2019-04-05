Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8083EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510BD217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbfDEIjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 04:39:54 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:45045 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730081AbfDEIjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 04:39:53 -0400
Received: from [192.168.1.110] ([95.114.101.225]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MJmbB-1hVvho3Uj3-00K8oR; Fri, 05 Apr 2019 10:39:45 +0200
Subject: Re: [PATCH] tty: Add NULL TTY driver
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     jslaby@suse.com, linux-kernel@vger.kernel.org
References: <20190403113327.3628-1-vincent.whitchurch@axis.com>
 <20190403131213.GA4246@kroah.com> <20190403141109.3mdmqbt3mjxrie6k@axis.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <e8b1618a-545b-ee35-ec51-f831cbdff7fa@metux.net>
Date:   Fri, 5 Apr 2019 10:39:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190403141109.3mdmqbt3mjxrie6k@axis.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:tJkoEXbqx7WW9kA3Pxz0gA437JyXrMyV6shrguo+19TwCUFnhup
 TYOAQ1VQ9GX9XbgwhBMC0l4LDFBVs3xA3PG5nt51N/9IP6qUQSAU4p8gKk+OoEBHvpRf/kw
 xCya0M628CKER7FbeEtpChF6LbXdLJ9eHXq/sZUBx4cBRtZHzj70o2eUUnMivuXDZXK6hez
 2NEFQbekGaB+yKmu2yuBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iCgrYj7tmN4=:B8EyoMsUbtBE/jZ7n6SOla
 fYpQoidS4K/d0xlwxyHniz4Je2hzmMX5+Hg0cKiX9EowOdBWyq3j5usKAaefp4t6cQyDXLF5Z
 EQYYWrG2gYDrXRGddLlU3UDbxfwwQdolt7FZtqGoz8s0IVmmBSYHnHH1ODQMOGKh8NnxVy34r
 hLygT/PS41R6DrhBfJJ9Z9zfpDDuoOkAoUTsZZfk94+1uImuda4fOZXc9UVBSo/H0l9QC95sJ
 02xuDOlJs/n165vXmD+67+F09JeuMVn2oLU1RzGSmQzFBpgu1gkhP6LBkonTa7x43OHtN3IWj
 ih47yFH8s+QOSO4YhTkWGYaJfJtpDB0TGR9zarVyhZdy35G6ovtawqdx40ft1ht55XjXqZI9F
 8/xDA0tNakzX0giRBAMt13iyL7y9dXUbGwaIWq+6OormDMzUIUMWZ6K4sD+h5dHE5ALRbmKNb
 j8/5r4e3pAqW9hjBQfN/dwV+AObnS9qTEPi0jjzFW1RNaSnkotFFUsc1fPSNar0nm1gvmrKl/
 Bmr4MVo74YOBfyYCAxMZQ7v3f1lDFtLp2vqMiUW3ZkiYVeWMLfIVjnUEef0HoMavx9T2qhgQo
 ivEQcTJEuRVsMUHwed/nvWSXvU3ZSNowmYlIN8wyaQC7HZx1xIl7Lq/FynNSyPBNFzwWcqX8f
 2QjZ6c6mlekfop3w6ylppgArSr+U7AsUWHtOFEQ6NQpRn0CckTsDNHIq5+7QTyS2OD6FP0gs5
 kBkZmDIj30g7C1EEDxdSM+Jd8Z3jVNRCCwCNV7HcGHD8Bz9zvhhg2Lsymts=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.04.19 16:11, Vincent Whitchurch wrote:

> Especially on embedded systems, it would be convenient to have a simple
> way to disable the console (both for kernel and userspace) on a system
> which normally uses it, to free up the UART for other things.

Just symlinking to /dev/null does not work ?

OTOH, if you're introducing a dummy console, wouldn't a ringbuffer that,
can be read out later, a better option ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
