Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4344DC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 10:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F49920844
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 10:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfGIKhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 06:37:38 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:33209 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfGIKhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 06:37:38 -0400
Received: from [192.168.1.110] ([95.118.92.226]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MplPh-1iH4yY3Kxx-00q8wh; Tue, 09 Jul 2019 12:37:36 +0200
Subject: Re: Warnings whilst building 5.2.0+
To:     Chris Clayton <chris2553@googlemail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <df7c7cfc-25cf-5b92-91ab-ac355b660233@googlemail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <d5f09396-a562-7989-8e5b-8337c9c9a036@metux.net>
Date:   Tue, 9 Jul 2019 12:37:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <df7c7cfc-25cf-5b92-91ab-ac355b660233@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:dKDN0nMkR2Ju5gqh04hUCgVnYRDJDcRvO51FCIWn/Bzm5m1DR9x
 kRMF6hXOZLr5H3tRnOZEvItCFPaWsHTP9NhWmASCBxGzZCZYMpZPdCLgAdIEXUwArBJF7lC
 7+xwLpG3QPGjZranQTAR7MyrKzn+T4z/UoKcYcaVJGCeGeXrAinogKxn7PVPl9qPeyeLyoU
 HdrVQn5Ctk7APrd9Y/xog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iT0qN5Zs+C8=:XRCmPoHlMUiqD0KoI3va0c
 PAF1PeeCd/jABj80GAgslxcOLVgtpqmqu4O170J9kyPOUuxo/8VU9SN+OMNAelyRCxWUZyhMs
 n91J7QE0wRRuetZJIDGh8xz1DLWC8pVtvnV/IdUooearBhHVI847gRzf8qsSNyu2hHeV9sCcg
 WUE5EMSfV/pSFEqb6SjrKLoQ/e5BdKhbgOrzJpYPEf3HQlUAN8nHOf43gkikc5Ue8wiXdFUkX
 OQnIJPe2sntCKwuExtqpk4qHg8mWt0LTIFVgousKygDi3VFgZZ0YDS+hcR7zf5ZWWCh0BalAH
 P151LpjTxt+H5oiCpynTae7T94YwvXpwQHLUiGAoaspN5mmFvH8FzH5gxakkVn6jUx2wFIGWO
 yxHdzExznQw8L/aBhbDc9N5ip4yYmBy0aSTOZFUgRlPh0comEjdFFrcMMILwCL4tAGtQYEHNZ
 6XCa4ROXtD0mr6fKSuVpD8mpXoN8pNxcZEt/DsMUVeopS5f+EPwPHdcf1XL2SRlXUGMOM9rwq
 APTuCXNEYBs0ZkM1Kkr5Uh07xLW+8noT8DdqTSXolEOkadg6VCpimC5fFBXAneZ7NbBX53Ejr
 msIeZiLdQVThLD+PnkIFT/LkP+swS/aih2xpoqNp78COV0htSqFZ6qqpZtXLC768RzFEoTkIa
 gF9ZnL7ho35iwp7LccxLPVU87Wmz8XQBBQub2m0IAI5Qecn7AeHewnt4gJVCoT68Gb/nqtp+B
 ZNKCTLAsGEvyN4d1WdFHXpplINXaXrET0FHdb5uWGL3HCfLMBSi8AsMW5XA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.07.19 08:06, Chris Clayton wrote:

Hi,

> I've pulled Linus' tree this morning and, after running 'make oldconfig', tried a build. During that build I got the
> following warnings, which look to me like they should be fixed. 'git describe' shows v5.2-915-g5ad18b2e60b7 and my
> compiler is the 20190706 snapshot of gcc 9.

Thanks for the report. I'm rebuilding right know anyways, so I'll look
out for it.

> In file included from arch/x86/kernel/head64.c:35:
> In function 'sanitize_boot_params',
>     inlined from 'copy_bootdata' at arch/x86/kernel/head64.c:391:2:
> ./arch/x86/include/asm/bootparam_utils.h:40:3: warning: 'memset' offset [197, 448] from the object at 'boot_params' is
> out of the bounds of referenced subobject 'ext_ramdisk_image' with type 'unsigned int' at offset 192 [-Warray-bounds]
>    40 |   memset(&boot_params->ext_ramdisk_image, 0,
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    41 |          (char *)&boot_params->efi_info -
>       |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    42 |    (char *)&boot_params->ext_ramdisk_image);
>       |    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./arch/x86/include/asm/bootparam_utils.h:43:3: warning: 'memset' offset [493, 497] from the object at 'boot_params' is
> out of the bounds of referenced subobject 'kbd_status' with type 'unsigned char' at offset 491 [-Warray-bounds]
>    43 |   memset(&boot_params->kbd_status, 0,
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    44 |          (char *)&boot_params->hdr -
>       |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    45 |          (char *)&boot_params->kbd_status);
>       |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Can you check older versions, too ? Maybe also trying older gcc ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
