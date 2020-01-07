Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D677C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6972081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578386966;
	bh=RC3gfxK85DszPMx6V9U+gAmYKbWG0Zlt9X6q5+MTylc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vlyyIkWjzWTdMmflM0RC2sH0Qtf94QZ389ba3Kb9tA3z7v4MmiZedWwUzfAwBPCrw
	 TfGaHD7ezMtRcq1vBxB/KtyhSNONbfBUxcS6I1BVeX5Ut7xIlD7ud7Nu8mZWbYB0mU
	 dPlUyDlAqcP6tlChFU8jWGGcsP/3YuOwv0etYqSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgAGItZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 03:49:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:59000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgAGItY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 03:49:24 -0500
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9F072081E;
        Tue,  7 Jan 2020 08:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578386964;
        bh=RC3gfxK85DszPMx6V9U+gAmYKbWG0Zlt9X6q5+MTylc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t3MOD6EN8wlLClvHAIs3umVgEkRc2qnwxMlYoB5aTpp5aMd7rcKnzWkCViVlQzaKB
         6uVma0OEM7XzzT2PGt1g8fzlGYo1ODU9tw6kQ+AXroupv7M9blKNbY5NImzH6ijqbt
         oOwjhURdl0zq6hDad10nTA3+WLcpIB0prD/ntEAc=
Received: by mail-lj1-f171.google.com with SMTP id u1so53824401ljk.7;
        Tue, 07 Jan 2020 00:49:23 -0800 (PST)
X-Gm-Message-State: APjAAAXU3jzRLqurRdyR6oG1AonBNd/gvZ8gqUVCHOjUIWiiZE3XHMPx
        KgcMqmZCv74tT1uHFQ+BkssQToCc7HIbKuUMusc=
X-Google-Smtp-Source: APXvYqwNsdbjriu62OGQO4MM5Vec+3qloJgcts9uClsSrEvqX0pd6ckRSZZs9dkYlaa2t9l6PYsq8a162l5KsVzcRBo=
X-Received: by 2002:a05:651c:232:: with SMTP id z18mr55385115ljn.85.1578386962107;
 Tue, 07 Jan 2020 00:49:22 -0800 (PST)
MIME-Version: 1.0
References: <20200106191003.21584-1-tiny.windzz@gmail.com> <20200107084551.GB31906@pi3>
In-Reply-To: <20200107084551.GB31906@pi3>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 7 Jan 2020 09:49:10 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdx3O5Vfv20UsD3qh5UC7TczrY9pBPObGcqamFt=9Pw5A@mail.gmail.com>
Message-ID: <CAJKOXPdx3O5Vfv20UsD3qh5UC7TczrY9pBPObGcqamFt=9Pw5A@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: exynos: tiny4412: add fimd node
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2020 at 09:45, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Mon, Jan 06, 2020 at 07:10:02PM +0000, Yangtao Li wrote:
> > The patch adds fimd node for tiny4412 device.
>
> Hi,
>
> Thanks for the patch.
>
> Do not use "This patch ..." sentences but simple, imperative mode:
> https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst#L151
>
> Here you do not add FIMD node, because the FIMD is already there
> (defined in exynos4.dtsi).  You however enable it.
>
> Enabling it without panel does not really make sense - does it work?
> I guess not, so this should be squashed with second patch.

... unless it really works without panel, then it makes sense to keep
it separate. However in such case, the #cells properties belong to
second patch.

Best regards,
Krzysztof
