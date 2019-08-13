Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F916C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477FF20874
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565703467;
	bh=2qmLOtTpG/stA8TD7RCITB8xohNroN/LDsPV5fUMmHc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nCPRvMfS/X4Am/A8N2bL1ES5aYuWbEau7/2mM5j3u1C57LF949NHSBZGELySnTKbX
	 t1RMKsuJAjOz8CAVhOLtUEl1uzX7FCe/Rrd0wPMMokf867ZmEPQ9oyo8UQzsemuUFi
	 y3Ev6An6seEo2L1AJK4ETY/zSNUzdCF92wkNAyHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfHMNhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:37:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728413AbfHMNhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:37:45 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94028214C6;
        Tue, 13 Aug 2019 13:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565703464;
        bh=2qmLOtTpG/stA8TD7RCITB8xohNroN/LDsPV5fUMmHc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BKQNSToq0wG1MBpTLk+RRUxQ4uNsuwaoMwmZbEyWaI/6sJxe1Akq2vvYwUtOUNgmY
         KyBd+LJ3yn6pmssD0B6hUngaAs9Vs1wXNx7ieyCsytMepVKaCt9Kx23o+cm1XIOgAz
         QWtdq0z2Tp0BIvZRZpYVYy5AzLzW44b3bMxrJqSM=
Received: by mail-qt1-f172.google.com with SMTP id 44so75252855qtg.11;
        Tue, 13 Aug 2019 06:37:44 -0700 (PDT)
X-Gm-Message-State: APjAAAUVy7lHz2PsPB6UENEGYBHfXCwVoFpXvWs06HpdWohbJYvDlQRV
        5eMiABWqTFFEgDBFkVjyzWTkJO9yw+cFaEelMg==
X-Google-Smtp-Source: APXvYqxSiv8xmh6l0YTN5kHSwGreytmLW7ZJbNoD9AorAGSyRJwul03y4GR3v+y0oM8Lfhej25onLI9w87H77Qr4i5g=
X-Received: by 2002:ac8:368a:: with SMTP id a10mr34107578qtc.143.1565703463817;
 Tue, 13 Aug 2019 06:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190813130559.16936-1-sashal@kernel.org>
In-Reply-To: <20190813130559.16936-1-sashal@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 13 Aug 2019 07:37:32 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJaRmeV3Ne-HFTxMG_AZhaiGW_SKzgNrDMLJ5WGP0FXUQ@mail.gmail.com>
Message-ID: <CAL_JsqJaRmeV3Ne-HFTxMG_AZhaiGW_SKzgNrDMLJ5WGP0FXUQ@mail.gmail.com>
Subject: Re: [PATCH] tpm/tpm_ftpm_tee: trivial checkpatch fixes
To:     Sasha Levin <sashal@kernel.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 7:06 AM Sasha Levin <sashal@kernel.org> wrote:
>
> Fixes a few checkpatch warnings (and ignores some), mostly around
> spaces/tabs and documentation.
>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml |  2 ++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/char/tpm/tpm_ftpm_tee.c                        | 10 +++++-----
>  3 files changed, 8 insertions(+), 6 deletions(-)
