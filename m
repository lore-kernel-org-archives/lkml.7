Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9651AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72895213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfCTORN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:17:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36712 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbfCTORN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:17:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id v10so2411190lji.3;
        Wed, 20 Mar 2019 07:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xEkL7qFAbSedF77g4SyAUEKrG6+mmgq4VP4MLNyi+QU=;
        b=aiGGumJPcVKvmXcQNbFEC6jVJRLFvF1N92oNMN7ZrPrppoCt+apnc5O0SumcAngyHe
         bOGVFQAiMAvoccjojigv9Q0cRhSZvc0zrORv4dspPhP/UzDAEfZN7lo5XBHqQOqNwAT1
         chWY2y5VlZvVlXDbIlOyZkcsK2BV2tujeBoT40ZpE3foN/OGEmF1VzqtVSEd7OygdNOg
         pMtYcYmoQEQA5/Xeh5H+4Orxctq8zju45IrkYHKy4Jx4v+8/a/vfO+JifpSXDMLhXJJ/
         o2qJ3IgUGXjiK50Q0JH5lSW5GIIvZ6nOcTk/FZYlB78UwTFiATtp73po52jA3qAtfSyu
         kauw==
X-Gm-Message-State: APjAAAUisq15TKauh30pTLCr9KiTLUmOME3or5zJmJhULJHt4qypC9lS
        emrB3ieFmbGA5lFT/YvkenU=
X-Google-Smtp-Source: APXvYqzETHEfcNqDDv7TWMJtSQL8phr6Oxgkd+jCBXLBHCHcRMT/jFTFuNL4x3mZduKz7MXd4GIebw==
X-Received: by 2002:a2e:9154:: with SMTP id q20mr7548104ljg.30.1553091429182;
        Wed, 20 Mar 2019 07:17:09 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id t18sm364366ljg.64.2019.03.20.07.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 07:17:08 -0700 (PDT)
Date:   Wed, 20 Mar 2019 16:17:01 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     mazzisaccount@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com, Robin Gong <yibin.gong@nxp.com>,
        Elven Wang <elven.wang@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Angus Ainslie <angus.ainslie@puri.sm>
Subject: Re: [PATCH v3 1/3] devicetree: bindings: bd718x7: document HW state
 related ROHM specific properties
Message-ID: <20190320141701.GA6208@localhost.localdomain>
References: <cover.1550135853.git.matti.vaittinen@fi.rohmeurope.com>
 <6ed4238fb083f52de0f5f013647b2334bad8ebe4.1550135853.git.matti.vaittinen@fi.rohmeurope.com>
 <20190320130259.GN4731@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190320130259.GN4731@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lee, All

On Wed, Mar 20, 2019 at 01:02:59PM +0000, Lee Jones wrote:
> On Thu, 14 Feb 2019, Matti Vaittinen wrote:
> 
> > Add ROHM BD71837 / BD71847 specific device tree bindings for
> > controlling the PMIC shutdown/reset states and voltages for
> > different HW states. The PMIC was designed to be used with NXP
> > i.MX8 SoC and it supports SNVS low power state which seems to
> > be typical for NXP i.MX SoCs. However, when SNVS is used we must
> > not allow SW to control enabling/disabling those regulators which
> > are crucial for system to boot as there is a HW limitation which
> > causes SW controlled regulators to be kept shut down after SNVS
> > reset.
> > 
> > Allow setting the SNVS to be used as reset target state and allow
> > marking those regulators which are critical for boot.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> >  .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  | 17 ++++++++++
> >  .../bindings/regulator/rohm,bd71837-regulator.txt  | 38 ++++++++++++++++++++++
> >  2 files changed, 55 insertions(+)
> 
> Needs a DT Ack.

I think this was already applied to regulator tree by Mark:
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git/commit/?h=for-next&id=f43d1b388f9be4aa47ed42c33659243a675c5c76
Does it go in via his tree or do we need to apply it in Lee's tree too?

Br,
	Matti Vaittinen

> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
