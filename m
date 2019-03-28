Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12284C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36DC2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AUGCurHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfC1DEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 23:04:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35130 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfC1DEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 23:04:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id y197so2235179wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 20:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lu2TuEmX6l4BGzvPtIoKd1uf+A28sCgJXOn0l5A7nIE=;
        b=AUGCurHJLQhw3PbHQ+o3/a8gAJ6j3oDyXlff8qPCRyYZEJhVmTe2RbxxfsHbsTjx5M
         vzobymoMvBVUaEzWV2ZZhjzpfXRvaTK7Ja5c9h15fuBGw4y5H0vxab1o2wscRFxrObY6
         ba/CLtD7CJ9zS9ML7o+i1EJHZgQ3DiJ1hSlW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lu2TuEmX6l4BGzvPtIoKd1uf+A28sCgJXOn0l5A7nIE=;
        b=p2NCh9A9hYa2b1ptWzEmxqJc1EgXNoYoAXBmzssu+J3iuemh4mCkeheysehsAYSfOf
         voi2Ou9AtIasXmSfk+/UEvhWXzfqwWtNqF6xZRIhERa8THmrkHMCgixpn1I1f2wR1URU
         13V6Ff5+iifhEXnxpqwtDHCJ4ZBx+VNwYuplFVsgf8PWGXbjLHIzuU2uiV2937GNRPaS
         G/V7t5Bcqi3NuSFi0xqo8yygQTD2bDhMVZYpkR3DchT5iV/7BRhHvjOaTQBlUwGpg0F8
         O9YgLBnR+78rnWF/on1ZOIB3UOSyob3LSEigy00nDqB7PLj26T7JRDUOS10iM1Pw7duY
         s/sA==
X-Gm-Message-State: APjAAAVocRrXrunw1ZQcubzLVsAxoV12AEvmks5CkYZm19+8SAUQYy5U
        YwV2xH+Nr7XY1rRb24SnmC75j7g4OmqgjqoslHg9Cg==
X-Google-Smtp-Source: APXvYqw87CZ+CW0413yEInCAk3bPvdcDElOFlnIjrOhoHs1q3STBxShxh6y/KRAx4LakchWKPsLIh5pqoKHjLTK5B7Q=
X-Received: by 2002:a7b:cf2c:: with SMTP id m12mr10020507wmg.21.1553742246268;
 Wed, 27 Mar 2019 20:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190328112925.0fbe34e2@canb.auug.org.au>
In-Reply-To: <20190328112925.0fbe34e2@canb.auug.org.au>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Thu, 28 Mar 2019 08:33:54 +0530
Message-ID: <CABe79T5uhZj6Ybo_7xCZ190qRikdJq9i4OBNEb6YQ0sJ7ukp+A@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the phy-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Thanks for the notice.

I sent patch to fix this warning.
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1964942.html

Regards,
Srinath.

On Thu, Mar 28, 2019 at 5:59 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Kishon,
>
> After merging the phy-next tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>
> In file included from include/linux/phy/phy.h:19,
>                  from drivers/phy/broadcom/phy-bcm-sr-usb.c:10:
> drivers/phy/broadcom/phy-bcm-sr-usb.c: In function 'bcm_usb_phy_probe':
> include/linux/device.h:1138:19: warning: 'phy_cfg' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   dev->driver_data = data;
>   ~~~~~~~~~~~~~~~~~^~~~~~
> drivers/phy/broadcom/phy-bcm-sr-usb.c:289:26: note: 'phy_cfg' was declared here
>   struct bcm_usb_phy_cfg *phy_cfg;
>                           ^~~~~~~
>
> Introduced by commit
>
>   a3b96057577c ("phy: sr-usb: Add Stingray USB PHY driver")
>
> --
> Cheers,
> Stephen Rothwell
