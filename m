Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7BCC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 04:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F14A20830
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 04:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdoiUL3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfJFEGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 00:06:18 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45123 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfJFEGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 00:06:18 -0400
Received: by mail-lj1-f194.google.com with SMTP id q64so10226929ljb.12
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 21:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=DTKbvHDTFVuJGZPE5cA4Wfj8TVUSCvi2fl9LQBE1IpE=;
        b=AdoiUL3wvlqm9VsCMZguHpKX5Le+SkNvypwhgWW1v00C64aXprf7VjJzs0H2opC4gt
         pTAxHajUTzHeGkhzyEUCdM8tK83lrm2L0mQzIieWebmRv0QGJs+zfQzVhSmTQje4jqt+
         9iVJynXc2aFyQzrx0zElq7S0Z+icQHdlvJ8rzLTOy/6IQ7QMx8oQ8TXBqcKl2nO7qipa
         cSzxs06wcQEb+acptX3KCbakXnVDfaurHFQiBGWmho0HK4UMAn0YgTBIhg/xFVR5s+l1
         AwYTcbf30soYE8NOUEa2lIMSxfDk9cKt7DuggIKphro4P2qgbZSiAvTqHskiulDssL4h
         W4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=DTKbvHDTFVuJGZPE5cA4Wfj8TVUSCvi2fl9LQBE1IpE=;
        b=d1M25BYxx7Gg94O70AkDd+YXaqC06CRBKK0tPHbmQ9YoJMH+0tmxFJK2F78v2+Hiqw
         jFutc66B6uW0CIQ/AVWWrzuJLnWnRDcoLu/sEGYsp8NnXCFILR+qX+WOrNFBVmY8j3je
         i2naRNMdJlWPZPxNrbUOxzhPwSaXOzZKbyuQQSTcn2cDvhW90h4jtbmca4v+75t2QqZa
         iatdWQOV8zrUiBUoBnFXbYxj6webBuRdm7sPvXN0JHkhPs2hfndB9iGYWrTh+58IW/SC
         0pPvu7AjHtk7AZ3s9YGPRbXhqeB2zmy61dzhZl0L/CyBwaYpTyy/kQ2Q7H7bOkncp0YZ
         GwxA==
X-Gm-Message-State: APjAAAUAPuVL7/aZi3wsFEU2+g7vrQ6Jh2nD4EoUqLGO11yPOk9QarCr
        snr0/+k9mZYtoa0F9pcFUQFTSAQDNcswLcdfFFVlFD2PhVo7vw==
X-Google-Smtp-Source: APXvYqxizIXSZoHHBaT7cDP9OgJQ2gen3aZ4z2Cbc9BMzO2Ycj2HbaGn5sKSnR3QK2dwp8Ym7vysBNDH2qJdLFzFr9Y=
X-Received: by 2002:a2e:9a4e:: with SMTP id k14mr10727508ljj.129.1570334773277;
 Sat, 05 Oct 2019 21:06:13 -0700 (PDT)
MIME-Version: 1.0
From:   Turritopsis1 Dohrnii1 Teo1 En1 Ming1 
        <teo.en.ming.smartphone@gmail.com>
Date:   Sun, 6 Oct 2019 12:06:00 +0800
Message-ID: <CA+5xKD7y7idoUkyV5Lw1AAiP672etnjvXbXDYE1ce5ziDwGJug@mail.gmail.com>
Subject: Running BOINC Project (SETI@home) for 48 Hours Killed My Galax
 GeForce GTX 1650 4 GB GDDR5 GPU
To:     linux-kernel@vger.kernel.org
Cc:     Turritopsis Dohrnii Teo En Ming <teo.en.ming.smartphone@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Running BOINC Project (SETI@home) for 48 Hours Killed My
Galax GeForce GTX 1650 4 GB GDDR5 GPU

Good day from Singapore,

I bought my Galax GeForce GTX1650 4 GB GDDR5 GPU on 29th September 2019 Sunday.

REFERENCES:

[1] http://lkml.iu.edu/hypermail/linux/kernel/1909.3/04148.html

[2] http://lists.linuxfromscratch.org/pipermail/lfs-chat/2019-September/029039.html

