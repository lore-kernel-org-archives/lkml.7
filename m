Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCF8C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 11:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40762133F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 11:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565868542;
	bh=xsDOK/RvH6NC83CrnpMsXVuR6bMBD+bxF8hmHMB8Usg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cYDRPkDC/k/2kVoL/lk3CtA9PR52SD08LFT2hB6GsMdvJnCUfSNV86xF60IHE6x+x
	 /fVG1QSmV9Tne77K/2voRYxweyAHdNRx6grdYPCNExnLY3E+s9M7YIPjpqWgOGFRxy
	 OU6Iao+YywcLV4zThyuuG4ev57tTI/xdzB79u6aA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbfHOL3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 07:29:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730452AbfHOL3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 07:29:01 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2D9F2064A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 11:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565868541;
        bh=xsDOK/RvH6NC83CrnpMsXVuR6bMBD+bxF8hmHMB8Usg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gSUWjdsDExsJMrXnrjkONNZmCVRVhBVtov7ZfmA6neAqjFAhq0YijqvSKuhwJy8rO
         bVOtbJRirDLVOO1xa4G75q1eD6REcgviYLqPcoL7p7A2SIwVu8kf94T8Ca29lSDsbb
         LombbvUFtpQlB2GEWGBHaMTA81MhkA/0KDciLyrk=
Received: by mail-qt1-f175.google.com with SMTP id x4so1941208qts.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 04:29:00 -0700 (PDT)
X-Gm-Message-State: APjAAAW+Ks7bovZlGTCTdi/EVhF84s0rnOd4I60IcXVoR2ttLScLlXdZ
        1ev85pdo8NGBlKLjSEi8gDwSkAaR0r2hatypSzA=
X-Google-Smtp-Source: APXvYqwvx+sMmwYtsN4fUcsT07hdR+FyBH7zCj5rFvJIX2CvsHIdCOaHhm7fxPt8i1skqGiAYEGUL4Bym+TcUAU/5vg=
X-Received: by 2002:ac8:1a86:: with SMTP id x6mr3476583qtj.231.1565868540175;
 Thu, 15 Aug 2019 04:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <MWHPR12MB134396EEFEFF70FE0387BA75CBD50@MWHPR12MB1343.namprd12.prod.outlook.com>
In-Reply-To: <MWHPR12MB134396EEFEFF70FE0387BA75CBD50@MWHPR12MB1343.namprd12.prod.outlook.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Thu, 15 Aug 2019 07:28:48 -0400
X-Gmail-Original-Message-ID: <CA+5PVA49fN-EE7OWshzMOnO5_njcwz57rjtx=2kiyJDZfSqOzw@mail.gmail.com>
Message-ID: <CA+5PVA49fN-EE7OWshzMOnO5_njcwz57rjtx=2kiyJDZfSqOzw@mail.gmail.com>
Subject: Re: pull request: Linux-firmware: Update cxgb4 firmware to 1.24.3.0
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

On Tue, Aug 6, 2019 at 6:38 AM Vishal Kulkarni <vishal@chelsio.com> wrote:
>
> Hi,
>
> Kindly pull the new firmware from the following URL:
> git://git.chelsio.net/pub/git/linux-firmware.git for-upstream
>
> Thanks,
> Vishal
>
>
> The following changes since commit dff98c6c57383fe343407bcb7b6e775e0b87274f:
>
>   Merge branch 'master' of git://github.com/skeggsb/linux-firmware (2019-07-26 07:32:37 -0400)
>
> are available in the git repository at:
>
>
>   git://git.chelsio.net/pub/git/linux-firmware.git for-upstream
>
> for you to fetch changes up to b1e26aaebfdc34827c23a96ef3948298137f72e9:
>
>   cxgb4: update firmware to revision 1.24.3.0 (2019-08-06 00:33:02 -0700)
>
> ----------------------------------------------------------------
> Vishal Kulkarni (1):
>       cxgb4: update firmware to revision 1.24.3.0
>
>  WHENCE                  |  12 ++++++------
>  cxgb4/t4fw-1.23.4.0.bin | Bin 570880 -> 0 bytes
>  cxgb4/t4fw-1.24.3.0.bin | Bin 0 -> 571904 bytes
>  cxgb4/t4fw.bin          |   2 +-
>  cxgb4/t5fw-1.23.4.0.bin | Bin 659456 -> 0 bytes
>  cxgb4/t5fw-1.24.3.0.bin | Bin 0 -> 662016 bytes
>  cxgb4/t5fw.bin          |   2 +-
>  cxgb4/t6fw-1.23.4.0.bin | Bin 708608 -> 0 bytes
>  cxgb4/t6fw-1.24.3.0.bin | Bin 0 -> 714240 bytes
>  cxgb4/t6fw.bin          |   2 +-
>  10 files changed, 9 insertions(+), 9 deletions(-)
>  delete mode 100644 cxgb4/t4fw-1.23.4.0.bin
>  create mode 100644 cxgb4/t4fw-1.24.3.0.bin
>  delete mode 100644 cxgb4/t5fw-1.23.4.0.bin
>  create mode 100644 cxgb4/t5fw-1.24.3.0.bin
>  delete mode 100644 cxgb4/t6fw-1.23.4.0.bin
>  create mode 100644 cxgb4/t6fw-1.24.3.0.bin

Pulled and pushed out.  Thanks.

josh
