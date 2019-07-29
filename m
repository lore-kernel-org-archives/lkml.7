Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05FFC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72C1206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387774AbfG2Oqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:46:42 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:34085 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387678AbfG2Oqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:46:42 -0400
Received: from [192.168.1.110] ([77.4.29.213]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MLzeb-1i9VJZ28DB-00HsEV; Mon, 29 Jul 2019 16:46:40 +0200
Subject: Re: [PATCH] drivers: tty: serial: amba-pl011: use generic ops
 request/release port
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
References: <1564411445-26933-1-git-send-email-info@metux.net>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <e831001d-0f9c-800c-94d5-7e767fa4fc5a@metux.net>
Date:   Mon, 29 Jul 2019 16:46:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1564411445-26933-1-git-send-email-info@metux.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NDOGCIwDVk1ZhvV95ebYf1KCeiiAOnqdoO+OSALd6FOaBYcdx/e
 51+1Mu0u6p4PO7O+2giflmIVZbH08qWI0oA3m2JrYganQ5VbVn7guCqV/9lWp8jHVlYMkOR
 kvWSC5RGXazv19btQJyxJ8y7Eb87VAg12gznj1/0Z7+EvZQlLBenBuBRc966v49YHTzouue
 oSHOuJZ/sPVhIkLh+XRkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QrU+R0Td6VM=:hds3pdj3lHzXrIaI8F6gk3
 ORnps68m/qG9RCCIgybbtD17hhoa2RBmB/JUj2JpBK1tWyAIM5bfibX9BbxdXZ96Y9pJpW6Ag
 CRIYV/z+9GK315norN+8lSYTn8GBn/bbTIGBLyJQ7ZKz28A17hVMq+tw6bp+gLbyEvSVz0A4s
 0q0TOExxU9S4O54HZEVPlJPxiwyP7ZUNKZksm1cQpe7Qol7NEgyyelcxBOTEAHTlMmgao0RZp
 drOjshXOhQcpwUmwldVF+A/4g7OqahIG5jQdy49zJbxO9GobO16Q4I+p/z9Cwnds+bzagL6Cn
 qGY4K6sjhtJ1mQF65CS9WM7+gN7gaP6a9a1byRDBB7GQxsL0Eqdne+49yN/VAF5NKS5Vl8VJK
 C4CnlJF6imNVjrS4GmIzHUp0cm8M178h2MdoxM02MgMYQZR5GtOPzlikxTIUuFOLqWtgpgdkm
 o5QXYL3O/kqvV0z6ED21zT9gQtnhYeg5+5R4ci1jbG2uqA6yZHFV0E5kEegZDqCelXSESkntz
 hR6EsWXNJp7QI6hhJtqN5Wjeo0YK9taI41rIPqG5zv1P7OlpGrdbXucWr71ArVru5ZI70VVYn
 Zh59dR7sCBRSg4SE8uNEOyOMUh9EQIlnLhFIDnE97p37b9jvTHwpw3IS2L5ckdjYQgtBUWbSC
 9CEQJ4t0NQ7pdxVd6fZ5k5RwH/SdL1OTTWQaxpoP0v9k6uni394PeLqyi1fb7HPZeb2MUZd88
 DAhexZ4CZJyAej9njtUh4DOjaIY2K7JYEDHRtIbZoCAdx46VfbNeb9Bqrrw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.07.19 16:44, Enrico Weigelt, metux IT consult wrote:
> From: Enrico Weigelt <info@metux.net>
> 
> Reduce boilerplate by using generic implementation of the trivial
> request_port/release_port operations. For that to work, we have to
> set the mapsize field accordingly.


Shit! Forget it. Somehow cherry-picked the wrong commit ID and forgot
to check before posting. That wasn't supposed to be sent out yet.

Sorry for the noise.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