[3] https://lists.freebsd.org/pipermail/freebsd-chat/2019-September/007361.html

[4] https://lkml.org/lkml/2019/10/1/200

[5] http://lists.linuxfromscratch.org/pipermail/lfs-chat/2019-October/029040.html

[6] https://lists.freebsd.org/pipermail/freebsd-chat/2019-October/007363.html

At the time of this writing, it is 5th October 2019 Saturday.

Over the past 48 hours, I have been running BOINC project (SETI@home)
on my Windows 10 Home Edition home desktop computer. This morning, my
home desktop computer suddenly gave me a Blue Screen of Death (BSOD)
with the error code: "Windows System Exception".

I thought my Windows 10 had become corrupted. ***Every time Windows 10
boots up, it would show me a BLANK SCREEN after a few seconds.***

I have tried the following resolution methods for about 2 hours on a
Saturday morning but NOTHING worked.

1. I tried to perform Windows Startup Repair but it would not run.

2. I tried to start Windows in SAFE mode but it would show me a BLANK
SCREEN as well.

3. I tried to start Windows in SAFE mode with Networking but it would
show me a BLANK SCREEN as well.

4. I tried to start Windows with low video resolution but it would
show me a BLANK SCREEN as well.

5. I tried to start Windows with Driver Signature Signing disabled but
it would show me a BLANK SCREEN as well.

6. I tried to run "sfc /scannow" on a command prompt but it would not run.

7. I tried to uninstall Windows quality updates but it would still
show me a BLANK SCREEN.

8. I tried to uninstall Windows feature update but it would still show
me a BLANK SCREEN.

9. I tried to perform System Restore but Windows would still show me a
BLANK SCREEN.

In short, none of the resolution methods which I have tried above worked.

Exasperated, I tried to reset Windows 10 while retaining personal
data. After resetting Windows 10, I *successfully* booted into Windows
with a Basic Microsoft Display Adapter Driver. Then I tried to install
NVIDIA drivers. When NVIDIA drivers started to load, my Windows showed
me a BLANK SCREEN AGAIN. At this point, I realized that my Galax
GeForce GTX 1650 4 GB GDDR5 GPU has been killed/fried by BOINC project
(SETI@home).

On 5th October 2019 Saturday afternoon, I took my Galax GeForce GTX
1650 4 GB GDDR5 GPU to the 4th story computer shop in Sim Lim Square
in Singapore for a 7-day 1-to-1 exchange, citing that the Galax GPU
has malfunctioned. The shop keeper gave me a MSI GeForce GTX 1650
Ventus XS OC 4 GB GDDR5 GPU as replacement but I have to top up
SGD$10.

When I brought the replacement MSI GeForce GTX 1650 Ventus XS OC 4 GB
GDDR5 GPU home, I plugged it into my home desktop computer and Windows
10 booted up *SUCCESSFULLY*. I proceeded to reinstall NVIDIA drivers
again. Everything went well and everything is working fine now.

Conclusion: BOINC project (SETI@home) fried my Galax GeForce GTX1650 4
GB GDDR5 GPU after 48 hours. Now I am actually afraid of running
SETI@home again for fear of frying my replacement MSI GeForce GTX 1650
4 GB GDDR5 GPU again.

Question: Will BOINC project (SETI@home) be able to work towards
ensuring that it will not fry anyone's GPU again? I had my whole
Saturday wasted. It was only Saturday evening when I returned home and
got everything working again.

Thank you very much.

EXTERNAL LINKS:

[1] https://boinc.berkeley.edu/forum_thread.php?id=13147

[2] https://groups.google.com/a/ssl.berkeley.edu/forum/#!topic/boinc_dev/BcDXSjPv314

[3] https://groups.google.com/a/ssl.berkeley.edu/forum/#!topic/boinc_alpha/Pc8ew5y0yRQ

[4] https://groups.google.com/forum/#!topic/boinc_admin/J6FelluHIGk

[5] https://setiathome.berkeley.edu/forum_thread.php?id=84727#2014337





-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

********************************************************************************************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019 and refugee seeking attempts at the
United Nations Refugee Agency Bangkok (21 Mar 2017) and in Taiwan (5
Aug 2019):

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----
