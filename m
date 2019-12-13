Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5583CC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052B4214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576273213;
	bh=plP+cUX4HTiuvtFUm8ppZpU3p/w0AOIJhc+vg6yUdw4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ynBUKTd1pOont3BBNGEDyx+FrphVpglZqnpiteYugj3zIgc72n4nExdtQMOg7Pf5W
	 mj5cbrRuF4ZapLI3WYvb3ArlJ7yfwlucmOMR/joA3GqMl1XrJm/MCUltzjeg20B2MT
	 7hs3R+ZLiX9r7sXOn8EI1wy8egVHyTVms6PgNehc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfLMVkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:40:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:46006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbfLMVkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 16:40:11 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 976F8206D8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 21:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576273209;
        bh=plP+cUX4HTiuvtFUm8ppZpU3p/w0AOIJhc+vg6yUdw4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1w21m685KVvJSvaGQcZJbnwK4/0OvE1pOWVV2uAAM6ju+JvUfqS2/fx8KZlHuDzqa
         jTGjgTmR5iQz9vig6qNyE+hTTBmR63dSJCOfQq6bCUPtBVFqPDWJghZAnZ/6B1yrLW
         1DNEIQsbbF4HSb6FDQGddUxwO1oCwEfCiEuM4MvY=
Received: by mail-qt1-f174.google.com with SMTP id 5so297876qtz.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 13:40:09 -0800 (PST)
X-Gm-Message-State: APjAAAUF6xlun4uP31Ai+KoXfCN6minz2BNONvSyC/RAS8oegu69jJO9
        rEBs+Ac0psAKrMShPyJofiWEF21v2m1CaTvYw0M=
X-Google-Smtp-Source: APXvYqwNhqXPixqQdvIZREeb21DXE+SjKxGOu2cNW/TosxXn5AtNHbCRC9DPlCZGp4YcZ04oF4pl/2wulLtt3SPnPOs=
X-Received: by 2002:ac8:21ae:: with SMTP id 43mr13411822qty.223.1576257197339;
 Fri, 13 Dec 2019 09:13:17 -0800 (PST)
MIME-Version: 1.0
References: <MWHPR12MB13438C0C72FA5811B29FD00FCB5A0@MWHPR12MB1343.namprd12.prod.outlook.com>
In-Reply-To: <MWHPR12MB13438C0C72FA5811B29FD00FCB5A0@MWHPR12MB1343.namprd12.prod.outlook.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Fri, 13 Dec 2019 12:13:05 -0500
X-Gmail-Original-Message-ID: <CA+5PVA4T5NBwv01W06MNH06De7BW86_vjhrQxjAD-TscjgdNGg@mail.gmail.com>
Message-ID: <CA+5PVA4T5NBwv01W06MNH06De7BW86_vjhrQxjAD-TscjgdNGg@mail.gmail.com>
Subject: Re: pull request: Linux-firmware: Update cxgb4 firmware to 1.24.11.0
To:     Vishal Kulkarni <vishal@chelsio.com>
Cc:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 12:36 AM Vishal Kulkarni <vishal@chelsio.com> wrote:
>
> Hi,
>
> Kindly pull the new firmware from the following URL:
> git://git.chelsio.net/pub/git/linux-firmware.git for-upstream
>
> Thanks,
> Vishal
>
> The following changes since commit e8a0f4c9314754d8b2cbe9840357d88a861c438a:
>
>   rtl_nic: add firmware rtl8168fp-3 (2019-11-18 16:16:01 -0500)
>
> are available in the git repository at:
>
>   git://git.chelsio.net/pub/git/linux-firmware.git master
>
> for you to fetch changes up to af4c4be392494418ecf25279bfd4135eb7db69e3:
>
>   cxgb4: Update firmware to revision 1.24.11.0 (2019-12-10 21:22:17 -0800)
>
> ----------------------------------------------------------------
> Vishal Kulkarni (1):
>       cxgb4: Update firmware to revision 1.24.11.0
>
>  WHENCE                   |  12 ++++++------
>  cxgb4/t4fw-1.24.11.0.bin | Bin 0 -> 568832 bytes
>  cxgb4/t4fw-1.24.3.0.bin  | Bin 571904 -> 0 bytes
>  cxgb4/t5fw-1.24.11.0.bin | Bin 0 -> 673280 bytes
>  cxgb4/t5fw-1.24.3.0.bin  | Bin 662016 -> 0 bytes
>  cxgb4/t6fw-1.24.11.0.bin | Bin 0 -> 727552 bytes
>  cxgb4/t6fw-1.24.3.0.bin  | Bin 714240 -> 0 bytes
>  7 files changed, 6 insertions(+), 6 deletions(-)
>  create mode 100644 cxgb4/t4fw-1.24.11.0.bin
>  delete mode 100644 cxgb4/t4fw-1.24.3.0.bin
>  create mode 100644 cxgb4/t5fw-1.24.11.0.bin
>  delete mode 100644 cxgb4/t5fw-1.24.3.0.bin
>  create mode 100644 cxgb4/t6fw-1.24.11.0.bin
>  delete mode 100644 cxgb4/t6fw-1.24.3.0.bin

Pulled.  kernel.org is down right now, but I'll push it out when it's back up.

josh
