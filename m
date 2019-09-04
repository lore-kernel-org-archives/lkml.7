Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAA9C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF3D20882
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbfIDNNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 09:13:21 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:37833 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfIDNNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 09:13:20 -0400
Received: by mail-qk1-f170.google.com with SMTP id s14so19532024qkm.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 06:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QqGOMSkNe8N9ujaKSarLnUIsNh3MsCa5d0oIcsW2/9g=;
        b=L5hjXMZ9eweCzbelw9tK09RkGWGOE+IaF3+XubgjNqokWW7CO8nlLJtWYaWwIzIciW
         VJHQj13uSPBdz7inguMEhUZRmIhR6/cUGee1ox62hes7tf2woJOp0frUaJ3MJg7p+KYB
         9moOO6dtY3NpGOU1MxRYZOHefvJ0trDgxGMJ1CHtFCafI3eJy8uNkIXIafDI2JZMoerI
         2GoNHnewHmMKinQpR3wz8WCKBxRRaXEefTbVZYsT3PvUr4e+WBnIks+qStP8wtxHq8cS
         xNCXyC/64dzlM8Bu34jtWk8PmItgtRvQUQTC6xe+Ucl4v26GrIBy6vLftf1ALXZraYBE
         8N4w==
X-Gm-Message-State: APjAAAXajy0w/KMyQxq5m/NNBkohJ5U7/Z8AEP7ibSXB/0yQjkDkA6fo
        Rxsc1qhSdmmJ7ztESTRl+BhcOF1ZGHeXkGcpNKw=
X-Google-Smtp-Source: APXvYqzO3PFcH/vIwUuhw6gtlDDcL1WT1bcATeUsqqRnxIZTcHH+Qyaju8NPPRLENbew+gTdSZtLJAy6m62D8usUly4=
X-Received: by 2002:a37:4051:: with SMTP id n78mr37746223qka.138.1567602799917;
 Wed, 04 Sep 2019 06:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <1566875507-8067-1-git-send-email-santosh.shilimkar@oracle.com>
In-Reply-To: <1566875507-8067-1-git-send-email-santosh.shilimkar@oracle.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 4 Sep 2019 15:13:03 +0200
Message-ID: <CAK8P3a3_NWWBFrpNpbPH9+47Segi_EaYx2jx5jvPhYJJqR+a7A@mail.gmail.com>
Subject: Re: [GIT PULL] SOC: TI soc updates for 5.4
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc:     arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 5:12 AM Santosh Shilimkar
<santosh.shilimkar@oracle.com> wrote:

> ----------------------------------------------------------------
> soc: TI soc updates for 5.4
>
>  -  Update firmware to support PM domain shared and exclusive support
>  -  Update driver and dt binding docs for the same.
>
> ----------------------------------------------------------------
>
> Lokesh Vutla (3):
>   firmware: ti_sci: Allow for device shared and exclusive requests
>   dt-bindings: ti_sci_pm_domains: Add support for exclusive and shared
>     access
>   soc: ti: ti_sci_pm_domains: Add support for exclusive and shared
>     access

Hi Santosh,

I noticed that your branch is based on top of v5.3-rc2, while my
arm/drivers branch started out from -rc1.

Do you have any dependencies on -rc2 in your changes? If not,
could you please resubmit after rebasing? I can also just
cherry-pick those three commits if that's easier.

      Arnd
