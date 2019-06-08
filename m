Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63DAC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 04:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91583208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 04:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CR4N8xJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfFHEy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 00:54:27 -0400
Received: from mail-yw1-f51.google.com ([209.85.161.51]:36454 "EHLO
        mail-yw1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfFHEy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 00:54:27 -0400
Received: by mail-yw1-f51.google.com with SMTP id t126so1513919ywf.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 21:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gdOiKu4uunDevc55Ha6d1X7EDU7JD4k+0gj1JHmzE4M=;
        b=CR4N8xJBvBhNiMx6hY+HITDJ2u/0ZgsO2bNXoNNUZNgWFfclGYQ7tQVu8+ZSEh6Qd/
         uO/ETIoXrwaXUvQzIxfRfY4LcIy4BAQD786tn1rDZFBCWG7lp69GZ7EMcatVb8L/peZ0
         QSzUZ2gVHPOqMVCWKc3LdUG6HOup4Nb0WHsFlJPkb94t8lqyaoKn4JjF/PSruZe84qYC
         X6Y1PKjTHbrv32/n0Hmut+QbGMbHolTLvH//uyWuECCixsgnRl9TyqOyxRwIa6Xvqcxm
         tmK7NSTICFFrumVT3r8ThfeqvakAI0ll++4C8/lZrt7TOjnNWSCoTi+UIvJKYgNaLKCL
         oXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gdOiKu4uunDevc55Ha6d1X7EDU7JD4k+0gj1JHmzE4M=;
        b=k8e8GD8LQ6pTRNnTif7PlasiRr7ooKuWR3rejcNUizNslGQ4C7OcwcvRZGqBoAAJWr
         Iz/ucX9Xd/eGH+BU2pP5Lu/P4w6daqVSyanxVP6KFSdymPPYGreWKQ4qFyFAK8Y5ND6n
         1uAPR+VgGcj1FVlWsE+qoFUV+hdREIXIsVIwmtsHOKcNZVTOQ5RmAChHgNo+z6ZqUHhU
         qjb8ba9cdPrmmC0gw8UoP7HbW49NTxNFrJrZJCzQjqtKlercwKj/Y/XsXwDbUmLg2GuC
         1aS/DHqKh73UI6B1isOdKAI0Io4qtnwZPZH+stoxfuCP7FxVl4QjoeKa9E2jGUMbKcYi
         FYMw==
X-Gm-Message-State: APjAAAWB19Jhzv4QKtUEhkys2o5pAaGMC14or2sTIcd7DGzBcnEP6O7a
        VFh1pgRxeYzYNZ9Lg7Rg7nA4lgU5/gA+i828PFF5geU=
X-Google-Smtp-Source: APXvYqyRqy6fDSNNAlvoL/+Qw+rS1FDHlns1GXs9lq6+o5bnzRkoeVQaI1UKuw/cvGFR/gEhi7v5FmsirfBbOm50lmI=
X-Received: by 2002:a81:ed3:: with SMTP id 202mr29796733ywo.332.1559969665959;
 Fri, 07 Jun 2019 21:54:25 -0700 (PDT)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <tdteoenming@gmail.com>
Date:   Sat, 8 Jun 2019 12:54:14 +0800
Message-ID: <CANnei0FyP-vrJ8wug1BHPb9RHmF7S=K2jCcRAJgC+caL927WSQ@mail.gmail.com>
Subject: Targeted Individuals Get Fired from Employment/Jobs Frequently or All
 the Time
To:     linux-kernel@vger.kernel.org
Cc:     Turritopsis Dohrnii Teo En Ming <tdteoenming@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject/Topic: Targeted Individuals Get Fired from Employment/Jobs
Frequently or All the Time

8th JUNE 2019 Saturday Singapore Time

There are (perhaps) millions of Targeted Individuals in (perhaps)
every country all over the world.

According to accounts and experiences shared by many Targeted
Individuals all over the world, it is INEVITABLE for Targeted
Individuals to get fired from employment/jobs frequently or all the
time. Getting fired from employment/jobs frequently or all the time is
part and parcel of the targeting program. You should expect it.

As at 8th June 2019 Saturday Singapore Time, Mr. Turritopsis Dohrnii
Teo En Ming is 41 years old.

Mr. Turritopsis Dohrnii Teo En Ming is a TARGETED INDIVIDUAL (TI) in Singapore.

-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

********************************************************************************************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----
