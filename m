Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50EEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A172A206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552392582;
	bh=h8O3iXcm/GhHsnAmotZ6jKi9eUWTDBPtpEPiFTTZT44=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q6si/rScVgPsaTzKrvZc4hi3l4VJKW8Im1PRVPjE4hbCLvQyxa7/RA/Dx09rLws3U
	 j98un1SEF/8spYgAonYoKu/KOTFYjiXaUdoR2q9pj5kyGUETjLHjrzaZwtkoGR295I
	 OxE7keLS/F86dHy7InKG9GHlMKbvJiEtQ2GHrG0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfCLMJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:09:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfCLMJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:09:41 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51FA520883;
        Tue, 12 Mar 2019 12:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552392580;
        bh=h8O3iXcm/GhHsnAmotZ6jKi9eUWTDBPtpEPiFTTZT44=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t0C/OJCsa2GCcGEiPrXIpoid5t1afTf76YaR4JksMY4XzfiXE70zDtj+FfkeyOZH6
         1lTH1RZwO+kIm/vNECPuG734bDDGKMb/g7w5WMNbaw6sJfiRf15s5Vqj/dkGbgBUY7
         EVR2PxddoigNvuIHnxqJl5FbHJZ0AwJ9wT71zZMk=
Received: by mail-qt1-f173.google.com with SMTP id z17so2183490qtn.4;
        Tue, 12 Mar 2019 05:09:40 -0700 (PDT)
X-Gm-Message-State: APjAAAWLwykzBeB4mRWEZisT1tFwJyaSNgVgx/hpevDUyNoaICT2EBWQ
        iKr0dgq/afKxzrYiVARAHUqZy/PA8jAI/MgmaBY=
X-Google-Smtp-Source: APXvYqyMCdccq+/Qm+ukfcopRVwgWXClpQg2H2v1axIotX/o/RLnLYzI23lqTS6TnOJlWlPaAz3XbC5KO6nvoHM0yXI=
X-Received: by 2002:ac8:2d68:: with SMTP id o37mr28721699qta.377.1552392579546;
 Tue, 12 Mar 2019 05:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <84b02324ea2fb251b4037dee8994306a@codeaurora.org>
In-Reply-To: <84b02324ea2fb251b4037dee8994306a@codeaurora.org>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Tue, 12 Mar 2019 08:09:28 -0400
X-Gmail-Original-Message-ID: <CA+5PVA5awD_uMvhKR-KdN_io5g3s2YZBVao1Tj6wWtcBUY9W1w@mail.gmail.com>
Message-ID: <CA+5PVA5awD_uMvhKR-KdN_io5g3s2YZBVao1Tj6wWtcBUY9W1w@mail.gmail.com>
Subject: Re: Fw files for QCA BT Chip QCA6174
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     Hemantg <hemantg@codeaurora.org>,
        Linux Firmware <linux-firmware@kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        Linux-arm Msm <linux-arm-msm@vger.kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        rjliao@codeauroa.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 11:40 AM Balakrishna Godavarthi
<bgodavar@codeaurora.org> wrote:
>
>
> Hi,
>
> The following changes since commit
> 54b0a748c8966c93aaa8726402e0b69cb51cd5d2:
>
>    WHENCE: Correct errant entries (2019-02-21 07:21:45 -0500)
>
> are available in the Git repository at:
>
>    https://github.com/bgodavar/qca6174_bt_fw.git
>
> for you to fetch changes up to c99beda7e0368961d024ddc8e45a46f118100cc7:
>
>    QCA: Add the fw files for BT Chip QCA6174. (2019-02-25 15:36:36 +0530)
>
> ----------------------------------------------------------------
> Balakrishna Godavarthi (1):
>        QCA: Add the fw files for BT Chip QCA6174.
>
>   WHENCE                    |   2 ++
>   qca/nvm_00440302.bin      | Bin 0 -> 2010 bytes
>   qca/rampatch_00440302.bin | Bin 0 -> 64940 bytes
>   3 files changed, 2 insertions(+)
>   create mode 100644 qca/nvm_00440302.bin
>   create mode 100644 qca/rampatch_00440302.bin

Pulled and pushed out.

josh
