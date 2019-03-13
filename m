Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2A9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 07:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D702171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 07:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfCMHAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 03:00:02 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:34249 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfCMHAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 03:00:02 -0400
Received: from [192.168.1.110] ([77.4.24.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MAOeB-1hBLRg0zsZ-00BrDN; Wed, 13 Mar 2019 07:59:55 +0100
Subject: Re: [PATCH 1/8] drivers: tty: serial: 8250_bcm2835aux: use
 devm_platform_ioremap_resource()
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1552402660-31730-1-git-send-email-info@metux.net>
 <1552402660-31730-2-git-send-email-info@metux.net>
 <20190312163356.GB13549@kroah.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <947da751-bbce-4364-a1bf-5487908e59a5@metux.net>
Date:   Wed, 13 Mar 2019 07:59:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190312163356.GB13549@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:KIsIBowAJU2vMgaixJueT88Sgo0gTis/cA69Juavikvf1lsCJZr
 NpfnLpwDj/7Hk8VF51cFM2Doq2rpzab9Z0B2lX4O7Xqb7qps8wwiPaH8XIu44SNQnvk2HCH
 Ja++5XX7I+wW5ukWxoegTBLQpO5PryzOe4lncliqZBbBrPhL1U2B/HnXrW35TeYB1ry9yb5
 TaOnbXeEhzA7YABxhw2eQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xeo3elJrtf0=:E339UNryCe77XGrGw91iKZ
 cs9iJgv5R7gLOpHMZu4plX7u6oghgvk4Lf+kUO1zSxT0mMSQyfGq9rUqAkZX4Lh7AYf6n82i+
 0NWJuw4eZeFWcwWUKoygU6DMTXuwXzFcnl4EJPzRiGu38A73Jg1sZLMcj6BJ5p3G5kNXYizDD
 slrqTi27WqVAi+CyMfZtZKhbqilppJ87Zp/P5RX8zbstLa/M+6zRsaEO4qByqefPQQ8S42BL9
 TVSdReEId9fXgi8ODvAJ0YmgHTpVKZUCrKHSWhsHJNnFJOp+RwW6F95HQ0q8ux8l3KzFAnF4j
 zCQng1dwlw6tc7WonixXBaxZIiZFXHMhrv0qOjenKHv8rKS0r4DbqQWXdvBrcRO1u4xxkKhxy
 /pHlDc3Skq30mq202xoMUS13dxknbGTfXyjxDV6yBFDu99LPnz8Xg0eb3uhHmJkIRThTd5WpC
 wT/EYhSf02QouKBmrSlFl+tGeaxFG33nkGna1sSCWIeRUwng02+ApHpSjRm/EMUTd6MfxyYzB
 K/Wlc3xFwdo3zvji6Pa+qB8Af0ddcDjqN4dNbUct6WmaEtZ3ma21T5+G92Nx0hcHMexr/bF1d
 cWGteCjolCUwosLy4oPPXQjWHTbG4/mhOCu6SLgVjki/upTIz5t54JxkCEgeerrapNmry51Ca
 hsmjZfxu27AgMd6KCpqQeu36iDXqW1Fu1XDnJgsaOLtgbbDHy5dFJy1sD0NYKEMo7jwE7AFDk
 PIgqrnVFPGacHF3eJpMWGKh3wfjSAeUD+NbueB/bSGYKFrIThi6btpwg8uk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.03.19 17:33, Greg KH wrote:
> On Tue, Mar 12, 2019 at 03:57:33PM +0100, Enrico Weigelt, metux IT consult wrote:
>> ---
>>  drivers/tty/serial/8250/8250_bcm2835aux.c | 12 ++++--------
>>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> No changelog or signed-off-by, sorry, please fix up the series and
> resend.

Maybe the threading got messed up somehow (at least my tbird doesn't
show it correctly), so you've probably didn't see my intro letter: there
I wrote that this is yet WIP, not meant for actual submission, instead
just to ask you folks whether my approach in general would be work.

Sorry for the confusion.

Of course, when the stuff becomes ready for submission, all these
things will be cleaned up.


OTOH, if you think some of the patches indeed were ready, but yet need
some cleanups (like mentioned missing description), just let me know.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
