Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40411C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F23620862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfEOG77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 02:59:59 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34785 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfEOG77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 02:59:59 -0400
Received: by mail-qt1-f195.google.com with SMTP id h1so2120404qtp.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 23:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a0INoBT4qkL5QtbS7LmbbqhkeTuqp575a3wWb3dHw0E=;
        b=jOqAQqVTlQxaa9j19OQ/hqnAhLwVRMTGuniUhge7WiAMOoqETn1LkEv0AlKmUenu+M
         +EfopHhhXYbb3CtRveBf00Am+uDv8ltbOMQDREjt+FC90f1pg+O6wbRBLSWB6D4PJ3he
         33j6M7BYo+U1LgiC6+3CrBeTf7qwdnVVsTN9PnxWDO0zDuAqGugize/Aofyic/qPBxpM
         0U4y9XBfQQ2eX4YjsbvdTeEUheWCpL+wXth8vF4CNmUXphGujCH/PR0QJuu0g5PNeFv5
         ZcnSrbtmbWc/z51QtKrEF2+vgBc2wZEMXnVLvnDHEtkjSHcuAispcuDJ4QBtsjeOQaQu
         5N0g==
X-Gm-Message-State: APjAAAXCKzj33jRQsSw86kvkJ0fpldQ7Ce/jlgsROZLfLCFeinCLh3eE
        kMXua7XSdipzAx04P9j+UNb2lOoWiVI8JV5tRUQ=
X-Google-Smtp-Source: APXvYqyHXGAeiACrt57xBp9Nbv6X62+kIUfmI9qoFuWqGOS93M73nOguKF8KNaq1QMNh8xjWhNSFPmBYA5wpGQUAuDo=
X-Received: by 2002:a0c:980b:: with SMTP id c11mr32766169qvd.115.1557903598583;
 Tue, 14 May 2019 23:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190512012508.10608-1-elder@linaro.org> <20190512012508.10608-3-elder@linaro.org>
In-Reply-To: <20190512012508.10608-3-elder@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 May 2019 08:59:41 +0200
Message-ID: <CAK8P3a16HpKEUB7_6G_W_RKkyVeVBW_rofLbdhC2QmWjVOAHMg@mail.gmail.com>
Subject: Re: [PATCH 02/18] soc: qcom: create "include/soc/qcom/rmnet.h"
To:     Alex Elder <elder@linaro.org>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        subashab@codeaurora.org, stranche@codeaurora.org,
        YueHaibing <yuehaibing@huawei.com>,
        Joe Perches <joe@perches.com>, syadagir@codeaurora.org,
        mjavid@codeaurora.org, evgreen@chromium.org, benchan@google.com,
        ejcaruso@google.com, abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 3:25 AM Alex Elder <elder@linaro.org> wrote:

> diff --git a/include/soc/qcom/rmnet.h b/include/soc/qcom/rmnet.h
> new file mode 100644
> index 000000000000..80dcd6e68c3d
> --- /dev/null
> +++ b/include/soc/qcom/rmnet.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/* Copyright (c) 2013-2018, The Linux Foundation. All rights reserved.
> + * Copyright (C) 2018-2019 Linaro Ltd.
> + */
> +#ifndef _SOC_QCOM_RMNET_H_
> +#define _SOC_QCOM_RMNET_H_
> +
> +#include <linux/types.h>
> +
> +/* Header structure that precedes packets in ETH_P_MAP protocol */
> +struct rmnet_map_header {
> +       u8  pad_len             : 6;
> +       u8  reserved_bit        : 1;
> +       u8  cd_bit              : 1;
> +       u8  mux_id;
> +       __be16 pkt_len;
> +}  __aligned(1);

If we move this into include/soc/, I want the structure to be portable,
and avoid the bit fields. Please use mask/shift operations or the
include/linux/bits.h macros instead to make this work with big-endian
kernels.

     Arnd
