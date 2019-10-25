Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA58CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4276E222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfJYT2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 15:28:07 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44743 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfJYT2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 15:28:07 -0400
Received: by mail-qt1-f196.google.com with SMTP id z22so4903649qtq.11;
        Fri, 25 Oct 2019 12:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CzMMsMrSkm3rm7Rium87GUG3E2V7vUHhdCpiWBcDQKw=;
        b=LYbewjTVAApXV+AKpK4wNVHkmFKAV/kFlS/FsXDWutHRoZT6JFyy2CGC2ryqXP1AjX
         cbeg8gVroTnYl+p2TAfC3x/QPCYtI2sDux2mhn3RkEJyrEc/n6S3AdZDquSHr7dlgbHN
         pPo5YODC301IyjHCh+2JeZ+FVJWnv/Hup/7XuEA3+uXuGpRWWR5xtT5tMgHwJ9Ff5s6L
         5SVaypclrnl6tHDzMxERLbI2UmUPGB0cJUPplRj6qwmgznyBaKMB8yFK1X89GeBoQMFJ
         A0j+W7U3IHHlna6R7xNbBChBTEz//srCrCr698BI8qi1YKSmprnI6uJZbKMrRt+pe0BW
         FjBA==
X-Gm-Message-State: APjAAAVi3YeDjGT/7c0oYh06Xjz5CvV3Z33HNL8D5bwmJbolw3zKMijv
        BPVJP/t1cVHsnrFi6f9SjOC7EbUjD0Y=
X-Google-Smtp-Source: APXvYqxYaWOX88EtFy1OKQmONuRL2fbSamE0YS+v2Oas5D3gPYtDocSOlJ747BQlv8I8DRl3+CuiMg==
X-Received: by 2002:ac8:22f1:: with SMTP id g46mr4881761qta.12.1572031685848;
        Fri, 25 Oct 2019 12:28:05 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id q204sm2160934qke.39.2019.10.25.12.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 12:28:05 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id t8so4949318qtc.6;
        Fri, 25 Oct 2019 12:28:05 -0700 (PDT)
X-Received: by 2002:ac8:6683:: with SMTP id d3mr4815167qtp.286.1572031684902;
 Fri, 25 Oct 2019 12:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191024152833.30698-1-geert+renesas@glider.be>
In-Reply-To: <20191024152833.30698-1-geert+renesas@glider.be>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 25 Oct 2019 14:27:53 -0500
X-Gmail-Original-Message-ID: <CADRPPNT8QTbnLo+Oqsqm6c04XJEvwZOaijBb0VcB2_QenjKxgg@mail.gmail.com>
Message-ID: <CADRPPNT8QTbnLo+Oqsqm6c04XJEvwZOaijBb0VcB2_QenjKxgg@mail.gmail.com>
Subject: Re: [PATCH trivial] usb: Spelling s/enpoint/endpoint/
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, Bin Liu <b-liu@ti.com>,
        Jiri Kosina <trivial@kernel.org>, linux-usb@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 1:09 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Fix misspellings of "endpoint".

It is amazing that we have the same typo in so many different drivers. :)

>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Li Yang <leoyang.li@nxp.com>

> ---
>  drivers/usb/dwc2/core.h             | 2 +-
>  drivers/usb/gadget/udc/fsl_qe_udc.h | 4 ++--
>  drivers/usb/gadget/udc/mv_u3d.h     | 2 +-
>  drivers/usb/musb/musb_gadget.c      | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
> index d08d070a0fb6f598..968e03b89d04d5d8 100644
> --- a/drivers/usb/dwc2/core.h
> +++ b/drivers/usb/dwc2/core.h
> @@ -134,7 +134,7 @@ struct dwc2_hsotg_req;
>   * @target_frame: Targeted frame num to setup next ISOC transfer
>   * @frame_overrun: Indicates SOF number overrun in DSTS
>   *
> - * This is the driver's state for each registered enpoint, allowing it
> + * This is the driver's state for each registered endpoint, allowing it
>   * to keep track of transactions that need doing. Each endpoint has a
>   * lock to protect the state, to try and avoid using an overall lock
>   * for the host controller as much as possible.
> diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.h b/drivers/usb/gadget/udc/fsl_qe_udc.h
> index 2c537a904ee73950..53ca0ff7c2cbd48c 100644
> --- a/drivers/usb/gadget/udc/fsl_qe_udc.h
> +++ b/drivers/usb/gadget/udc/fsl_qe_udc.h
> @@ -333,8 +333,8 @@ struct qe_udc {
>         u32 resume_state;       /* USB state to resume*/
>         u32 usb_state;          /* USB current state */
>         u32 usb_next_state;     /* USB next state */
> -       u32 ep0_state;          /* Enpoint zero state */
> -       u32 ep0_dir;            /* Enpoint zero direction: can be
> +       u32 ep0_state;          /* Endpoint zero state */
> +       u32 ep0_dir;            /* Endpoint zero direction: can be
>                                 USB_DIR_IN or USB_DIR_OUT*/
>         u32 usb_sof_count;      /* SOF count */
>         u32 errors;             /* USB ERRORs count */
> diff --git a/drivers/usb/gadget/udc/mv_u3d.h b/drivers/usb/gadget/udc/mv_u3d.h
> index 982625b7197a0d9c..66b84f792f646bb9 100644
> --- a/drivers/usb/gadget/udc/mv_u3d.h
> +++ b/drivers/usb/gadget/udc/mv_u3d.h
> @@ -138,7 +138,7 @@ struct mv_u3d_op_regs {
>         u32     doorbell;       /* doorbell register */
>  };
>
> -/* control enpoint enable registers */
> +/* control endpoint enable registers */
>  struct epxcr {
>         u32     epxoutcr0;      /* ep out control 0 register */
>         u32     epxoutcr1;      /* ep out control 1 register */
> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> index 2cb31fc0cd601eb4..f62ffaede1abba48 100644
> --- a/drivers/usb/musb/musb_gadget.c
> +++ b/drivers/usb/musb/musb_gadget.c
> @@ -1315,7 +1315,7 @@ static int musb_gadget_dequeue(struct usb_ep *ep, struct usb_request *request)
>  }
>
>  /*
> - * Set or clear the halt bit of an endpoint. A halted enpoint won't tx/rx any
> + * Set or clear the halt bit of an endpoint. A halted endpoint won't tx/rx any
>   * data but will queue requests.
>   *
>   * exported to ep0 code
> --
> 2.17.1
>
