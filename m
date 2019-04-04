Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649D5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E9720855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554409937;
	bh=e92RXYybjo2IDDkMY9ULyhuyTWKSoaC9udKKbwC5eZo=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=QZg6V5L6mqg4VENPtvjuJr9UuheRuN0nMgWTVxDYsNXx/+b5rlTqK0JB9NDqy6BDs
	 1gjyZfGLDFfU/fjW+JPnY1gAZa6RRQmKb7CzQRPWhOafx2b5z2/jFslDOy2VNpG4z5
	 8Ggemcc0WdcJUEgtgI0zHjlFG2R5Rc3wprHO4P/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbfDDUcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:32:16 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:40220 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbfDDUcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:32:15 -0400
Received: by mail-ot1-f47.google.com with SMTP id t8so3605154otp.7;
        Thu, 04 Apr 2019 13:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kfgD7KFRC+UYpOaNUYdHEEubo0lFX/lcRm62P99TMf0=;
        b=a8X56tQWBy7u2rCKc5cnhsUr8o7veF0psqoxK+pNFU9UeapAZ8j0rUyrEKLqmD4ZMh
         CLccoAVwnKKr2tcCFMnXXqkQkSGdg+hRadkkj6g8iNxwWZXdMP0q9JjHsKqEMafqLwKH
         HVlu0Cuc3eOlL7Y+xTgQRiTEGw2sTBs2WPjp8gROmEWMtbwFYIMLw3EBcogF1pGz/TgB
         lGkaOnBnNPj7sdA+NVwj1n6k4gSLkJp8quKyiQX2ApPChG081cDRvdX3YLiesQdEfvts
         cQ2lZVPyJLo2t4cxfW22CkkQoQwWwk9YtCixO6RemYlfraw0Gs/snYFJ6CZiAE1esfK4
         Wtqg==
X-Gm-Message-State: APjAAAUx3cOTvR6RnAK1oBHw54Djq3r7TA5l/XU+U3C/EapkwH3SbBFN
        DJoQTucEoQ+vl8CedNm2EHuWbETsqQcs7t9bqZ0=
X-Google-Smtp-Source: APXvYqyC5/VzG1zho7zMfCMTyyI+MocMwEVz7gP/Fca7W9g4CQ2z7j1csrBbfGJBRdDEKlKNXuX4eKNvu9GPHtN7n7E=
X-Received: by 2002:a9d:6646:: with SMTP id q6mr5820895otm.20.1554409934844;
 Thu, 04 Apr 2019 13:32:14 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Apr 2019 22:32:04 +0200
Message-ID: <CAJZ5v0gC4WmXra1RXCxQ8-xa2xfx6PaSost_sf9XUL4wTVeRNQ@mail.gmail.com>
Subject: [GIT PULL] Power management material for v5.1-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.1-rc4

with top-most commit 58b0cf8e2418c05ed277c83b5529bd0568bfcc78

 Merge branch 'pm-tools'

on top of commit 79a3aaa7b82e3106be97842dedfd8429248896e6

 Linux 5.1-rc3

to receive power management material for 5.1-rc4.

These fix up the intel_pstate driver after recent changes to prevent
it from printing pointless messages and update the turbostat utility
(mostly fixes and new hardware support).

Specifics:

 - Make intel_pstate only load on Intel processors and prevent it
   from printing pointless failure messages (Borislav Petkov).

 - Update the turbostat utility:
   * Assorted fixes (Ben Hutchings, Len Brown, Prarit Bhargava).
   * Support for AMD Fam 17h (Zen) RAPL and package power (Calvin
     Walton).
   * Support for Intel Icelake and for systems with more than one
     die per package (Len Brown).
   * Cleanups (Len Brown).

Thanks!


---------------

Ben Hutchings (1):
      tools/power turbostat: Add checks for failure of fgets() and fscanf()

Borislav Petkov (1):
      cpufreq/intel_pstate: Load only on Intel hardware

Calvin Walton (2):
      tools/power turbostat: Add support for AMD Fam 17h (Zen) RAPL
      tools/power turbostat: Also read package power on AMD F17h (Zen)

Len Brown (6):
      tools/power turbostat: Restore ability to execute in topology-order
      tools/power turbostat: Cleanup CC3-skip code
      tools/power turbostat: Cleanup CNL-specific code
      tools/power turbostat: Add Icelake support
      tools/power turbostat: Add Die column
      tools/power turbostat: update version number

Prarit Bhargava (2):
      tools/power turbostat: Do not display an error on systems
without a cpufreq driver
      tools/power turbostat: Warn on bad ACPI LPIT data

---------------

 drivers/cpufreq/intel_pstate.c        |   5 +-
 tools/power/x86/turbostat/turbostat.c | 277 +++++++++++++++++++++++++++-------
 2 files changed, 223 insertions(+), 59 deletions(-)
