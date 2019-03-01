Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A8AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5131D20850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388228AbfCAOAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:00:25 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:35073 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfCAOAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:00:25 -0500
Received: by mail-qt1-f176.google.com with SMTP id p48so27809716qtk.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 06:00:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g9xkd/Gxhphfj3HVnbxPQnb1kGzm/fVUa3UHv2M59Ro=;
        b=Qj02S1P3Q2l8QGmEPUFrcQTQMTjaF5sXUK6JDebLYL14O9U1IGf4xB8FGeIHfGauNJ
         k4Mw2tn9CxZkbKy8Ixb/rpHhs5A0yUUSH77mxWwVxs4qqzwQeRZbuwRozlPi4131LSZU
         zIvXKCsozMZPW+3jkfeSMiBVodYkPTe6lfnK2+61z7VKzGAZt+s/dkfszdSj2aBwY2hw
         OulaET8PM3UNG2yN2vc24i9t2W/keWUMS7XStNgE9sY/e4QexofXHt3+HFAST956l6ej
         hGvmERLrMKVWtmvBH7Lt6s6rSKy6a3wihp9cSIyH+RULaanN/XOoopGU6lpUEkG8yAUA
         KytQ==
X-Gm-Message-State: APjAAAV9ocfvbJ3eGTKxEjJohV9qqyVZ8KB/QCVN1mlNI72rqFQgCf5I
        9fCWDewy1wGv7GzQWjFrveug3AxuzTTsEoPTpyU=
X-Google-Smtp-Source: APXvYqzzXra1Q//BdtEJXDRE2tiG9F2FPvDiQG6XYu3dE71nW2yHz+Slrqp09Pc6PeapBAm2Ul/FjqfsaHIpRj2otik=
X-Received: by 2002:a0c:b758:: with SMTP id q24mr3799112qve.149.1551448824305;
 Fri, 01 Mar 2019 06:00:24 -0800 (PST)
MIME-Version: 1.0
References: <CAHUa44G17ksP7qcXTeNb_8TXby++=DmSo9FcDUTNsWBVqL7wpA@mail.gmail.com>
In-Reply-To: <CAHUa44G17ksP7qcXTeNb_8TXby++=DmSo9FcDUTNsWBVqL7wpA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 1 Mar 2019 15:00:05 +0100
Message-ID: <CAK8P3a3Rk-pcsjNfz_ipNiXdSQS6EvL_vjbEUNjbUwZwJzF4TQ@mail.gmail.com>
Subject: Re: [GIT PULL] tee subsys fixes for v5.0
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     arm-soc <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 1:32 PM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Hello arm-soc maintainers,
>
> Please pull this last minute fix for the OP-TEE driver.

Pulled into arm/fixes, thanks!

     Arnd
