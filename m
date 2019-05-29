Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09A2C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB2724198
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfE2Ux3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 16:53:29 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:40221 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfE2Ux2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:53:28 -0400
Received: by mail-ot1-f46.google.com with SMTP id u11so3466665otq.7;
        Wed, 29 May 2019 13:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D2+H7EZcpvU21TkBJqjVERhn4aghur1shp/MYn/imNU=;
        b=m+/sPdWc7eaXJhnfKEBLgk8Rmx0byEo9ZcvMEYGlRDmvpvNw89EfzD7FZmTYMsjo2E
         oGOwSgsOKAXqcXDMzkkN/3+aKBkzxjVKC3/ha0YVYksOpj7c0C0+DHisu4zV3Ju+uzya
         vRHJuBS4PDH9EFzWEXKNBxt6rYztxVpgpBYKMzPumIz8ZP2TDkEOtmQ8Z33rVFMpQ06s
         +BVlnA9XUFM1wJXAdxuKxih6xV+P3zgcTiMuwhsCaIngTa5x6g3rf1+ZPulUtBnkHT7R
         g9F1XDEhN3o+JUR4D9gUHrfUsYZ6XcMx6vlHVUTxFwwS41MEhpchtTsmw2Tvun9N7UcP
         LS3Q==
X-Gm-Message-State: APjAAAW/GwpB+/wAOJsq83tVF/q8lf7xQD66Pc7G29nmx3w006TOymP/
        fmIH1tsNa4ivVRyQ22QbeDT77cV9
X-Google-Smtp-Source: APXvYqze83Zg9NsuFA/4G0fUXNF0IB2o4nEyhx+YjVb9jk83eZEMbhjWnb5oXGp8UiBCfrM5CPqvwQ==
X-Received: by 2002:a9d:4b15:: with SMTP id q21mr10964705otf.139.1559163207455;
        Wed, 29 May 2019 13:53:27 -0700 (PDT)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id j189sm226274oia.2.2019.05.29.13.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:53:26 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id r7so3480576otn.6;
        Wed, 29 May 2019 13:53:26 -0700 (PDT)
X-Received: by 2002:a9d:7343:: with SMTP id l3mr58178960otk.63.1559163206194;
 Wed, 29 May 2019 13:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190521085624.13665-1-colin.king@canonical.com>
In-Reply-To: <20190521085624.13665-1-colin.king@canonical.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Wed, 29 May 2019 15:53:15 -0500
X-Gmail-Original-Message-ID: <CADRPPNS5EbVrQ_ayvs=s7fYAc4JM1DfNeXwrmCXMvk6HzPouEQ@mail.gmail.com>
Message-ID: <CADRPPNS5EbVrQ_ayvs=s7fYAc4JM1DfNeXwrmCXMvk6HzPouEQ@mail.gmail.com>
Subject: Re: [PATCH][next] soc: fsl: fix spelling mistake "Firmaware" -> "Firmware"
To:     Colin King <colin.king@canonical.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        kernel-janitors@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 3:57 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a pr_err message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  Thanks!

Regards,
Leo
> ---
>  drivers/soc/fsl/dpaa2-console.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/dpaa2-console.c b/drivers/soc/fsl/dpaa2-console.c
> index 9168d8ddc932..27243f706f37 100644
> --- a/drivers/soc/fsl/dpaa2-console.c
> +++ b/drivers/soc/fsl/dpaa2-console.c
> @@ -73,7 +73,7 @@ static u64 get_mc_fw_base_address(void)
>
>         mcfbaregs = ioremap(mc_base_addr.start, resource_size(&mc_base_addr));
>         if (!mcfbaregs) {
> -               pr_err("could not map MC Firmaware Base registers\n");
> +               pr_err("could not map MC Firmware Base registers\n");
>                 return 0;
>         }
>
> --
> 2.20.1
>
