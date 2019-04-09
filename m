Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA670C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3B2205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554806517;
	bh=UTQwELX4g/y/5RF08DcWnDlemQfSE1xs8kkwzu/lcmM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Q4lrKqQX/n9xPIraH36fJhjqySpnjKIKvL5J1fyn/QuoR6TCpBLcO3gOCrn+g+wRw
	 VkkA8PWE6+GyG6jXFEMPXWKX1Bl7K/wCgl6HJXhITDMSTPNyYpdTggIlbP2pmCStvM
	 qeKHSJBmdaLnfsob1IDkg32RWMs45T+azu9X6vsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfDIKlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:41:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfDIKlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:41:55 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94BC0205F4
        for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2019 10:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554806514;
        bh=UTQwELX4g/y/5RF08DcWnDlemQfSE1xs8kkwzu/lcmM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EypApUze176ipRthU5QwzfJjkIf0OaHFjOUI9KkEPeJ4XLktwcwkbqLW9n33R9KUJ
         survO1zmjDoWPA8Jadu0rn6EPm3rdIr94ONxBnWToCNx966EI160IIbWGmhRjkA6GM
         Bj++eOQ4ZsS/p+nguB8H/aStlXWLMvSr02t5C/ig=
Received: by mail-qt1-f173.google.com with SMTP id w30so19062843qta.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 03:41:54 -0700 (PDT)
X-Gm-Message-State: APjAAAVpw3TbQdFCmPSs4jbtePLNOqEjfCcdldoCSsYUy3A45q24zY0f
        Gh32+hcfQlT4v0PNNNkN5fkdhU1wSPCiu1okwGQ=
X-Google-Smtp-Source: APXvYqyB//+VdhDxsubxvRI5OCbSCXrUwj9wJ5lsgwIZiJutH6E/LBB9oiwpD6Z7iPuyapuD5/EBMLNZCXZdymDucGE=
X-Received: by 2002:a0c:98b3:: with SMTP id f48mr28950233qvd.202.1554806513865;
 Tue, 09 Apr 2019 03:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <MWHPR12MB1343B0921E0D4DD39A1C9F38CB2D0@MWHPR12MB1343.namprd12.prod.outlook.com>
In-Reply-To: <MWHPR12MB1343B0921E0D4DD39A1C9F38CB2D0@MWHPR12MB1343.namprd12.prod.outlook.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Tue, 9 Apr 2019 06:41:43 -0400
X-Gmail-Original-Message-ID: <CA+5PVA4ymVN5UC72vy4r_nvryvXRZbUT1G0Gu6p1DYXCS-GgTw@mail.gmail.com>
Message-ID: <CA+5PVA4ymVN5UC72vy4r_nvryvXRZbUT1G0Gu6p1DYXCS-GgTw@mail.gmail.com>
Subject: Re: pull request: Linux-firmware: Update cxgb4 firmware
To:     Vishal Kulkarni <vishal@chelsio.com>
Cc:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        dt <dt@chelsio.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 6:00 AM Vishal Kulkarni <vishal@chelsio.com> wrote:
>
> Hi,
>
> Kindly pull the new firmware from the following URL:
> git://git.chelsio.net/pub/git/linux-firmware.git for-upstream
>
> Thanks,
> Vishal
>
> The following changes since commit 67b75798ea88f4b1d6ee6a3b5a0634d29620c094:
>
>   linux-firmware: add firmware for MT7615E (2019-04-02 08:00:12 -0400)
>
> are available in the git repository at:
>
>   git://git.chelsio.net/pub/git/linux-firmware.git for-upstream
>
> for you to fetch changes up to ddde59823ae0452582c49774894173435e885549:
>
>   cxgb4: update firmware to revision 1.23.4.0 (2019-04-09 02:43:33 -0700)
>
> ----------------------------------------------------------------
> Vishal Kulkarni (1):
>       cxgb4: update firmware to revision 1.23.4.0
>
>  WHENCE                                         |  12 ++++++------
>  cxgb4/{t4fw-1.23.3.0.bin => t4fw-1.23.4.0.bin} | Bin 570880 -> 570880 bytes
>  cxgb4/t4fw.bin                                 |   2 +-
>  cxgb4/{t5fw-1.23.3.0.bin => t5fw-1.23.4.0.bin} | Bin 659456 -> 659456 bytes
>  cxgb4/t5fw.bin                                 |   2 +-
>  cxgb4/{t6fw-1.23.3.0.bin => t6fw-1.23.4.0.bin} | Bin 708608 -> 708608 bytes
>  cxgb4/t6fw.bin                                 |   2 +-
>  7 files changed, 9 insertions(+), 9 deletions(-)
>  rename cxgb4/{t4fw-1.23.3.0.bin => t4fw-1.23.4.0.bin} (99%)
>  rename cxgb4/{t5fw-1.23.3.0.bin => t5fw-1.23.4.0.bin} (99%)
>  rename cxgb4/{t6fw-1.23.3.0.bin => t6fw-1.23.4.0.bin} (99%)

Pulled and pushed out.

josh
