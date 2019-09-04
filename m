Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCCEC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADECC2339D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567595771;
	bh=jMomdeRZ44KvI27hRcK5KxmVekTjZj7kvWDZM2hnl/Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UFalhVzidCf/cqKJkCTjwg/3r/88DXGNVzHdrJQAwYcmqzQqEdyjykj5O629Dr6Lo
	 KbFHwV6kFUr9GreWvHOezlO5OF7sc459iaUAiGg1h5BeoWpZfqil1V/MvZGzUYtgta
	 CQ+6K31q9CymMeXOsVR9RfKy1/KeITkyoC3dhfvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbfIDLQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 07:16:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729398AbfIDLQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:16:10 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C756222CF7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2019 11:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567595768;
        bh=jMomdeRZ44KvI27hRcK5KxmVekTjZj7kvWDZM2hnl/Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l8muRXX2SK/t6WTWEUgTLopvw1Lhrm6b1V+BEQHgaPmU+5+ikuE857dThQwrHod6d
         byILHGVTag9hHTqCXxOm6WhYZKogcoBwYvq3BeHeCqpicz81ucp+C9t7QyhD8r4yCC
         Qlc6ckikHtK8TxxtvV1leRj9e08O0HPH9FXpjRh8=
Received: by mail-qk1-f179.google.com with SMTP id f13so19112172qkm.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 04:16:08 -0700 (PDT)
X-Gm-Message-State: APjAAAW6R+WJpOBvjDQd6RM7AbqA/OuZwhMrqOTF0BGI9dNHiMFtO26V
        /ozcZbajRMREBQQ8zspFkHhUm+MChiTOUOCTnRU=
X-Google-Smtp-Source: APXvYqzXntTf9MsfT1KP/+kDxZLIGzkNr+/yeq9ERExyZpJyt7UWijT4UieYo2Ok2V+lJBk89azCCkqFBTYphQTj3J4=
X-Received: by 2002:a37:4995:: with SMTP id w143mr39184308qka.224.1567595768000;
 Wed, 04 Sep 2019 04:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <MWHPR12MB13436D4BF9438757EF28CA0CCBBD0@MWHPR12MB1343.namprd12.prod.outlook.com>
In-Reply-To: <MWHPR12MB13436D4BF9438757EF28CA0CCBBD0@MWHPR12MB1343.namprd12.prod.outlook.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Wed, 4 Sep 2019 07:15:57 -0400
X-Gmail-Original-Message-ID: <CA+5PVA76eLJySkDhkneZbX2fdJgQLU0j=4+EpVsvE_fvbR0x4g@mail.gmail.com>
Message-ID: <CA+5PVA76eLJySkDhkneZbX2fdJgQLU0j=4+EpVsvE_fvbR0x4g@mail.gmail.com>
Subject: Re: pull request: Linux-firmware: Add cxgb4 firmware config files
To:     Vishal Kulkarni <vishal@chelsio.com>
Cc:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        dt <dt@chelsio.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 8:31 AM Vishal Kulkarni <vishal@chelsio.com> wrote:
>
> Hi,
>
> Chelsio driver loads firmware configuration file to allow
> firmware to distribute resources before chip bring up. Chelsio NIC
> driver, cxgb4 searches for firmware config file at /lib/firmware/cxgb4/
> directory.
>
> Two predefined configuration files are available - default and
> hashfilter. Default configuration file equally distributes
> resources across all features, such as iSCSI, iWARP, Crypto, etc.
> On the other hand, hashfilter configuration file borrows some
> resources by disabling the iSCSI, iWARP, Crypto, etc. features,
> and redistributes them to increase offloading more number of flows
> to hardware via tc-flower.
>
> Please pull the files to /lib/firmware/cxgb4/config directory
> and create a t6-config.txt symbolic link in /lib/firmware/cxgb4/ to
> /lib/firmware/cxgb4/config/t6-config-default.txt. The same needs
> to be done for t5-config-default.txt and t4-config-default.txt.
>
> The directory structure should look like below.
> # tree /lib/firmware/cxgb4/
> .
> =E2=94=9C=E2=94=80=E2=94=80 config
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 t4-config-default.txt
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 t5-config-default.txt
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 t5-config-hashfilter.txt
> =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 t6-config-default.txt
> =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 t6-config-hashfilter.txt
> =E2=94=9C=E2=94=80=E2=94=80 t4-config.txt -> config/t4-config-default.txt
> =E2=94=9C=E2=94=80=E2=94=80 t5-config.txt -> config/t5-config-default.txt
> =E2=94=9C=E2=94=80=E2=94=80 t6-config.txt -> config/t6-config-default.txt
>
>
> The following changes since commit 7307a29961ad2765ebcad162da699d2497c5c3=
f8:
>
>   brcm: Add 43455 based AP6255 NVRAM for the Minix Neo Z83-4 Mini PC (201=
9-08-27 08:04:55 -0400)
>
> are available in the git repository at:
>
>   git://git.chelsio.net/pub/git/linux-firmware.git for-upstream

Pulled and pushed out.

josh

>
> for you to fetch changes up to 2f885ba53dca06eeaf3d31cfa74fa9d30ab1dcc6:
>
>   Chelsio driver loads firmware configuration file to allow firmware to d=
istribute resources before chip bring up. Chelsio NIC driver, cxgb4 searche=
s for firmware config file at /lib/firmware/cxgb4/ directory. (2019-08-29 0=
5:40:00 -0700)
>
> ----------------------------------------------------------------
> Vishal Kulkarni (1):
>       Chelsio driver loads firmware configuration file to allow     firmw=
are to distribute resources before chip bring up. Chelsio NIC     driver, c=
xgb4 searches for firmware config file at /lib/firmware/cxgb4/     director=
y.
>
>  WHENCE                                 |   8 +
>  cxgb4/configs/t4-config-default.txt    | 562 +++++++++++++++++++++++++++=
+++
>  cxgb4/configs/t5-config-default.txt    | 613 +++++++++++++++++++++++++++=
++++++
>  cxgb4/configs/t5-config-hashfilter.txt | 467 +++++++++++++++++++++++++
>  cxgb4/configs/t6-config-default.txt    | 599 +++++++++++++++++++++++++++=
+++++
>  cxgb4/configs/t6-config-hashfilter.txt | 430 +++++++++++++++++++++++
>  cxgb4/t4-config.txt                    |   1 +
>  cxgb4/t5-config.txt                    |   1 +
>  cxgb4/t6-config.txt                    |   1 +
>  9 files changed, 2682 insertions(+)
>  create mode 100644 cxgb4/configs/t4-config-default.txt
>  create mode 100644 cxgb4/configs/t5-config-default.txt
>  create mode 100644 cxgb4/configs/t5-config-hashfilter.txt
>  create mode 100644 cxgb4/configs/t6-config-default.txt
>  create mode 100644 cxgb4/configs/t6-config-hashfilter.txt
>  create mode 120000 cxgb4/t4-config.txt
>  create mode 120000 cxgb4/t5-config.txt
>  create mode 120000 cxgb4/t6-config.txt
