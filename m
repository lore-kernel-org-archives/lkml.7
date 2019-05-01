Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5872C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9033C20866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfEATAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 15:00:45 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34801 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfEATAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 15:00:45 -0400
Received: by mail-ot1-f66.google.com with SMTP id n15so9507091ota.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 12:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i9+tfL6fSxYsK1rZcVSRQNqUCLp68RFEdLLJQMKSpDU=;
        b=YAsW6iUVfIpiXSNvGP6AF3/jeuo3aGJfAPxXVVPuIywbtw6kFsjIjW8tJV5SRg/HEt
         +8cMfVXu7qclm/FXTyWuX095FlXH1E73CxlJIIekI8VcnWUGrWDuvDj2kNpIhYYD320d
         bqWGXpx9RiIX62HdxFDB14pyPN+JZBQr3dDxmWn+P31jOAdsvyQ0QmLeG3i5B2+u3lzA
         TCLCUarQKvkM5bxj6xhC0Z/iouhzEapC2EFivh22VIobhY3QL3QdERFfC+30eeTAZteb
         OEzTs9em49WfWyXpW8F8ejZwJ51iaZMU586+3jfET0P4CuA/G15iqoXPd/5I1MlwwHKZ
         PDsA==
X-Gm-Message-State: APjAAAXgaMgG/yY7XGgMdtjbQTkfihpxIrLjuSJY6zOfYfV8n9SLW+ez
        VeQFfyWpqCdza6Wx5fAIEIrR01kWLrY=
X-Google-Smtp-Source: APXvYqxcnZtyfDp5i1OiYkDeOuyLxdZdwkDq1MwmPYmitS4bHnDj2/YJ0PiOVfz/OncExhdTiCmkBg==
X-Received: by 2002:a9d:490e:: with SMTP id e14mr1744563otf.197.1556737244197;
        Wed, 01 May 2019 12:00:44 -0700 (PDT)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id w3sm6779386oic.39.2019.05.01.12.00.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 12:00:43 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id b18so6570424otq.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 12:00:43 -0700 (PDT)
X-Received: by 2002:a9d:6409:: with SMTP id h9mr18431913otl.68.1556737243506;
 Wed, 01 May 2019 12:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <1552325436-8907-1-git-send-email-roy.pledge@nxp.com>
In-Reply-To: <1552325436-8907-1-git-send-email-roy.pledge@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Wed, 1 May 2019 14:00:32 -0500
X-Gmail-Original-Message-ID: <CADRPPNRgDN9O2GGd2XyVdByQ8_00MF83ZJ+P8tf13to=-FuN7g@mail.gmail.com>
Message-ID: <CADRPPNRgDN9O2GGd2XyVdByQ8_00MF83ZJ+P8tf13to=-FuN7g@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: dpio: Increase timeout for QBMan Management Commands
To:     Roy Pledge <roy.pledge@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Youri Querry <youri.querry_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 12:32 PM Roy Pledge <roy.pledge@nxp.com> wrote:
>
> From: Youri Querry <youri.querry_1@nxp.com>
>
> The timeout for QBMan Management Commands can falsely trigger on a
> busy system. This patch doubles the timeout to avoid the
> false error reports
>
> Signed-off-by: Youri Querry <youri.querry_1@nxp.com>
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>

Applied for next.  Thanks.

> ---
>  drivers/soc/fsl/dpio/qbman-portal.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/fsl/dpio/qbman-portal.h b/drivers/soc/fsl/dpio/qbman-portal.h
> index 78c700e..f3ec5d2 100644
> --- a/drivers/soc/fsl/dpio/qbman-portal.h
> +++ b/drivers/soc/fsl/dpio/qbman-portal.h
> @@ -1,7 +1,7 @@
>  /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
>  /*
>   * Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
> - * Copyright 2016 NXP
> + * Copyright 2016-2019 NXP
>   *
>   */
>  #ifndef __FSL_QBMAN_PORTAL_H
> @@ -433,7 +433,7 @@ static inline int qbman_swp_CDAN_set_context_enable(struct qbman_swp *s,
>  static inline void *qbman_swp_mc_complete(struct qbman_swp *swp, void *cmd,
>                                           u8 cmd_verb)
>  {
> -       int loopvar = 1000;
> +       int loopvar = 2000;
>
>         qbman_swp_mc_submit(swp, cmd, cmd_verb);
>
> --
> 2.7.4
>
