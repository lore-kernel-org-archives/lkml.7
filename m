Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E73CA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E5220650
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571938217;
	bh=HWjvtKIWHIIGX9H9A+0FKHSjpeIBIeBvz6LT9O9kz5M=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=zZrMBr4HjFYVoqhoGBayxIccroaDhHd+w1MNxjnoGhk9ybGh63GUNmhbULGkGTQlA
	 GgHP/xbOGcRRb0AHj193jXQigt5bKkct8StVwRIdFud8CTYnePPBX4H8HmmX0vPamY
	 9OrRPOcEhVNTcPjv9zOiXj0XcTA7W/C+aJxsmKLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503724AbfJXRaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:30:16 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40250 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732485AbfJXRaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 13:30:16 -0400
Received: by mail-oi1-f194.google.com with SMTP id b25so9705208oib.7;
        Thu, 24 Oct 2019 10:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lkOZbhZtMPsM/+I6o00it0XZr+ITWQy6XHnfXpN9P0E=;
        b=cApo0pBsgr4mTbUvd1CNk043+a9BVO0c9xzMbRC53vBrwhnnQPbJf09dHbtZtwgK/S
         NvX34tiMzF1cyPnJ/zX2rSboVGboY26oA1QTs5B4gAX/aMX+/76NSXd5bXRvPHMlm6xG
         ocifquTIhzXweklFRn4YvXTE03SGsuc/y1ScDvX+uu3MwMKBm19nsTNPEEvQGASgqzbO
         NWmOwxXoZ2Xm4A0WW6e/CcU8Rr6ZKAf/N0cPW58QIVVPYcsaX1nRg8Xl+4uFJbVzmZV2
         Ej7rpTkHG0hw2uhG09vQNG7cF+YCuT5gysGkITlmd08FzLAiW80RdaE8DVyvVcbYZh8K
         ktOw==
X-Gm-Message-State: APjAAAXWsQq5n0VkBkaApWRkeAbuW9AnLOaoSyU7mwikLwiLzfpa7PRL
        ekQH0TZdup6Tgbck5CNgzPGIrNhYiGkPbf6wZM9ItIKQ
X-Google-Smtp-Source: APXvYqwzcdAUK6yy3BxM08FDk8gjQyvykfdf8GrQRK34woNBfw6Uup4lfIxBeBio9dXS0N7g1LFyPFOOMdp5BhfcsP4=
X-Received: by 2002:aca:5885:: with SMTP id m127mr5852467oib.110.1571938215561;
 Thu, 24 Oct 2019 10:30:15 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 24 Oct 2019 19:30:04 +0200
Message-ID: <CAJZ5v0j98Lhfs1cW88vuEHZcjjQpCPCBS9B8yBvW1wWfWLSFYQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v5.4-rc5
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
 acpi-5.4-rc5

with top-most commit edffc70f505abdab885f4b4212438b4298dec78f

 ACPI: NFIT: Fix unlock on error in scrub_show()

on top of commit 7d194c2100ad2a6dded545887d02754948ca5241

 Linux 5.4-rc4

to receive an ACPI fix for 5.4-rc5.

This fixes a locking issue in the error code path of a function
that belongs to the sysfs interface exposed by the ACPI NFIT
handling code (Dan Carpenter).

Thanks!


---------------

Dan Carpenter (1):
      ACPI: NFIT: Fix unlock on error in scrub_show()

---------------

 drivers/acpi/nfit/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
