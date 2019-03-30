Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EEBC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73657218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553906335;
	bh=WKVcfJArwzp60nvFMq7wdgFBBfkvA2EiWBm2vwiRKew=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=h+i/CTdpLRnK3GqKAqEMnm5TKDeaKRmj0YQFPPvS2tNddl34OH5C+C7DtmkjAEJtL
	 JgBsu09mQG/B0UqR6Zm5zComNuEeQ1FgDsvCm3JVSUOiM6+RXM5EkVb0y2HJjDBBC6
	 tZ/eBeHssRXlrZOqDteMTKWO5I9qovcL2mVttC3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbfC3Aiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:38:54 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34937 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbfC3Aiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:38:54 -0400
Received: by mail-ot1-f67.google.com with SMTP id m10so3770254otp.2;
        Fri, 29 Mar 2019 17:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rbaQuzfFASQ3AclL/67VJMY3SYB4Rc+PpDj0igrwlp8=;
        b=sOw5zeYuHWjhjXUKsFnGmyVUpZuUJKGzGd9PBvEhGvXGH0u2uLtzIRc5GjAmY11UOv
         jqdhobPGRWEy+SCtbwzYLYXtZsOho3chIB/VdcRpJ5a3+5OMtgQBX49Zclbhlp25duUu
         V0OPVpZXCBaBAKCU6IPkpl0EF9W+JCplwwo5EnxWboyuy+wno6MFvit4gE8qQH3kbnPU
         fyelcjL+R1XpVGgLIKctZZV5FV6ShRS1E30oJMRjflmHODHkLK5h1Kv6Y+Zwe+EdjAre
         LJJHOFd73TLeugDW93c8VR+jn3sG8MMYqUNF/U9/roLAJysg0KxLwitLNn3UPlQGmhcP
         ibew==
X-Gm-Message-State: APjAAAWRO4UmqpjDv2wKUkfH/Izq6WRavQBWeOkawSXRY5LxNOG++26V
        GWIS5qT39TE1Zj02Ccsyugnu+abFnlgnI1cwcrGudbnG
X-Google-Smtp-Source: APXvYqwkjIbxC1CxyTeHbcJLEEyXNYpBsIPR/glEuONXRzyHFWYJzwXh+n3cSa1wP9enHoIVjwK80kXPU5dxIfIMeAE=
X-Received: by 2002:a05:6830:13cd:: with SMTP id e13mr38248368otq.139.1553906333317;
 Fri, 29 Mar 2019 17:38:53 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 30 Mar 2019 01:38:42 +0100
Message-ID: <CAJZ5v0hx5EMHeJoS+OZDpg+vU3LVxX7gn3Jo4gbFB7Hyh3Kq4w@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v5.1-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.1-rc3

with top-most commit aa9aaa4d61c0048d3faad056893cd7860bbc084c

 ACPI: use different default debug value than ACPICA

on top of commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00

 Linux 5.1-rc2

to receive an ACPI fix for 5.1-rc3.

This corrects a previous attempt to make Linux use its own
set of ACPI debug flags different from the upstream ACPICA's
default (Erik Schmauss).

Thanks!


---------------

Erik Schmauss (1):
      ACPI: use different default debug value than ACPICA

---------------

 drivers/acpi/bus.c              | 3 ---
 include/acpi/acoutput.h         | 3 +++
 include/acpi/platform/aclinux.h | 5 +++++
 3 files changed, 8 insertions(+), 3 deletions(-)
