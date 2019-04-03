Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E2EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497AF20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfDCUWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:22:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40680 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCUWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:22:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id q66so27112ljq.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 13:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6NmzaRE2KuRsUb9pmRvDvFplvc2ofTKDK9x2YK/2hd8=;
        b=IKoRRDLQk9qvd5xgf2T3lLbkdFyP8kqoYXSfu5LsnVNKQnJoPvuHGj0tZhWcWlQwJR
         kiahv3JTYYI2yPDC1RnOZCj9KBk5BLux1UlnkHrG77arT1H5dyFZsuQiFLJ7uaho4l75
         335D0/zmCbfYTtGCw2XDIZgJM+ngBG9RUe5AlZZZE1ZGblW0XTMJNGa/E3lbhas2rpHn
         T6Cvm/XTqvRxPYjscURH0RdK256izlRqjg2nmxHtZkn8Vzb/StYJOSWla0IxEq5f5mwG
         7SRyTi2saSzbUuysnKsedm6o/usD8tBIHBSP45RK1HDcGlwq+P9pUMowz9GQ70PK7JiE
         xpnw==
X-Gm-Message-State: APjAAAX2Foi8eT4QEdqXEWzgpxPq7gW3vr3KhJOFi7ilpQKGECsQ8pKY
        ea2tSy5EtQ+duUU1f8MgWjB0l35TTx6gxA==
X-Google-Smtp-Source: APXvYqyryOPGm/HaLPpLFiAqFOXj1Bbjf/jF2bTk7p5j88iOUdWE4cSUZEodEaOWWoi54PaVhJ7Cmg==
X-Received: by 2002:a2e:910b:: with SMTP id m11mr1104601ljg.14.1554322936746;
        Wed, 03 Apr 2019 13:22:16 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id y7sm1084835ljj.34.2019.04.03.13.22.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 13:22:15 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id v22so16921lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 13:22:15 -0700 (PDT)
X-Received: by 2002:a2e:2f06:: with SMTP id v6mr1034031ljv.139.1554322935620;
 Wed, 03 Apr 2019 13:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190403184212.7704-1-martinsdecarvalhobeatriz@gmail.com>
In-Reply-To: <20190403184212.7704-1-martinsdecarvalhobeatriz@gmail.com>
From:   Helen Koike <helen@koikeco.de>
Date:   Wed, 3 Apr 2019 17:22:02 -0300
X-Gmail-Original-Message-ID: <CAPW4XYZpmPaP01UQbKFQSMh_FT20M467zhuETNwcHwbNP4uFoA@mail.gmail.com>
Message-ID: <CAPW4XYZpmPaP01UQbKFQSMh_FT20M467zhuETNwcHwbNP4uFoA@mail.gmail.com>
Subject: Re: [Lkcamp] [PATCH] staging/rtl8723bs: Fix code indent.
To:     Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Beatriz,

Thank you for the patch, just some small comments.

Regarding the patch title, if you run

    git log drivers/staging/rtl8723bs/hal/hal_com_phycfg.c

You will see that commits starts with the following tags "staging:
rtl8723bs: <commit title>"

Also, try to add a bit more information to the title, for example:

"staging: rtl8723bs: replace spaces by tabs"

See my other comments below:

On Wed, Apr 3, 2019 at 3:42 PM Beatriz Martins de Carvalho
<martinsdecarvalhobeatriz@gmail.com> wrote:
>
> Fix Error: code indent

Please, add more information to your messages, you can add which
checkpatch error you fixed.
See this example: https://lkml.org/lkml/2019/4/2/1184

Please, re-submit version 2 of this patch, it should start with: [PATCH v2]
If you are using git send-email, you can use the option "-v2" and it
will fix the title for you.
Remember to add a change log, see this example:
https://marc.info/?l=linux-kernel&m=154201089629031&w=2
See the change log after the "---". It is important to be after the
triple dashes, as this is a comment to help reviewers and it is not
meant for mainline.

I hope this helps! Let me know if you have any questions :)

Regards,
Helen

>
> Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
> ---
>  drivers/staging/rtl8723bs/hal/hal_com_phycfg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
> index 828b328adab8..fc49cdfcd477 100644
> --- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
> +++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
> @@ -1723,7 +1723,7 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
>         idx_rate_sctn = get_rate_sctn_idx(data_rate);
>
>         if (band_type == BAND_ON_5G && idx_rate_sctn == 0)
> -                DBG_871X("Wrong rate 0x%x: No CCK in 5G Band\n", DataRate);
> +               DBG_871X("Wrong rate 0x%x: No CCK in 5G Band\n", DataRate);
>
>         /*  workaround for wrong index combination to obtain tx power limit, */
>         /*  OFDM only exists in BW 20M */
> --
> 2.17.1
>
>
> _______________________________________________
> Lkcamp mailing list
> Lkcamp@lists.libreplanetbr.org
> https://lists.libreplanetbr.org/mailman/listinfo/lkcamp
