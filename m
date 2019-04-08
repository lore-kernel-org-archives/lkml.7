Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,SUBJ_ALL_CAPS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7867C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AC420855
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfDHITV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:19:21 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:57787 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfDHITU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:19:20 -0400
Received: from [192.168.1.110] ([95.118.113.209]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MF3Y8-1h6s4E2NWi-00FRSL; Mon, 08 Apr 2019 10:19:18 +0200
Subject: Re: PRINTER BUG LINUX MINT 19 TARA
To:     khz2020@protonmail.com, linux-kernel@vger.kernel.org
References: <781cc46d-4b72-149e-5594-6aedf1d11a7b@gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <bbe8ffa7-a074-cd34-1537-43abb5daeb44@metux.net>
Date:   Mon, 8 Apr 2019 10:19:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <781cc46d-4b72-149e-5594-6aedf1d11a7b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:LAmfSQVsCvmF5ztJSjevR6YWYvyz2FQUigCkH9WvudpToqX0XJQ
 30gjDbF5IfyWII5bmuuRJSpfpA/aNnzEVJGgJnflJSUfitjhlAAkJUU9qk2MaTRPdMtw9pY
 q0MKhv5FMuyUPmyS6AawA5Ndxd1d9Y/2uxnIcLr9lrXsll2fZfCt6v5ruH07HrM+OLZS/so
 DBA7yP87jhvXMkwsMrr/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JVBMZZuscak=:MqLMJC8YQKhVw2tYKpekZW
 fRK1Qo4hlMXeNSNa9mIm63wGs1I86AZTClDjAQ3LUqL/Y2rIwgeFsOMuCzugq64B1jvuU6tpj
 KdgjhO+a05j6+LCAx1kfmZ3cvBJvyRVYCmN1oEdqASP9nDATksP9zek589VyHQOyxVG565ZyW
 q0tCnFA8+YEhBg2Hu5qta6dk4igC/icj64+vVFIaI7leLxCYsDURa6Tjq6UOWBaLihorRg4KH
 OwUASjoOFnuprcDce0AYiU37aZ2Gd0FL+qkrdC3FyoRFOjiOM+W5df67ouTsJuTWVt0pZRkrt
 PApfLcu48OHMSYXJdyievwUAf5mJ3AAmn5QmYrSblZiN+f7N04Sro1A2uNgDBYQQoX0yEOeZg
 +NehKDviGsRXRMoCHZJiz7E5U5qhWiKguE3bAWj8OMTVXhTPYz/0l+8Qqwi0pedIgQ0HxQ7wS
 sauT+wvuBCWhdEfNVNT/2DKZbg3886Cch4+ss1Cg1FFc/Pv9YMmTWgs8LxwxPYwXTZXXsXKSP
 26N/hIhPlOAlT/Nsr76936/PPx/vs28Kb4ndgqJlxcH8eVwzwp1kbcSWph7xFAMwQmJN4vN57
 tQxSzZUFzZbVvhYo9e4XFEhXqUTsm8oBAuulkqXarAYslmnI+WWDmI8VQp0fRD01VmRP0RWYU
 eT4FS8yvkGxgSi/NWGiReBfxeQvFcynebYA7t88iSyjQ4L8L5dkX2Y30sBQU+u/KfBqEsWZgm
 +HiJCB2QEHQ/HQ10FBFS6a+TnhACx+pLSg8tUnLF9cUg45HmUhc8mBq7r7M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.04.19 23:09, Khz2020 wrote:
> Please see attached. It was working fine prior to installing Canon linux
> drivers. CUPS disconnect maybe?

Wrong list. This maillist is about the linux KERNEL, whilst your problem
is about CUPS. So, please ask the CUPS folks.


--mtx


-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
