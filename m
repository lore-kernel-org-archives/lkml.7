Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FACCC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F9B2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="T2kYxw6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbfEVOaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 10:30:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46251 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbfEVOaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 10:30:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id r18so1160108pls.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 07:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0m0QjYyjO2xHrKzFzTehhWEPphtJIzzFFRYPzTW3DMQ=;
        b=T2kYxw6M4VFwvrSg9HRUF2uPooKZ2Dk6AmNuLHygKvbtjUp1C79ABGleU4NpWQgtG+
         xyNerFhZb1XMy6mw5lQzehrEE7/NBqYQPzUt9jvyTeLj9vsYw3pAry+y23L3yjfCjhDJ
         yoMBcgsNSAsgypmbF99mRLSytz+s/UDYzeuQUPzFC6WTuCtGRKRYUgQx6yvSE/FxlWH2
         pqRUDuI5S4wSMke309nhIOWTIHwzEzKiKdSXZRidURLm26VHEBEOC1iIc3U2gexz0ynG
         vOxHFexpwwsDmgzyeSI00gmNJ0WAnYhTVwEa0K2+6EZjiULYXI9ZcdenQdTGsT3HwctH
         k3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0m0QjYyjO2xHrKzFzTehhWEPphtJIzzFFRYPzTW3DMQ=;
        b=QSRFBuKUKSQZr6ojKTsbOqXxUgP+wdCG962TYxTCCQuUmOBpchDIwBy60cXsrqkIRQ
         CrEdBDZaSfI7Y21iM/2qZy+URaYHM5Gojn/Uj6A3SS7z4Jhcauhj0AFC/EyOrZtACEdo
         DbiuJiu6w6qPu+5K3Xvh28ZRFQnomL0c4Qnri7KfQA5RF1yi+WFAgG2muaK+L25RWYt9
         4OOCpek5vbRDJJ/rF1hRIYL/A/Cyhys0XbgmueqIMQ4k611AmJswFHyFCjr1unih9Ytx
         xpVhoW5IJ5beXrRG8nTdZ49a5vF3HXm7jDT/qLWXZTy0MDMI8b9bDJdBWt8EEDJdtL6s
         HRQA==
X-Gm-Message-State: APjAAAWVxPKeZqjo2Qeu37R0x4TgvlMiqDjBI1O9Wzqn76qPXo19PPjh
        IXQJCLYaYupJL/o1YLLuPI3lvdVl1TPC3vOqs1sEiQ==
X-Google-Smtp-Source: APXvYqxvo1fFJOMp10yWhcwkQF+EVwPZOIUCu4QXMKCMejzytyZV3guibp+FcWp+LRDJRt9vDpZ3/2/a9GARbq9GNuo=
X-Received: by 2002:a17:902:3103:: with SMTP id w3mr15769604plb.187.1558535429532;
 Wed, 22 May 2019 07:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190515064405.3981-1-jeffrin@rajagiritech.edu.in> <20190521181125.anqj32v3gcwjxs3z@salvia>
In-Reply-To: <20190521181125.anqj32v3gcwjxs3z@salvia>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Wed, 22 May 2019 19:59:53 +0530
Message-ID: <CAG=yYwkAUzGZWdVpcjRScARyOyO9KaTCL_7LUxaav5os+6rsEA@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: netfilter: missing error check when setting
 up veth interface
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        netfilter-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to all !

On Tue, May 21, 2019 at 11:41 PM Pablo Neira Ayuso <pablo@netfilter.org> wrote:
>
> On Wed, May 15, 2019 at 12:14:04PM +0530, Jeffrin Jose T wrote:
> > A test for  the basic NAT functionality uses ip command which
> > needs veth device.There is a condition where the kernel support
> > for veth is not compiled into the kernel and the test script
> > breaks.This patch contains code for reasonable error display
> > and correct code exit.
>
> Applied, thanks.



-- 
software engineer
rajagiri school of engineering and technology
