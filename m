Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4095CC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154F120665
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560862480;
	bh=3b8Z4yxbEGhAeiG8va44KaQqFXq6NYIDObPibnDI/H0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rn7SOS/jNNFHfOZexlWT8iRnbfMvRNyYpwU0LaxstLxFsgR/NRXXmsn8u2o63tjNf
	 uUgNlCk1OzmouweZTMrGLVudujxv0JMMhd9fAyHY1r1rBsTKlT8cO5ikpSErPxEboL
	 i1ZHaAhqYDglrASxIWwjlDrE5ovwSI3CLwxURVX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfFRMyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 08:54:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfFRMyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:54:38 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D991420665
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 12:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560862478;
        bh=3b8Z4yxbEGhAeiG8va44KaQqFXq6NYIDObPibnDI/H0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YaZTIqwUYrT48BwsXbO14NvfzzqUIntfcjwApWXtI2QvkvYaUuIklZzhwg0E4eQ/H
         v3pGtmLmFtU8633/RwY4ZL84nMrZtT4RVNVqw+tgmtZdwFIc21NpE/scaWbvcdmboR
         edBKMqavxN8FfS6gtv2HKyLp31CO3n65VVc+Eei4=
Received: by mail-qt1-f177.google.com with SMTP id w17so8685018qto.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 05:54:37 -0700 (PDT)
X-Gm-Message-State: APjAAAVmzyx7hpeIIANMzSR/d9YTtxGoqNNl3eQeyw7qgum1PE+Ln5Uk
        Ch6S5LuFoQoIKUn+DC9YpXBCcaezhPwYPv/5pcQ=
X-Google-Smtp-Source: APXvYqyvii3weH4ntVz7079/ThnMO4GmPSC82hZRSPCysLMzoxjrVy8/tsj0U+KfXPisSh2FsXww3O60axMieC704Jo=
X-Received: by 2002:ac8:32e8:: with SMTP id a37mr24113144qtb.231.1560862477176;
 Tue, 18 Jun 2019 05:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190613184541.22846-1-john.allen@amd.com>
In-Reply-To: <20190613184541.22846-1-john.allen@amd.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Tue, 18 Jun 2019 08:54:26 -0400
X-Gmail-Original-Message-ID: <CA+5PVA4BTyLd-23DvF6PtykFhbRAuENjBEmG1DaVypC_E0nkbg@mail.gmail.com>
Message-ID: <CA+5PVA4BTyLd-23DvF6PtykFhbRAuENjBEmG1DaVypC_E0nkbg@mail.gmail.com>
Subject: Re: [PATCH] linux-firmware: Update AMD SEV firmware
To:     "Allen, John" <John.Allen@amd.com>
Cc:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 2:45 PM Allen, John <John.Allen@amd.com> wrote:
>
> Update AMD SEV firmware to version 0.17 build 22 for AMD family 17h
> processors with models in the range 00h to 0fh.
>
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
>  amd/amd_sev_fam17h_model0xh.sbin | Bin 32000 -> 32576 bytes
>  1 file changed, 0 insertions(+), 0 deletions(-)

Applied and pushed out.

josh
