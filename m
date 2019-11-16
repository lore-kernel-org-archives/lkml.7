Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20059C43141
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 11:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028EA20723
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 11:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfKPLht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 06:37:49 -0500
Received: from smtpq3.tb.mail.iss.as9143.net ([212.54.42.166]:43306 "EHLO
        smtpq3.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726794AbfKPLht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 06:37:49 -0500
X-Greylist: delayed 1201 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Nov 2019 06:37:48 EST
Received: from [212.54.42.137] (helo=smtp6.tb.mail.iss.as9143.net)
        by smtpq3.tb.mail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <jongk@linux-m68k.org>)
        id 1iVw5K-0001uT-Ao; Sat, 16 Nov 2019 12:17:46 +0100
Received: from mail-wr1-f49.google.com ([209.85.221.49])
        by smtp6.tb.mail.iss.as9143.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <jongk@linux-m68k.org>)
        id 1iVw5K-0002In-6g; Sat, 16 Nov 2019 12:17:46 +0100
Received: by mail-wr1-f49.google.com with SMTP id z10so13713397wrs.12;
        Sat, 16 Nov 2019 03:17:46 -0800 (PST)
X-Gm-Message-State: APjAAAUdkn0Ngv2jDyck1lAK/7xwHBF07YKWZrVL97tedxHaaE18o93m
        5nO044Czncv3fD/U4jZTj6tCLi6DTZJ5/CdXB3g=
X-Google-Smtp-Source: APXvYqw/7lcFxT9yyKE9hWbxK5yt8guWAVH+vLioGfHCfHYgbjwitQxb/z5XuyfCKtxcES40TIOGkaHEdv0M6kJVLIk=
X-Received: by 2002:a05:6000:14a:: with SMTP id r10mr9800680wrx.310.1573903065942;
 Sat, 16 Nov 2019 03:17:45 -0800 (PST)
MIME-Version: 1.0
References: <20191116110548.8562-1-jongk@linux-m68k.org>
In-Reply-To: <20191116110548.8562-1-jongk@linux-m68k.org>
From:   Kars de Jong <jongk@linux-m68k.org>
Date:   Sat, 16 Nov 2019 12:17:34 +0100
X-Gmail-Original-Message-ID: <CACz-3rhCfnvHALYx75-aUyJWTHh3Cb9=KLfVuGh+L=FR6cJ33A@mail.gmail.com>
Message-ID: <CACz-3rhCfnvHALYx75-aUyJWTHh3Cb9=KLfVuGh+L=FR6cJ33A@mail.gmail.com>
Subject: Re: [PATCH] rtc: msm6242: Fix reading of 10-hour digit
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-SourceIP: 209.85.221.49
X-Authenticated-Sender: karsdejong@home.nl (via SMTP)
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=WMwBoUkR c=1 sm=1 tr=0 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=MeAgGD-zjQ4A:10 a=tBb2bbeoAAAA:8 a=b38HSYhmjrW_fiXeJ8EA:9 a=QEXdDO2ut3YA:10 a=Oj-tNtZlA1e06AYgeCfH:22
X-Ziggo-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to add:

Fixes: 4f9b9bba1dd1 ("rtc: Add an RTC driver for the Oki MSM6242")

Op za 16 nov. 2019 om 12:06 schreef Kars de Jong <jongk@linux-m68k.org>:
>
> The driver was reading the wrong register as the 10-hour digit due to
> a misplaced ')'. It was in fact reading the 1-second digit register due
> to this bug.
>
> Also remove the use of a magic number for the hour mask and use the define
> for it which was already present.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Tested-by: Kars de Jong <jongk@linux-m68k.org>
> Signed-off-by: Kars de Jong <jongk@linux-m68k.org>
