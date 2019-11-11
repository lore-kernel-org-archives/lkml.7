Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2694BC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 21:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8B120818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 21:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdZZlT9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfKKVL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 16:11:58 -0500
Received: from mail-qt1-f169.google.com ([209.85.160.169]:39450 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKVL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 16:11:58 -0500
Received: by mail-qt1-f169.google.com with SMTP id t8so17240933qtc.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 13:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Eygx+RQgz1TrA7ZHvdVeUuQMUKmms+Foj2D4RecocMU=;
        b=pdZZlT9g8nVXNnyW2bQQ4d4S9nt20P4JetgovJviswKkh/dCQikI9eYmD/kv/JuA6d
         eYg+bHUOpnuN/S1qajp139Ct1Js2vL+3t6cleGOXtMQKONVuh/48YhQIB8T3Hf4AMKMx
         Ld6/3+ybfhvHhaWfsM3BVVWnO2t8KSW7fg2V/KJYYrkmZrnbNGbNpsP9jRI6LxpzKw6r
         1cWGh4UvugQCnTt1e+EdHLbrmUHEYSHOE1nHwLrfmHhS2FgIT0nrzfQ8WdSF8Flmp3hR
         PAbVWrW5nJ+1rHqvpVSr1O0/PeWf4gtOzColqS6FmzOfUvTY/yHGOJOKXJRv9bPkkH4u
         HTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Eygx+RQgz1TrA7ZHvdVeUuQMUKmms+Foj2D4RecocMU=;
        b=MM74pE8H3/ikMu20sc/m9zrZXMUE1sqM7gDUZL+4Vu1T4+10xuh0yNsahnIM4qmjUk
         kdjd/aDPq5/FSjJEDnF/oCPcEaJVt5Rklou0HNkrsOimdQOudOjb6eVrmubhj8rOHFU5
         /id5Xr/Tdu5wZDyGqHL063bWLr6GT2iq2vbPT5/5YuHCXGJI372WRRf5Vv8HsDfqjp6F
         lWMqeNHkdXDmbgtgrW29OTBv/YjWhgGNxdp/n91g4OSY6F1hGUxv9e9BwkYJoWAYSrEu
         J3cTrcmh8qclp05QoxWvf99fRi1UPz2Rhi+RYohuMytPBEvL2Uy8jP5PtZS0YVYnUhkM
         b1TA==
X-Gm-Message-State: APjAAAXKfEP0JdX9frqrsSQ4/qk/zucf0ljw/Rp0hH9fQ55Aiuec1reM
        2FMptjxOrAsy3mq9UMFmVJltWdfll9dBLQpB7hmK5g==
X-Google-Smtp-Source: APXvYqw/MopXZ12yDThgOAQ5BTXbLqReQ+au4sqY6stDDUErbe9Ra/RwpGdbzmUBK76Cu40S6jf6BClReS2ivosrJvs=
X-Received: by 2002:ac8:458c:: with SMTP id l12mr28958635qtn.300.1573506717280;
 Mon, 11 Nov 2019 13:11:57 -0800 (PST)
MIME-Version: 1.0
From:   Scott Franco <scott.franco42@gmail.com>
Date:   Mon, 11 Nov 2019 13:11:46 -0800
Message-ID: <CAEXR0n+9k54HyksM8BSwg-zOJcAiqcUN3W0daSuhkLrKL0NDAQ@mail.gmail.com>
Subject: List of drivers that need implementation?
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am looking for a list or other information on drivers that are
needed for linux.
I am interested in writing and contributing a driver for linux.

Scott Franco
San Jose, CA
