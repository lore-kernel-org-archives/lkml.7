Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FD5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF8E21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553250352;
	bh=1I63S1dk/InPDRjg/NrPagqMlz8UGfgoiOSQsBiWlNk=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=NddX1DhQj4EJrcK8tCwUnkpldxzXdMB4z7Zn7h4k2qbKWyDXWsx7TNm5kSI9PQpuo
	 9O4KX+A1KSGu3sOHVAjAu4Ss4zlJmI5m/Opo9dvU1XhbE7iOWqk/Z/VvVbF9Kmqe1t
	 zUArwGEvvEf4pFvVNh+F5LNnO0oEdg6I6MPtpiP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbfCVKZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:25:51 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44201 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbfCVKZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:25:51 -0400
Received: by mail-ot1-f66.google.com with SMTP id d24so1437051otl.11;
        Fri, 22 Mar 2019 03:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Otf0tFSnPsUM+JD9Y87hPTiqoC5M7nqXJhhTVip//fw=;
        b=fWys9WMa6E4USeRvfwG3YEYTKpPuouAjm1sorV7ZApnvYgY/sn1A40WhcQ03ibQWFj
         nJyjIjdkogFxPq8LCWb8dEpcRtPMqt0C7duvnXqXWyxl9Gbhb+1ymOH65VlJlLxnkW3W
         WAEBftBZhHa1c0t7LDQXZinMHbqzJE7XcGbsuCyadx7Mrpto1ir2YDf4U8PuR7GqoEah
         DB3LrcJIkM5dUrYrgSbp6SL8WBn8TuUqRk8jvVQnjxdnobaYjmyWgGMaT4d2vorg3Y43
         pHmKKmVyiSWSTIJHzE8YNgoUZY2/bXu06IRjYrCjnMgltDJiivvd9Tco9MoT+btPZU96
         Zl+w==
X-Gm-Message-State: APjAAAUFEagmb95Jmu9Bbk30IVUDFtsEhRQ2yhk80UjdFuHA05Wb0OrA
        9v64CkIMDMc459fNmELi8/GHa33rUFc7bt2u0Ex92/jt
X-Google-Smtp-Source: APXvYqwgu6DD0JtNu01ANHo6pLn5tOZmqoOZuRvLFmJMOPkRkB/quDLDzgswjwSHZhYs0dov6RlMtuhF6bmC+L+GgTE=
X-Received: by 2002:a9d:36a:: with SMTP id 97mr5792406otv.124.1553250350033;
 Fri, 22 Mar 2019 03:25:50 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Mar 2019 11:25:39 +0100
Message-ID: <CAJZ5v0gTJn9fdpM_y2wL=y0vqGeJhvLKzoD_BfNj-yNkmepBnw@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.1-rc2
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
 pm-5.1-rc2

with top-most commit 112a04f653ddf1d4246415e8e0d820002ebe8dca

 Merge branch 'pm-domains' into pm

on top of commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b

 Linux 5.1-rc1

to receive power management fixes for 5.1-rc2.

These rearrange some code in the generic power domains (genpd)
framework to avoid a potential deadlock and make the turbostat
utility behave more as expected.

Specifics:

 - Rearrange the generic power domains (genpd) code to avoid a
   potential deadlock possible due to its interactions with the
   clock framework (Jiada Wang).

 - Make turbostat return the exit status of the command run
   under it if that command fails (David Arcari).

Thanks!


---------------

David Arcari (1):
      tools/power turbostat: return the exit status of a command

Jiada Wang (1):
      PM / Domains: Avoid a potential deadlock

---------------

 drivers/base/power/domain.c           | 13 ++++++-------
 tools/power/x86/turbostat/turbostat.c |  3 +++
 2 files changed, 9 insertions(+), 7 deletions(-)
