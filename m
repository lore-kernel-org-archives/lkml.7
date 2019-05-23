Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E29C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5424C20881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/mEzYHv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbfEWNm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 09:42:56 -0400
Received: from mail-yw1-f54.google.com ([209.85.161.54]:46933 "EHLO
        mail-yw1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbfEWNmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 09:42:55 -0400
Received: by mail-yw1-f54.google.com with SMTP id a130so2263160ywe.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 06:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=d2xwc7F6zHpKnKXnQOqNB0N8tTOjZfh0iNokUhkE8N4=;
        b=Q/mEzYHv/LzzLjjXZezenAJGG4CglTKkb0JzShP61tkCXInb6SeS1vSpboO7U/PQAv
         DyIn6UjgC5F9ryv3a2XRAnyZJLcgk/0jGOMFT25HqebPxF0kql/smA9UgzXWYp2RQY3O
         W4Yvw8T5OH5a8qokiIi78U7MsKxKGdhv36GFHqwux6j7y4vaaoGyKXxwPHZmFstblSXP
         dBrE1IEGfi6tUwFUgcqwObC6g52HwBwuJwTctw945IHKFB4UZTR3sWhNrCc+pzEbmt+C
         2vR/vfjJ+LNNAqkd+xl5oij4Wos6fJ2slPJtwO/4kQRJvzfF8UAFlsc472mY1BL3UzwW
         SUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=d2xwc7F6zHpKnKXnQOqNB0N8tTOjZfh0iNokUhkE8N4=;
        b=OzrNNtKBypMF6ObTn0lHxEgZOd213v5XzJuUkre+fNBreD3wa7WUAZtTZazB3lxgd8
         yCQVsOer540fhSXrPCzbBaahkWX4YTnD6PaeWdBTycTedVKfLJUCRe+on8735VtVJkag
         igga1n4hqssBk3rVzzEtT+omYFhM5EdXM8qfnUOEgw5r4l9gKM08twpVNj6UT2iuZn1T
         RBWVrMWNZuuk6FUNtkCfwTsvPQYNlI0/QBc/okPepz1zxLK3X0mKO7UzNv9zYgogQkiY
         ZBBdOULMBiVtAO8J9Gj7+HMknTjckDyUp7jeftMPwip4QXWu4JBdH05C/QYvCR+v+Loc
         c/Ow==
X-Gm-Message-State: APjAAAXWA/OUtGPFQIKTQaO5S5fKewVUiazqh25jWOKo9kcqzB9hMcXE
        VeEuuZ7ssQMwZeKETcId7g5lbxiJDhCHpfHSxQw5Lps=
X-Google-Smtp-Source: APXvYqw4V0graIIIMCuvHnVAS8i7B8loZ7t9QmYPYmeEk4jL9/auSxOx0XQ8psSyQdcgMxoTXVmhVLgIk2oDmGs/lTA=
X-Received: by 2002:a81:456:: with SMTP id 83mr37474969ywe.118.1558618974748;
 Thu, 23 May 2019 06:42:54 -0700 (PDT)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <tdteoenming@gmail.com>
Date:   Thu, 23 May 2019 21:42:40 +0800
Message-ID: <CANnei0GomXJiFRFdkq4uUB8aReUN91v1T36hVTyNnR0NEPO-GA@mail.gmail.com>
Subject: Workplace Mobbing: Bullying at the Workplace
To:     linux-kernel@vger.kernel.org
Cc:     Turritopsis Dohrnii Teo En Ming <tdteoenming@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject/Topic: Workplace Mobbing: Bullying at the Workplace

23rd May 2019 9:30 PM Singapore Time GMT+8

There are (perhaps) millions of Targeted Individuals (TIs) in
(perhaps) every country all over the world.

According to accounts and experiences shared by many Targeted
Individuals, every Targeted Individual will definitely be subjected to
workplace mobbing (being bullied at the workplace). This is all part
and parcel of the targeting program.

Mr. Turritopsis Dohrnii Teo En Ming is a Targeted Individual in Singapore.

Mr. Turritopsis Dohrnii Teo En Ming is 41 years old as at 23rd May 2019.

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
