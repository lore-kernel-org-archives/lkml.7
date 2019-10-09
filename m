Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB506ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03C8218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbfJIPcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:32:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:41215 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729644AbfJIPcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:32:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 08:31:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,276,1566889200"; 
   d="scan'208";a="368776750"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga005.jf.intel.com with ESMTP; 09 Oct 2019 08:31:57 -0700
Message-ID: <2bdd9810959f1e3babb1684c95caf1e65bf45081.camel@linux.intel.com>
Subject: Re: [PATCH 0/3] Auto configuration mode and error
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andriy Shevchenko <andriy.shevchenko@intel.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 09 Oct 2019 08:31:57 -0700
In-Reply-To: <CAHp75VeJPNhuWK0NiTg9dWk9Kg26ApzVi7NUKfGxydHm1v6bPA@mail.gmail.com>
References: <20190923185906.76032-1-srinivas.pandruvada@linux.intel.com>
         <CAHp75VeJPNhuWK0NiTg9dWk9Kg26ApzVi7NUKfGxydHm1v6bPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-09 at 14:46 +0300, Andy Shevchenko wrote:
> On Thu, Sep 26, 2019 at 1:32 AM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > These are some changes, which help users to use the base-freq and
> > turbo-freq features without going through multiple steps for
> > basic configuration. Also add some error when user is trying
> > to disable core-power feature while it is getting used.
> > 
> > None of these patches are urgent and can wait for kernel version
> > v5.5.
> 
> I'm completely lost in ISST patches.
> Please send an updated version of the entire bunch of changes for
> ISST
> driver and do the same for tools.
There are no changes in driver.
Only tool.

Let me send in one series, both mine and Prarit's patches, which can be
applied on top of 5.4-rc2.

Thanks,
Srinivas


> Thanks.
> 
> I'm going to drop these ones from my review queue, so, I'm expecting
> it as a part of new version against tools.
> 

