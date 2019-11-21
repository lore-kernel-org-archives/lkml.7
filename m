Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42EAC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81CF206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKUO7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:59:54 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:39457 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfKUO7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:59:53 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mcpz0-1hxux339d4-00Zuop; Thu, 21 Nov 2019 15:59:51 +0100
Received: by mail-qt1-f180.google.com with SMTP id g50so3989974qtb.4;
        Thu, 21 Nov 2019 06:59:51 -0800 (PST)
X-Gm-Message-State: APjAAAUaqSDGxYT5J2Ht1CYbyhKG5naTkBZaqvYesU4qjlO3g5uPB4Qh
        cIZWmKLU8PMs3w67pKnX1aIjEqcj7qCNscu9Sqk=
X-Google-Smtp-Source: APXvYqxIFJaPW3uPWeKDGpnhrGOSoVmzNafdzne8IDHTdUTXHUJQrsTdJqNr+FqQSIB4G489oyCCmGRaBMWxyONUiY0=
X-Received: by 2002:ac8:18eb:: with SMTP id o40mr2694671qtk.304.1574348390632;
 Thu, 21 Nov 2019 06:59:50 -0800 (PST)
MIME-Version: 1.0
References: <20191120154148.22067-1-orson.zhai@unisoc.com> <20191120154148.22067-2-orson.zhai@unisoc.com>
In-Reply-To: <20191120154148.22067-2-orson.zhai@unisoc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Nov 2019 15:59:34 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1vuPWZYpMB9OGdLaCmbC6A0+5ecjKmdMqFUjpPmwp+tg@mail.gmail.com>
Message-ID: <CAK8P3a1vuPWZYpMB9OGdLaCmbC6A0+5ecjKmdMqFUjpPmwp+tg@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] dt-bindings: syscon: Add syscon-names to refer to
 syscon easily
To:     Orson Zhai <orson.zhai@unisoc.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kevin.tang@unisoc.com, baolin.wang@unisoc.com,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:zV7+uXi8eci6wJWRj6AHOd2u+WpJNhT8yE3h5Uhj/Tmfco2p7B9
 buVP64GgeKxFM84HT8uYnpaKx9s0keiN98FDhftaldUGmROM8GB9csqb3l0LI0gxPwOjdEN
 p3KZJqEMBBVYPp3P4vUVVPR3HHKI8BxsmP+FFSAIvrtyp0mqIokEYAMEwObuij1unIsozB7
 EawozwlAT9gFw0q+pPvIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QxE9heKmzb8=:uFFlRGFhRDabnqx54fDf8x
 w+TOHGQDU+jp67dTbVjJbUqLtiEQ2UugzIbJfpv+WE6kGEvv+nkosEfehA2/eedpXLVV5FQt9
 KyNk1jS93j2ZEmFNHmy5MrrERyUUT4/5AvAbxFsLSrm8yPLvrJF3Yp2EDxwL6GnxzfNX40FfI
 /eB8bRV1mF0QaIph8b1v68dpbIFknMTtsjbwACqm6T5DxZTgXN0BFyNT8tAKnEXn5wmAq+hGK
 fqGwvGn7odd81YESjNXJM8PobANCUX/PmnJFOTPGgI8acISJjkxWZ+QPlOgkUdPZ8RsMqlMIt
 /mVNVFsEAJme4+QL/c4iavaXWWKzsTbAIrO5NbR6dmZCuJIIX97m049kyI+g3+/cfjNLzYYYg
 5co0Ua+NlzwGBWghVS1mBDcY5LZ+cgp+EqiRBf1/0ZR2zqrgoABwq6aUQ6Lns7stx9nxAuzuH
 +hQaySxOgwctReqJh4OIdUVh9k2VIyjrgZrz2X/ZZ92+vwM9Z3o20Ro6zC1kclW27K15SMmVA
 5gCdkPpgAatjjk8mTAILQVUowd4Wex86zFPqjaeH5+TchbvUWUmiMjnyyFqGpExt9bowZzU+v
 zgla2Bd9h2XChkYLfSVdhaiCxvtRpr1/vDim+CRrPRI837Ryn8BKYgeF6xeof+mXjbGcMrXLQ
 mg0iBL+S9PizmAUioaIS5wzwjnOMZ1iv3iRmB3MMI/cjedEOF+IDvDEGmvygi5aVdxj8EDyG1
 YcCajBvWXkr16cVDCD3qH6UJQNqfuA1MgBaGE29DJ0YZyzMdcKzwQcG1nmiuKM2H/Xvd9TpqG
 7eTb50y0rAAfP6ynrDcZEJm3kLHc7+a6SLGgriRNoQmNvUrM6+neKyPJcgueFFPq3IpEfHHWe
 x/2vnD5cGPTzgWiTtE8A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 4:44 PM Orson Zhai <orson.zhai@unisoc.com> wrote:
>
> +
> +Optional property:
> +- #.*-cells: Represents the number of arguments in single phandle in syscons
> +  list. ".*" is vendor specific. If this property is not set, default value
> +  will be 0.
> +
> +Examples:
> +
> +apb_regs: syscon@20008000 {
> +       compatible = "sprd,apb-glb", "syscon";
> +       reg = <0x20008000 0x100>;
> +};
> +
> +aon_regs: syscon@40008000 {
> +       compatible = "sprd,aon-glb", "syscon";
> +       reg = <0x40008000 0x100>;
> +};
> +
> +display@40500000 {
> +       ...
> +       #syscon-disp-cells = <2>;
> +       syscons = <&ap_apb_regs 0x4 0xf00>, <&aon_regs 0x8 0x7>;
> +       syscon-names = "enable", "power";
> +};


Hi Orson,

With the changes from the syscon nodes removed, it looks better
already, but I'd also like to not see the #.*-cells mentioned at
all, as there is not really a way to parse this automatically, or
make sense of the data without already knowing how many cells
there are.

       Arnd
