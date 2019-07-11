Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679E1C31E41
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3920021537
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iFaqmioG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfGKRRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 13:17:40 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34130 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbfGKRRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 13:17:40 -0400
Received: by mail-io1-f66.google.com with SMTP id k8so14278176iot.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 10:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8hnrjteetj+2DwTSHx574b1xFkzK5P+oCtU5/m2k/v4=;
        b=iFaqmioGX5kHI6dwYSirYGjsZStbgKT76VP93fBwEQSnKvT9ujYB2lU5+d1kSK3oQa
         A6dUBcfnCkw/Mb3hG674fHrhu0mzd1+4ia9bbjZbiG15LTx+Jvt7k6UxScvoriexwRm3
         cheT2fAWqReF47CPT4sC71g7OEPworWmcsXFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hnrjteetj+2DwTSHx574b1xFkzK5P+oCtU5/m2k/v4=;
        b=UZC2mhInDxRR7/Bzg8uLKot6e4U+LRHePZ3Ulgb0W/ntVO3aoZC6TBzvRNRxu6IOMd
         JiZTFzywdtiK/NUIOL+HuUQ3nF1cHaaxxa0kbcWpySd1QCWmbAT+vbgaTv9Uac/sP9vk
         zJ4UX/OgHqSPdqWVN2j7eH3Yrj7NcShiPNe/DpLvcQhoRU/83rW8o5ytG824VPsX3ANt
         UofNEZD6sXKaKxYRxW3wIGgClsp6DXB9P7cXp0+vWaszPeB6chwOWWjaWPZLdEHsiuA2
         7YYn04Ai1vJJqzY0Kamp0VVH7kfy12nP1XJNslXcVAxlR8axOTSTSOroJUE1EGr1BkE/
         cw9g==
X-Gm-Message-State: APjAAAWldDkTYw5C1cj9l2FJ1QSI8GiVgZW2rF/D0nMSz25a5MuUnz44
        7mUXIerZo7UI8KUSEpUfGgORVcOVyr5bs97N/2BoRA==
X-Google-Smtp-Source: APXvYqyuHURRUXFC2opMgTDs57uqGeN+UsWBRMnuUszmwx8emg3WSj/00gidI4l8fcUlSPgJUS2GzFpyw/9XBb1Mqy4=
X-Received: by 2002:a02:9f84:: with SMTP id a4mr953368jam.20.1562865459489;
 Thu, 11 Jul 2019 10:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190708181536.2125-1-yichengli@chromium.org>
In-Reply-To: <20190708181536.2125-1-yichengli@chromium.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 11 Jul 2019 10:17:28 -0700
Message-ID: <CAPUE2uvnPfA8y1bqppC3-vZyRKRwdF4evGY8X4c-xP=YZi4HRw@mail.gmail.com>
Subject: Re: [PATCH] mfd: cros_ec: Update cros_ec_commands.h
To:     Yicheng Li <yichengli@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Gwendal Grignou <gwendal@chromium.org>

Note there is a patch series that move cros_ec_commands.h from
nclude/linux/mfd/ to include/linux/platform_data.

On Mon, Jul 8, 2019 at 11:16 AM Yicheng Li <yichengli@chromium.org> wrote:
>
> Update cros_ec_commands.h to match the fingerprint MCU section in
> the current ec_commands.h
>
> Signed-off-by: Yicheng Li <yichengli@chromium.org>
> ---
>
>  include/linux/mfd/cros_ec_commands.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
> index 7ccb8757b79d..98415686cbfa 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -5513,6 +5513,18 @@ struct ec_params_fp_seed {
>         uint8_t seed[FP_CONTEXT_TPM_BYTES];
>  } __ec_align4;
>
> +#define EC_CMD_FP_ENC_STATUS 0x0409
> +
> +/* FP TPM seed has been set or not */
> +#define FP_ENC_STATUS_SEED_SET BIT(0)
> +
> +struct ec_response_fp_encryption_status {
> +       /* Used bits in encryption engine status */
> +       uint32_t valid_flags;
> +       /* Encryption engine status */
> +       uint32_t status;
> +} __ec_align4;
> +
>  /*****************************************************************************/
>  /* Touchpad MCU commands: range 0x0500-0x05FF */
>
> --
> 2.20.1
>
