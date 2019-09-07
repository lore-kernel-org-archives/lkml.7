Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ED0C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 19:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5051D20863
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 19:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436708AbfIGT57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 15:57:59 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34491 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbfIGT57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 15:57:59 -0400
Received: by mail-qk1-f195.google.com with SMTP id q203so9066807qke.1;
        Sat, 07 Sep 2019 12:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9NPm7pq2etg3aO5AoopkMdbvIMBa6Oa5m8sS5IwERn4=;
        b=EWDhAO3oVx81fbZeHxI1fuMye0+BEfLqYhkZ5oCsWkke9HZRhBf5lZbYC2JxdRmOsf
         sADOPFqrIq9dzM8IN0VLUlI2ZLNSmc5aSR+Gz5cmd4FDM7Ac7zxBNCQsFp3TRqbha0Xo
         MP3Fs5SewXJ7GoyLVAdJadp301v53DQTKH5YigUit9ocoDQVDc/47WIvomjgiIG9vdzN
         punzSat0v67XLc9T8RjYbYHKGSwYBM0f/a0EbZaEL9NRyQtaNzMmUmnHytXEM039bSO+
         HUKBy8BCtydERcGE2ZuLIJnAkbMy8pB3zgLp8v1P8wZZBxWs/iDyP7VV8QchjrIVIoJ/
         Vxhg==
X-Gm-Message-State: APjAAAWHQvPNmeycQqjIFOg2hEvvcv08VZFkCg+Wy8U9nrAClud9rWzN
        eRJAOWshURdPFHkTBAzuj3xBYLXGGL/VmtlTO5/6DcbIaQU=
X-Google-Smtp-Source: APXvYqx8oJMvuPB2/youI+h75v27+Ip96nv7/l7tdwFLO1GMppaXZm3p/ssMxkoocV7Lo+QidZdpBd1QqU5QYX//lI0=
X-Received: by 2002:a05:620a:145a:: with SMTP id i26mr15728941qkl.352.1567886278121;
 Sat, 07 Sep 2019 12:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190828072629.285760-1-lkundrak@v3.sk> <20190907194040.GB25459@amd>
In-Reply-To: <20190907194040.GB25459@amd>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 7 Sep 2019 21:57:42 +0200
Message-ID: <CAK8P3a0nNEoy31oxFL11Y2VHw-O=m8e8JuuQk+FjiPh94GikoA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] ARM: dts: mmp2: devicetree updates
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 7, 2019 at 9:40 PM Pavel Machek <pavel@ucw.cz> wrote:
>
>
> > Here's a couple of updates for the MMP2 SoC devicetree files.
> > I'm wondering if they could be applied to the armsoc tree?
> >
> > Compared to previous submission, the only change is the addition of
> > Acks from Pavel.
>
> Any news here? Having up-to-date dts is kind-of useful....

Thanks for adding me to Cc on your reply. I'm doing the merged for 5.4
and had not noticed this series earlier (I found the mmp3 series by
accident, but that one looked like it was not meant as a submission
for inclusion yet).

I've added the six patches to the arm/late branch in the soc tree
now, they will be in 5.4.

Lubomir, please send all future submissions to soc@kernel.org
(with Cc: to the interested parties) when you want them to be
included in the soc tree. That way they show up in patchwork
and won't get lost.

       Arnd
