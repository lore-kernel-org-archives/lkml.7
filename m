Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9899EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5275820643
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OMPm4L4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfDDIEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:04:20 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:43763 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfDDIET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:04:19 -0400
Received: by mail-ot1-f50.google.com with SMTP id u15so1490436otq.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 01:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MZTD5lcSkqdX468EaoI13XNXlQFmwBCat5u7A7aq3SM=;
        b=OMPm4L4pfKutSn0QGL9bIjz4WEf7RfWVv/S1uWoIsPM/zWEp2ibmX/n5PJE1+a4wh+
         5PYTb/y8SFuQcFSl7DAmZWpNVFUgwlFeRS7wnO6z4mYQGOMPxocnVhZn/T6bsgDdqLk7
         yWQYyZ3B04X9gEzCZ6fmfHHeb7JiSdUZD7hkMXihuEkhu4cjbg6O6QTgG9hxqHFecLR6
         O7qjKN75MyCyfzH3OxOQo3D/irPYpl8EC8NL+CuSYyJKAojUirsHeVHwVECd9BNZ2jE4
         2Vqhg6ZTmF+FXMvnPUyhV2ZM0JXA4up5G+UM0XynOPtglfPnSQ5sKwjKnpfYIdolmwm4
         cxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MZTD5lcSkqdX468EaoI13XNXlQFmwBCat5u7A7aq3SM=;
        b=sclm58VvmHTGQB7k/v6sZmXS2sXMJ58f6BBRF/Zlw+k7GmKdTDF4Cwv39R90wGjxce
         7WRFn1GsRtHnANkCWxXub299LK3kGdT31PctIYH77QAxYBsDj5oV0pMM4H+hJ9vYwVQS
         6XG/pSEYPnAtGUvc/hcjqikdjDfvK0zQTkUBEG9JuO92sFcRoSX9HOioWFAV/xoreui+
         71Mwq87ab0lICCJrhIriPzPbLILQW4Igv4TtYepHrPODYD70Q+kRiNzMGIMsq+66tUlT
         +9TAFt9pBJaDAH2DPY5tzIjW6D75KWxeejmKHq599SZbQGgfCTyGDXW/OID27qpTLMJF
         MDMg==
X-Gm-Message-State: APjAAAU8py8gbg0nz3ZMoDj2coUL1UnfauBxm12J1M55ubvaMDf2tXp1
        G+a6bAWfYX/0U5keDbEvRAT7OE+VuOvr+siV2YT2eg==
X-Google-Smtp-Source: APXvYqzFbT5oErZ8ETBmXOvyaDJXGP2LoSdpzZf6KxUYOJqyMx1nd1mVnq18zPFcRApFuoe+/31U91SHRf7bzbv7rKk=
X-Received: by 2002:a9d:7449:: with SMTP id p9mr3006239otk.325.1554365058979;
 Thu, 04 Apr 2019 01:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190404075603.11680-1-colin.king@canonical.com>
In-Reply-To: <20190404075603.11680-1-colin.king@canonical.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 4 Apr 2019 16:04:07 +0800
Message-ID: <CAMz4kuKAWqt-2iQ2ASHx-MRoNKqy76BvVO7temV-Me4w=y5nMw@mail.gmail.com>
Subject: Re: [PATCH][next] ASoC: sprd: Fix spelling mistake "faied" -> "failed"
To:     Colin King <colin.king@canonical.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2019 at 15:56, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There are two identical spelling mistakes in dev_err messages. Fix them.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks for fixing my mistakes.
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>

-- 
Baolin Wang
Best Regards
