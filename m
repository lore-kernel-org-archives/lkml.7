Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A48C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2896B20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554409838;
	bh=IyKEUMkmdvvQD9qFpT1yZ0SBgAj8z8FePRAQwdKaBR4=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=pK40CwPVc7xMZq/wMRNE6cMqwa7LZ4XqfxliPyuIVcMM0ZNh1H6wJ7yOVMf/Oo1ya
	 cJSo4wwhvaW8v/70uAPSLDV5zXuVAixycLvCy1LzPdN8KVk/yIdRErt6WFrYX5rE3a
	 FRXGiIxa0ubQUllv4nF48dZsbk4W/97UMe6jjFT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbfDDUag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:30:36 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:41482 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbfDDUag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:30:36 -0400
Received: by mail-oi1-f181.google.com with SMTP id v7so3041043oie.8;
        Thu, 04 Apr 2019 13:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=DkYBEZOQj79OqTQIsnbrXxUqkGsFQTYaRg9IHgtHuro=;
        b=AWksn9uKTNoe2c7mxRk24EJMn8vCtcEZMbCyEoMRnx0e5vPYvqG8pijUdL1jIHbTkO
         es83YbRO3gTVzwBR4oMtnKx58N5WzWe1Nd7m6c8gPAREMbARjZW7t92ZjsUY3DNc0QKr
         58Npe3kOrb8dmTAexuvzuXidmw3udukHPzcaxWxhIHRvWoB2D+JRIXGnwDCCLG60i4n7
         3QA42M/9hg6N7zIqi2L8kAmD1bZaY5YvvRWSQ5ocCKsTNp+26GVxNdErR5gsv/Z/o/97
         uTBqCVrvn86vcpXLJtXPmrPZn7RWhVp1uNvRehnN0ndFv39g+7/lSo0z0CV4Vm8TExb7
         J+OA==
X-Gm-Message-State: APjAAAWdsL4tDx/Q7U9tbuwJKfUY7oSf9fm3B+STiZLuyiJgkQFRPLw0
        QbxXlw8HGcNxCkCChBJfx1c8KlIgiA9WiZ16eU8=
X-Google-Smtp-Source: APXvYqzHL5/7DvzqGLO+9NFM0gt9qFS7j/LMH5Pf1IelmUqjJ4ISGQEYs9Zy6Zk84qQClYuaFyMKe7bNdKkrcAPdai0=
X-Received: by 2002:aca:8d3:: with SMTP id 202mr4791567oii.76.1554409835678;
 Thu, 04 Apr 2019 13:30:35 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Apr 2019 22:30:24 +0200
Message-ID: <CAJZ5v0g=1Cdme_bigvg9JtxREs=e-kkpRo5-7HUuGEiy1bw0gA@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v5.1-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.1-rc4

with top-most commit b59fb7ef5240c301ca8b5b70d4298c0f053bb0c3

 Merge branch 'acpica' into acpi

on top of commit aa9aaa4d61c0048d3faad056893cd7860bbc084c

 ACPI: use different default debug value than ACPICA

to receive an ACPI fix for 5.1-rc4.

This prevents stale GPE events from triggering spurious system
wakeups from suspend-to-idle (Furquan Shaikh).

Thanks!


---------------

Furquan Shaikh (1):
      ACPICA: Clear status of GPEs before enabling them

---------------

 drivers/acpi/acpica/evgpe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
