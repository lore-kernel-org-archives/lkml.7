Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D77C46470
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 20:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689092184B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 20:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="mTZipGuT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfEKU6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 16:58:45 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38340 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfEKU6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 16:58:45 -0400
Received: by mail-pl1-f193.google.com with SMTP id a59so4448210pla.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 13:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=elwgxb8XYgTIriByBWF9deMUc6c8M6Y8MIlBqiZfHjU=;
        b=mTZipGuTJpw81BLSTSjwcm1GDWw+WD8irR2clWCrQZGG6j0nz6y1H2cLsX4a//J5q+
         Pagb/ezxSdc4YarsDh57XLMEKVmslPTc8/9BTs+RFwb43gaqLKTxhTIemfc2bcUT9C/6
         iAoYQrOWqlT6NralpUW0Tc0xlOo4WWiaYyeNYubfFKoCmzr5XS5jT95VxbKYpdhhREbO
         cYdXhCrP7eMT2zIkW9Gm5l5DSeUOFpr7GRqkTYAJ8rjsu97mwDwLUHb9jikhAyzuq/vN
         MvzHBRTnf2pGCjZfRmRSShWJ0d202h1EPNtyqpGmdQQFglMXXp5boIcm50LIILir4gjV
         +Qxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=elwgxb8XYgTIriByBWF9deMUc6c8M6Y8MIlBqiZfHjU=;
        b=QnELY8f+hRuqq+ndzhKYrTodypHnLLKsSnCNn1B6lNiHnvfZC+gNGr2ajJbwp73RuK
         UJL0gxBwCnlaAoNTb4pOPpPpX9/EqOZAPBnDkMa4la+wASWRR82Bl4hg53pmhQLahIWu
         NpRXAIUCzmPdjBCt7G1cDec1BRUbdL2egvHU7gucoDKPDkRqClF5uLRGyH5rStm1en7+
         mpl2pAnUg2M/l+RQooQYnnAsziUg/k651lYmbCIVcqlqWfZgGIF2GyIL/5hSCLDq0NOg
         r/aGzOXzahDgVe/Ess7xMOwcLstM+LO38sUAGOJg5P7GjiaR0Ol5eDalrdwLR7FarY4b
         +5Lg==
X-Gm-Message-State: APjAAAXcWSMyZbxPjlSPpCsHdOZnVaOJjSstGIzHIZ3zI377I9LrGQKK
        Ztx64k1SOjO2nwhXNP/l6ysJVoEHgwl674HrCthBOQ==
X-Google-Smtp-Source: APXvYqy4MaRZEbjhD24D5CDbZW2mpGnc/vgQNNkixPgHTkwzNLc9bAL0OjtOXzd7w0ax4agEGGNIbUQ1gyI5gI+QgxE=
X-Received: by 2002:a17:902:f215:: with SMTP id gn21mr22016322plb.194.1557608324468;
 Sat, 11 May 2019 13:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190405163126.7278-1-jeffrin@rajagiritech.edu.in>
 <20190405164746.pfc6wxj4nrynjma4@breakpoint.cc> <CAG=yYwnN37OoL1DSN8qPeKWhzVJOcUFtR-7Q9fVT5AULk5S54w@mail.gmail.com>
 <c4660969-1287-0697-13c0-e598327551fb@kernel.org> <20190430100256.mfgerggoccagi2hc@breakpoint.cc>
 <20190430105225.bu5pil5fjxkltu4q@salvia>
In-Reply-To: <20190430105225.bu5pil5fjxkltu4q@salvia>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Sun, 12 May 2019 02:28:07 +0530
Message-ID: <CAG=yYw=YQzZQd-uyVXEgdTtLC9rpO5DE7SYW3hxQD3bVS8SD=g@mail.gmail.com>
Subject: Re: [PATCH] selftests : netfilter: Wrote a error and exit code for a
 command which needed veth kernel module.
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, shuah <shuah@kernel.org>,
        linu-kselftest@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pablo,

Please follow up on the mail you sent.
This is for my interest to see my patch upstream

On Tue, Apr 30, 2019 at 4:22 PM Pablo Neira Ayuso <pablo@netfilter.org> wrote:
>
> Cc'ing netfilter-devel@vger.kernel.org
>
> On Tue, Apr 30, 2019 at 12:02:56PM +0200, Florian Westphal wrote:
> > shuah <shuah@kernel.org> wrote:
> > > Would you like me to take this patch through ksleftest tree?
> >
> > Please do, this patch is neither in nf nor nf-next and it looks fine to
> > me.
>
> Indeed, thanks.



-- 
software engineer
rajagiri school of engineering and technology
