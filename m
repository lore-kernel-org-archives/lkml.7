Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B68C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 19:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60359217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 19:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0Gg2fY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfEJTrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 15:47:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34879 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfEJTr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 15:47:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id w12so9130391wrp.2;
        Fri, 10 May 2019 12:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=+Z10X2I8eWBUsmYd5fEEytGWYHdbZjr+b9Ewl7br5hM=;
        b=A0Gg2fY0s9hY42vX5j2KULfzxQcaBQfMx391RVaUMNZ4l1KN/zmOn79swxosX8kHuA
         h7YB+C0uNpYY0bpzbh/1xsFI97XBqlff3Whag+XDQiXALrkk0IQKkTz022jpzeDnNdV9
         nAn2w2dAgg6WMayPBBRPqQwsqnUO4XpnENr4Vl+f3BGp1EBbuy1sNu8uNmWEor2iZ1Ri
         B7M38KLJJrZPRw1XvNwQXEeYRuyUnPEqncD+gGQon7I+Y0LjWOXqXovJRhmz0SVhqTkG
         V9gQw7OoLXa1q4NaY9wo1xoPGRvDMmFqDlhum09JsgFJA+D95bBDUBPemfzuXaPhZHCN
         0mYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=+Z10X2I8eWBUsmYd5fEEytGWYHdbZjr+b9Ewl7br5hM=;
        b=j4B+U2WaNQNM8/lhI8JlR9z0lUE8GVappPbXOenTdQ570PbOLJLUDMPGPci0/7gBM8
         XOW74HHkTfq1OwDM3EiTsVbIOQmHCGo/pLND1DL8C+95gc4JQHAw7SGca6tqSQS0hzxG
         S7wLGM1a2Y6QkRwq1I7YesgD0p9mDdeAuCPOVict1OqPgC9xCEOQMrW/XhXwTKOGLAyK
         SNQEhBvPl3F+ONb3HXxMIAMaTfqoYFqNDV9WNTMgko5+10sANHwiLpvI358IrRk8bnLF
         B/XpH19OG6a1LjUar+6NrBFztFANRVBp0eXxNVhlccdWKi3qzj71ntJMangrBmFHHwWf
         +o4g==
X-Gm-Message-State: APjAAAUHoW7kWnDnKpSt8QLpBWUQU9yCYFXKT//rCcrryfHBHN0y6Lp7
        R7M5DBO6ADJIdlBUW15n3H7vAUff2uoD70ECEdA=
X-Google-Smtp-Source: APXvYqwjVyCRx5QvqmlrGwC/WUsOpuy4IIJ23H6/koVE0IynXyNioRq4vIzayTZzqnsMGY+js8kuSHG6QWa6T1oPXAc=
X-Received: by 2002:a5d:518d:: with SMTP id k13mr7782838wrv.285.1557517647382;
 Fri, 10 May 2019 12:47:27 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 10 May 2019 21:47:14 +0200
Message-ID: <CA+icZUWSJSnKcoYeh__v_BLnXP5O0XGewLdGenz13extauRr_w@mail.gmail.com>
Subject: Linux v5.1.1
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I have seen that all other Linux-stable Git branches got a new release.

What happened to Linux-stable-5.1.y and v5.1.1 release?

Is there a show-stopper?

Thanks.

Regards,
- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/
