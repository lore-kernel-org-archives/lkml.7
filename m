Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F920C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74932070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfCDWGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:06:50 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45301 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDWGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 17:06:50 -0500
Received: by mail-oi1-f194.google.com with SMTP id t82so5164622oie.12;
        Mon, 04 Mar 2019 14:06:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yEyot52pk8Ldlk5r3GKuiPyQ5a4ywT/yX936T5Y6ff0=;
        b=ATePOj1t9xL6Z/IumBxT0Uame8/eTcc3+GaK7FDSuw59eGW44vDVrIDcFFltBM2NGG
         m4kHeg0WB/SG6Autjd41zD2zZcbK0ZeP6p2PF7jNveXG2AC2A6sYA+hn453keoXbGLVH
         PUQBdKLBomTvgD9eHuKv/bW9ZwnIorlWYHFevuj+acFlxvl+F3Sx990gq90p6APsuhqA
         7TdXnDC3yySqMs3hi4iaZ2QYnE1+FCHqPpIL5oGBTXO3qRtHCQmPTowK1dSvKvN74Jf6
         Qfk4DW5EQHBhDbexkfqfS6asUjrCGcOfqwX595DlT+j/VrVnfi71WrVLElMcw5G5IkT8
         67Vw==
X-Gm-Message-State: APjAAAVUAR3iGo1lVDBJpfaZ4mygyM0P/Q28qZu9Hof6VIIECYJlWdBc
        LcW8uLuHzhHph9WlHtlfJWLYRht3w981rmBN8Zo=
X-Google-Smtp-Source: APXvYqySnGNHTEf0RC32XYkwTimUuJwqyBkjf0cn1Dhp5/eEdoNLQvAYmTww+uMfALKH1NUayiQP8OWBdndWMcWksuA=
X-Received: by 2002:aca:c2c4:: with SMTP id s187mr9484oif.175.1551737209456;
 Mon, 04 Mar 2019 14:06:49 -0800 (PST)
MIME-Version: 1.0
References: <20190304035744.155203-1-alex.shi@linux.alibaba.com> <20190304035744.155203-2-alex.shi@linux.alibaba.com>
In-Reply-To: <20190304035744.155203-2-alex.shi@linux.alibaba.com>
From:   Li Yang <leoli@freescale.com>
Date:   Mon, 4 Mar 2019 16:06:38 -0600
Message-ID: <CADRPPNT6=848XjB3uNAhgDRwFb+KsLY7pR3xFVaMLkGjqGpy5g@mail.gmail.com>
Subject: Re: [PATCH 01/20] docs/zh_CN: add disclaimer file
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     =?UTF-8?B?TGludXggS2VybmVsIOS4reaWh+ekvuWMug==?= 
        <linux-kernel@zh-kernel.org>, linux-doc@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>, harryxiyou@gmail.com,
        Jonathan Corbet <corbet@lwn.net>,
        Li Zefan <lizefan@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Coly Li <colyli@suse.de>,
        Federico Vaga <federico.vaga@vaga.pv.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 3, 2019 at 10:03 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
> This a disclaimer file which will be included in Chinese files
> as header. To reduce the same common contents copy.

It is great for reducing the duplication.  But since this is in the
translation folder, probably it will be even better to include a
translated version of this disclaimer too?

Regards,
Leo

>
> Most of contents quoted from Federico Vaga's file:
> Documentation/translations/it_IT/disclaimer-ita.rst.
> Thanks a lot!
>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Harry Wei <harryxiyou@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Li Zefan <lizefan@huawei.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Fengguang Wu <fengguang.wu@intel.com>
> Cc: Coly Li <colyli@suse.de>
> Cc: Federico Vaga <federico.vaga@vaga.pv.it>
> ---
>  Documentation/translations/zh_CN/disclaimer-zh_CN.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/disclaimer-zh_CN.rst
>
> diff --git a/Documentation/translations/zh_CN/disclaimer-zh_CN.rst b/Documentation/translations/zh_CN/disclaimer-zh_CN.rst
> new file mode 100644
> index 000000000000..0de5dfb069ca
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/disclaimer-zh_CN.rst
> @@ -0,0 +1,11 @@
> +:orphan:
> +
> +.. warning::
> +   The purpose of this file is to be easier to read and understand for Chinese
> +   speakers and is not intended as a fork. So, if you have any comments or
> +   updates for this file please try to update the original English file first.
> +
> +.. note::
> +   If you find any difference between this document and the original file or a
> +   problem with the translation, please contact the maintainer of this file,
> +   or get help from Alex Shi <alex.shi@linux.alibaba.com>
> --
> 2.19.1.856.g8858448bb
>


-- 
- Leo
