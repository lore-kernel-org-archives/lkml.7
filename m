Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3ECC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46CD20850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388263AbfCAOCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:02:06 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46143 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfCAOCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:02:05 -0500
Received: by mail-qt1-f196.google.com with SMTP id z25so27742201qti.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 06:02:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Uex5KM56e13eMtNZ/q1K2kPl06SHl4vOq/4iU7Wa6s=;
        b=DcuWuyWa9iH7rXhuwpizmTMmJ30wf5G8Jg5shCvL4TrnbVsPr5ylRZ5bVteljgFHRY
         uYPsmNRjhMlv2VmzzqOfRKWWLLXiFge1q2CDuP8jWWXtU/8Wo0kCw/TQMH81bFmV4/kT
         5ZsgwisX/7iL1cjVOxTCGcW/LZSZkjAmEDn8aOQXw9fDTzSYkbS2J7pOFGGVr7q108gb
         XR7kJEQAgWHzS1Gp/B0o1iQIhBTF+QjBPssUzHeadqmUNU8fDzlfcvq0fsTNt7umMkzJ
         d50B3Le+umAa+RHhH6c91oB6pfHy1i9o/Mi7KZUzIbVsOqLNNO78q0ymMrWOeov3jFd6
         O/sg==
X-Gm-Message-State: APjAAAVSN8e0yM61yxGIMLVXI5Z2Whq3thxR8yuX52wKiRfY6zsHFLOv
        pU6tf2ZwnNySlGB4QxS0i+nImMceMlrfl+SDd+k=
X-Google-Smtp-Source: APXvYqwe1fRzZynsFeqWjR7jPsHz4Pc6lA2juCtLbGNwy7QlS/v6nowrAHG0d6SdR/8Tdv5G8z3+MFUuwAa8LmK23VQ=
X-Received: by 2002:ac8:237b:: with SMTP id b56mr3945249qtb.343.1551448925053;
 Fri, 01 Mar 2019 06:02:05 -0800 (PST)
MIME-Version: 1.0
References: <CAHUa44FUFCW82U3+a+t1M0u6va+D3PuGGBU8cPb_D055hzu3DQ@mail.gmail.com>
In-Reply-To: <CAHUa44FUFCW82U3+a+t1M0u6va+D3PuGGBU8cPb_D055hzu3DQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 1 Mar 2019 15:01:47 +0100
Message-ID: <CAK8P3a1LMziQG2W7x46k=nyuo1MQbX03DG8ynbp9DSq+rjxczg@mail.gmail.com>
Subject: Re: [GIT PULL] tee subsys for v5.1
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     arm-soc <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 2:12 PM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Hello arm-soc maintainers,
>
> Please pull these small TEE subsystem updates. The license for two .h
> files in OP-TEE driver is clarified with a dual license. The kernel
> space tee client interface is complemented with cancellation support.
>
> I've based this pull request on the last pull request I did (now in
> the drivers/tee branch) in order to avoid a conflict with "tee: add
> cancellation support to client interface".

Pulled into arm/drivers, thanks!

     Arnd
