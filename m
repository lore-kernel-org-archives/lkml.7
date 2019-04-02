Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD3AC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A184C2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfDBXFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:05:32 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44990 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDBXFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:05:32 -0400
Received: by mail-oi1-f194.google.com with SMTP id i21so11957119oib.11;
        Tue, 02 Apr 2019 16:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNGeNmpMXmbmbGQ8XUlYBSMpsJzpAXQAXL/ACI9Obp8=;
        b=Ev2fkpBvfCJyBe6bJrpEBdCxczs//8eMuCPxs/BFF6qSHzuBHU4/TVjfhvDS4i8KZx
         f5Xirh+IdrGMaROlSt7V5RMGNUFGggc6F0xPDgztZaUZlW5jAiGLh0CpxTTgo3FyRFS+
         5RBkynTuNG7gzJpADIvFXvEa+yFQktYHj0qcZoAyLFGf3frrgR9fu5Odint6YG2ngy9u
         nKAkFIaFn0Bvv6EBReFh9YT+0+Yd72FC5s3JBBO5VPD+e+qvwHfmDn03rlGtlmircdek
         Wf835dXefITIe9kJdq2IyBMA0Sp7b95BbAz9VyPwcXSyR+UcC3Pu2JabWuy/CxW0/3DT
         YD6g==
X-Gm-Message-State: APjAAAU3sZB/eVRuCdjIDXxHj9Qw0ev2QcLaCl/5x7XDrknlYh+SgDvk
        mo7SCnp83wYR8YL6+MxnWGFyuBHqKsg=
X-Google-Smtp-Source: APXvYqxFYoMjRSkD8WuoscEFjLHD05z//XpzPEO6cQL/gT2y1CHSA4zpx8gjKy2axPO5slwJ++76tA==
X-Received: by 2002:a05:6808:650:: with SMTP id z16mr19166461oih.100.1554246330858;
        Tue, 02 Apr 2019 16:05:30 -0700 (PDT)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com. [209.85.167.177])
        by smtp.gmail.com with ESMTPSA id p132sm5889224oig.37.2019.04.02.16.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 16:05:30 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id y84so11961896oia.12;
        Tue, 02 Apr 2019 16:05:29 -0700 (PDT)
X-Received: by 2002:aca:d984:: with SMTP id q126mr12607185oig.108.1554246329538;
 Tue, 02 Apr 2019 16:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <1551132245-6089-1-git-send-email-vabhav.sharma@nxp.com> <1551132245-6089-3-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1551132245-6089-3-git-send-email-vabhav.sharma@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 2 Apr 2019 18:05:18 -0500
X-Gmail-Original-Message-ID: <CADRPPNTcY6fMJZDmsWzPzkn1hMzsoJh15-Gchepg_vJLxL=zcw@mail.gmail.com>
Message-ID: <CADRPPNTcY6fMJZDmsWzPzkn1hMzsoJh15-Gchepg_vJLxL=zcw@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] soc/fsl/guts: Add definition for LX2160A
To:     Vabhav Sharma <vabhav.sharma@nxp.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "oss@buserror.net" <oss@buserror.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel-owner@vger.kernel.org" 
        <linux-kernel-owner@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Yinbo Zhu <yinbo.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 4:12 AM Vabhav Sharma <vabhav.sharma@nxp.com> wrote:
>
> Adding compatible string "lx2160a-dcfg" to
> initialize guts driver for lx2160 and SoC die
> attribute definition for LX2160A


Applied to branch next.  Thanks.

Regards,
Leo
>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> Acked-by: Li Yang <leoyang.li@nxp.com>
> ---
>  drivers/soc/fsl/guts.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
> index 302e0c8..bcab1ee 100644
> --- a/drivers/soc/fsl/guts.c
> +++ b/drivers/soc/fsl/guts.c
> @@ -100,6 +100,11 @@ static const struct fsl_soc_die_attr fsl_soc_die[] = {
>           .svr          = 0x87000000,
>           .mask         = 0xfff70000,
>         },
> +       /* Die: LX2160A, SoC: LX2160A/LX2120A/LX2080A */
> +       { .die          = "LX2160A",
> +         .svr          = 0x87360000,
> +         .mask         = 0xff3f0000,
> +       },
>         { },
>  };
>
> @@ -222,6 +227,7 @@ static const struct of_device_id fsl_guts_of_match[] = {
>         { .compatible = "fsl,ls1088a-dcfg", },
>         { .compatible = "fsl,ls1012a-dcfg", },
>         { .compatible = "fsl,ls1046a-dcfg", },
> +       { .compatible = "fsl,lx2160a-dcfg", },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, fsl_guts_of_match);
> --
> 2.7.4
>
