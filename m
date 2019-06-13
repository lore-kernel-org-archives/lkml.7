Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6258AC31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA0020B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560439226;
	bh=+dpcx+t3gqsrdkSAF32yzocQzxMx51ogbHZjaUxs06g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=F0QfdmiqYlGVwwhwmDD6qjE04fks2ZdDqIDbg/P6+dqo3T2FwUMxkzLUAoJdaeyJm
	 sgJ+AMiDR/P80H3baDNxLLbQ+1t1bETFNr0CQAn8pw+mtDElGa07FvRbWiFsJrBth6
	 tiRaM3neHeiXOUwU2mcXLwMNjkLJ0RRE7e5h8e/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388620AbfFMPUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:20:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732107AbfFMMym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 08:54:42 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E14622173C;
        Thu, 13 Jun 2019 12:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560430482;
        bh=+dpcx+t3gqsrdkSAF32yzocQzxMx51ogbHZjaUxs06g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UC8yBn2wHn5Q7MOC0f1Y/gBNFscwOv67bdYXMtHV4JMJO3xgYA58rEUWsbazZQVwX
         VYpP9uAQ33ZZFVpKlTVRw0WPvfqYG4lStUureizyJTVqwMKIHfVxFH8pqdbYtBxtoT
         gKnW0cbyeN6v+RfYVSfhsVKFQpKqrRfOjJMXcCHs=
Received: by mail-qt1-f179.google.com with SMTP id a15so22353003qtn.7;
        Thu, 13 Jun 2019 05:54:41 -0700 (PDT)
X-Gm-Message-State: APjAAAX+ajDU2chIp88Vc6tMds5g7OPK5p0IhTLEuf+sZG4rt9ABl7VC
        AWiuMjrpPYHjjodz1TY01MOEH5wHYtKa6epy7Q==
X-Google-Smtp-Source: APXvYqzMa0Uyb0Z+rWRg4l/d54XGw039fVYUrrOI8A8Wr/WbXB3zrEmuYPzH+FK2dGun9qwWEQm+TE/ODK7+RcwR90Q=
X-Received: by 2002:aed:3fb0:: with SMTP id s45mr22297842qth.136.1560430481170;
 Thu, 13 Jun 2019 05:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190613051344.1170-1-Anson.Huang@nxp.com> <20190613051344.1170-4-Anson.Huang@nxp.com>
In-Reply-To: <20190613051344.1170-4-Anson.Huang@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 13 Jun 2019 06:54:29 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKQgQ=+4xt41_2X3ddsO=rt4u--MJ28+p=is33c1=0DQg@mail.gmail.com>
Message-ID: <CAL_JsqKQgQ=+4xt41_2X3ddsO=rt4u--MJ28+p=is33c1=0DQg@mail.gmail.com>
Subject: Re: [PATCH V3 4/4] dt-bindings: arm: imx: Add the soc binding for i.MX8MQ
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <Michal.Vokac@ysoft.com>,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
        Yang-Leo Li <leoyang.li@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bai Ping <ping.bai@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>,
        Pramod Kumar <pramod.kumar_1@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 11:12 PM <Anson.Huang@nxp.com> wrote:
>
> From: Anson Huang <Anson.Huang@nxp.com>
>
> This patch adds the soc & board binding for i.MX8MQ.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> New patch, as I just found i.MX8MQ SoC & board binding is missed, so add this patch
> based on i.MX8MN binding, so put it in same series to avoid dependency issue.
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
