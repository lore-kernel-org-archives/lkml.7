Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A32C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DAC20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554264957;
	bh=R//cMMXO1CySdHgSwj1wzWT9d3AT3OKUmTatqgpsTgU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PXFcpZf0+YITEzceS9lJGm6vJJZKNCKWntpUq3xTtU+A2AmtFRBpdkPc7KEev8Fk3
	 IBSwt4O5+dPjDc0IBIp1o0FV+FDAMEa06K4rvVjR+RFa2RlgE9dn2XRWWUHWgAJJAg
	 89SrN3wFN3B9GorV5dJOTgUj1JWW3BHnSMQdCgBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfDCEP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:15:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfDCEPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:15:55 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16F4C20882;
        Wed,  3 Apr 2019 04:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554264955;
        bh=R//cMMXO1CySdHgSwj1wzWT9d3AT3OKUmTatqgpsTgU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0BePvMLEB/wsL17JSY0f2JCBbJFvPZd/+rx0VvFOPeEOXt6gt5Sq/GpTd7DxI+ZmR
         4Sr2xvlNNe88uYBYtVRUk5gmdpQYE0SZu8m6iYIfJ6INDHoyFVbAVuuFXeAqVFLPsK
         TFFDoDCLt2LjzMWIvTG0QEL60SkIGWs0lq3NAn0g=
Received: by mail-qk1-f170.google.com with SMTP id a71so9358079qkg.2;
        Tue, 02 Apr 2019 21:15:55 -0700 (PDT)
X-Gm-Message-State: APjAAAUDajx2R2bsR0ZGon5kcrOv33N7jNmJ2BLmZXr0jIZYhibtAiMX
        15vRAEIxkqRUfKElY5AmASUxu0vsUkmYfs05NQ==
X-Google-Smtp-Source: APXvYqx/O7SzBMFHDyQ22C0towCsR0Q2kOyJrVm4jvQ1UficcyiPV1POGXkJ3Xo28jr6qr8Uz88dj32l2nt7uC4VPc4=
X-Received: by 2002:a37:b005:: with SMTP id z5mr57339315qke.119.1554264954338;
 Tue, 02 Apr 2019 21:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190327144405.5716-1-jank@cadence.com> <20190327144405.5716-2-jank@cadence.com>
In-Reply-To: <20190327144405.5716-2-jank@cadence.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 2 Apr 2019 23:15:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKBU92j_MCZ21TSD7=f-zu4+pF91u1uoZY+=d+jOeQb0A@mail.gmail.com>
Message-ID: <CAL_JsqKBU92j_MCZ21TSD7=f-zu4+pF91u1uoZY+=d+jOeQb0A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: scsi: ufs-cdns: Update Cadence UFS
 compatibility list
To:     Jan Kotas <jank@cadence.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>, pedrom.sousa@synopsys.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 9:45 AM Jan Kotas <jank@cadence.com> wrote:
>
> This patch adds a new compatible string description for
> CDNS UFS HCD + M31 16nm PHY.
>
> Signed-off-by: Jan Kotas <jank@cadence.com>
> ---
>  Documentation/devicetree/bindings/ufs/cdns,ufshc.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
