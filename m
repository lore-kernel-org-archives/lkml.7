Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B5DC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 06:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714CD21E72
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 06:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfGVGzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 02:55:20 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:53313 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfGVGzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 02:55:20 -0400
Received: from [192.168.1.110] ([77.2.59.209]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N63mC-1iVKPb3LNg-016NMH; Mon, 22 Jul 2019 08:55:15 +0200
Subject: Re: [PATCH] dlm: fix a typo
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        ccaulfie@redhat.com, teigland@redhat.com
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190721104322.30019-1-christophe.jaillet@wanadoo.fr>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <e561b3e8-e3da-b81c-2b06-3be4fa3d1c61@metux.net>
Date:   Mon, 22 Jul 2019 08:55:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190721104322.30019-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:WUcKhSRu2LzHxsqlmB2enuu41lBDRBmM2VCO0NzFt7XwBzKQuiM
 3PEK+t7coQYBM8Bjdh2qETSuphYhiOZBL8qqOLimcvuNX/0ohijyDHhDtiIYy/2VEurSEZX
 Dt9D8rWPJ90wgPB4GHmsgONEj2AO2v/iRPcuk1bDM9zP3K13uLkkfuGh9KZFbmI1gSA9ExP
 SDd1nBVWLxHbb1NTZbVdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sp/dw0gAHtc=:ox9lL5rXoR6AXdosyyp03k
 fZaPimwr1pX2ZTyY56vGvnBjFpw1spxhvik5RJaXZyF/Q8g/tkVvvmNBu1jLKuhDyLogZBDe2
 4QWGNFl6pU/PXc5T5xtgq3PPDfp9dia3rNDEhm4QvttX/y0bBk7Sx9BzjTEfrX0lZ3HhI/rZg
 ooVEvYbGjm5RtY9na6cZXJU0sqG9E+5qAkijdxRthXcAqPFWzpfHacMJkubsXq2XCu2NWVvOv
 C3z2sjn+KXzWJCJHsylP1DRbfoPmsrEz6A4sN7taq+CJyy0H2Bp44+f5Xtz0rEGZy9QZ3oX1x
 qnOD2D/GnbrxEHCAF+DapoViQKPUuJnm4/Xe4/MQAAHT+iUVC8IQi7Co6RRPDSr8lkZKUvUXy
 yW0dvsDyshxl3ppBprNOhfA/xeFxDJy5M5lh+sAV/Wame+HcvPpLKHr2LxvlLdD0H7tFqKCV6
 Eu2SzHwz0N7EWdc+RzNWhox087Foa7bWp8Y4mBYzsyO408XWOy4krYSIvz1Cl89NxbfAeLsrC
 iNnmyN7OcnHP7O3etYjtVF944kYm5623wvbfMzO0w+ao5WeqHRSgvg3Q47nAi98vgWT3yXs/U
 0GBGaKWvLu/5JwznwYEAQzjXGXeN3EPUh3p3AF7Jvl8NhBFF03GV4AZW/i9to/hkvbSFVk4rJ
 HdAYTloPfppo3KhLUWuyUCAbsi4a8mgThqIiWAY0gbKqhklo0k5wHoNrDCWoS5QTBVaOyrxf7
 KK+JoIIKhtHbXFQ4XmtRaoL7gfvWRaIfpudd8ylfy6jiIs0h8kltHLkGckc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.07.19 12:43, Christophe JAILLET wrote:
> s/locksapce/lockspace
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   fs/dlm/lockspace.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
> index 00fa700f4e83..9c95df8a36e9 100644
> --- a/fs/dlm/lockspace.c
> +++ b/fs/dlm/lockspace.c
> @@ -870,7 +870,7 @@ static int release_lockspace(struct dlm_ls *ls, int force)
>    * until this returns.
>    *
>    * Force has 4 possible values:
> - * 0 - don't destroy locksapce if it has any LKBs
> + * 0 - don't destroy lockspace if it has any LKBs
>    * 1 - destroy lockspace if it has remote LKBs but not if it has local LKBs
>    * 2 - destroy lockspace regardless of LKBs
>    * 3 - destroy lockspace as part of a forced shutdown
> 

Reviewed-By: Enrico Weigelt <info@metux.net>


-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
