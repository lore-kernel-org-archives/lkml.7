Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C91C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D11F20854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552563306;
	bh=oHcMZeGSpwDrMZBLflS3wXoDeMsSXCBkNRbF26gdBf0=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=EdqglXuVURoaGokLzhsegbmHrqWKgCxI8TQsKgi0muveQUENS+2qtF3ONId6+L27b
	 tuRrZjpdpjH/RKvXzm9FbGhSiDnRa1zXisI/PP7TtFZe8tgh9yGJQqF0jgi0H0M5jQ
	 QDeNW6m9qC/YVVgF1axQ2+GeCMz5hunutJup9i+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfCNLfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:35:05 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40873 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfCNLfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:35:04 -0400
Received: by mail-oi1-f195.google.com with SMTP id k11so4104552oic.7;
        Thu, 14 Mar 2019 04:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=DJXUg6BK6j8iIkIGRzDed4NlhXOL7YeHFuGQu3DEcX8=;
        b=domHe6BDU9wzNmTjJDn1E9KVx3SX3lCNPSeRUS0yDSF33Q8tf13euFgyi1YHuyMtH0
         ZpfjmiYEr9p36anz+QY9OVmLH7u0gGSEYbYalvDX8XOfmBUHy0ahSPJ3qv1salo7n6pk
         M3pELANVf5oAmT0+Rn/cZ0ch40LN2nBJ+wt4Cm5LVhTYy14GNXf5kLq++U6vTeIAEr6g
         nEz6ch2ScYb9DL3gVu5nlN1l+H16YNhCm6Ue5ZxHQpdjFyJ2qAMAkRz57qhP50q6wJmi
         Yvw4y/PHAJQzO+z7OyoYED3W5Frf+7bpwKzSPQCffR/Sk3PtdyQKE2JasUu2z29J7iWI
         Sx3A==
X-Gm-Message-State: APjAAAWpFXhaKfzmZcL+rCoZNtYM874J1Zwh3/IIgASvQT59wju9r+fL
        nJkb/zO5Fypkh5cc6/pcel4mhMHJmhsDx/vH+EtHvaWR
X-Google-Smtp-Source: APXvYqyMWBdF8XUdxPxCN/flJHAX2gXg2QXblJCEoFgtNsFcVb0L1BFSey37t/K6I3kdN99KkWljJazNxcAcBcfZmbk=
X-Received: by 2002:aca:cdcb:: with SMTP id d194mr1065674oig.76.1552563303116;
 Thu, 14 Mar 2019 04:35:03 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Mar 2019 12:34:51 +0100
Message-ID: <CAJZ5v0h0y40_bVqOyD-+hkCQmVv1vruO0donzjE7FOZ8jteubQ@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v5.1-rc1
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
 pm-5.1-rc1-2

with top-most commit b444e1aa3e48e13aea22162918bd6140c85142de

 Merge branches 'pm-opp' and 'pm-tools'

on top of commit ef8006846a3a97d9d8bf49e63dba948d0d2dbbf0

 Merge tag 'pm-5.1-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional power management updates for 5.1-rc1.

These are mostly fixes and cleanups on top of the previously merged
power management material for 5.1-rc1 with one cpupower utility
update that wasn't pushed earlier due to unfortunate timing.

Specifics:

 - Fix registration of new cpuidle governors partially broken during
   the 5.0 development cycle by mistake (Rafael Wysocki).

 - Avoid integer overflows in the menu cpuidle governor by making
   it discard the overflowing data points upfront (Rafael Wysocki).

 - Fix minor mistake in the recent update of the iowait boost
   computation in the intel_pstate driver (Rafael Wysocki).

 - Drop incorrect __init annotation from one function in the pxa2xx
   cpufreq driver (Arnd Bergmann).

 - Fix the operating performance points (OPP) framework
   initialization for devices in multiple power domains if
   only one of them is scalable (Rajendra Nayak).

 - Fix mistake in dev_pm_opp_set_rate() which causes it to skip
   updating the performance state if the new frequency is the same
   as the old one (Viresh Kumar).

 - Rework the cancellation of wakeup source timers to avoid
   potential issues with it and do some cleanups unlocked by
   that change (Viresh Kumar, Rafael Wysocki).

 - Clean up the code computing the active/suspended time of devices
   in the PM-runtime framework after recent changes (Ulf Hansson).

 - Make the power management infrastructure code use pr_fmt()
   consistently (Joe Perches).

 - Clean up the generic power domains (genpd) framework somewhat
   (Aisheng Dong).

 - Improve kerneldoc comments for two functions in the cpufreq core
   (Rafael Wysocki).

 - Fix typo in a PM QoS file description comment (Aisheng Dong).

 - Update the handling of CPU boost frequencies in the cpupower
   utility (Abhishek Goel).

Thanks!


---------------

Abhishek Goel (1):
      tools/power/cpupower: Display boost frequency separately

Aisheng Dong (4):
      PM / QoS: Fix typo in file description
      PM / Domains: Improve warn for multiple states but no governor
      PM / Domains: Return early for all errors in _genpd_power_off()
      PM / domains: Remove one unnecessary blank line

Arnd Bergmann (1):
      cpufreq: pxa2xx: remove incorrect __init annotation

Joe Perches (1):
      PM: Add and use pr_fmt()

Rafael J. Wysocki (5):
      cpuidle: menu: Avoid overflows when computing variance
      cpufreq: Improve kerneldoc comments for cpufreq_cpu_get/put()
      PM / wakeup: Drop wakeup_source_drop()
      cpufreq: intel_pstate: Fix up iowait_boost computation
      cpuidle: governor: Add new governors to cpuidle_governors again

Rajendra Nayak (1):
      OPP: Fix handling of multiple power domains

Ulf Hansson (2):
      PM-runtime: Consolidate code to get active/suspended time
      PM-runtime: Call pm_runtime_active|suspended_time() from sysfs

Viresh Kumar (2):
      PM / wakeup: Rework wakeup source timer cancellation
      PM / OPP: Update performance state when freq == old_freq

---------------

 drivers/base/power/domain.c               | 20 ++++++++-------
 drivers/base/power/domain_governor.c      |  1 -
 drivers/base/power/main.c                 | 21 ++++++++--------
 drivers/base/power/power.h                |  1 +
 drivers/base/power/qos.c                  |  2 +-
 drivers/base/power/runtime.c              | 16 +++++++++---
 drivers/base/power/sysfs.c                | 12 ++-------
 drivers/base/power/trace.c                |  2 ++
 drivers/base/power/wakeup.c               | 30 ++++++++--------------
 drivers/cpufreq/cpufreq.c                 | 24 +++++++-----------
 drivers/cpufreq/intel_pstate.c            |  2 +-
 drivers/cpufreq/pxa2xx-cpufreq.c          |  4 +--
 drivers/cpuidle/governor.c                |  1 +
 drivers/cpuidle/governors/menu.c          |  2 +-
 drivers/opp/core.c                        |  2 +-
 drivers/opp/of.c                          | 16 ++++++++++--
 include/linux/pm.h                        |  1 -
 include/linux/pm_wakeup.h                 |  9 -------
 tools/power/cpupower/lib/cpufreq.c        | 19 ++++++++------
 tools/power/cpupower/lib/cpufreq.h        | 16 ++++++------
 tools/power/cpupower/utils/cpufreq-info.c | 42 +++++++++++++++++++++++--------
 21 files changed, 131 insertions(+), 112 deletions(-)
