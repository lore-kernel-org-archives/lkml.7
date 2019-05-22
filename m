Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A76C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA702173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfEVOMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 10:12:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:55169 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbfEVOMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 10:12:00 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 07:11:59 -0700
X-ExtLoop1: 1
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by orsmga004.jf.intel.com with ESMTP; 22 May 2019 07:11:58 -0700
Date:   Wed, 22 May 2019 22:12:18 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: Re: [ubsan] f0996bc297: netperf.Throughput_total_tps -7.6% regression
Message-ID: <20190522141218.GI19312@shao2-debian>
References: <20190520053851.GY31424@shao2-debian>
 <4834add1-711e-b441-1956-1ab2b2d89353@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4834add1-711e-b441-1956-1ab2b2d89353@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 12:50:30PM +0300, Andrey Ryabinin wrote:
> 
> 
> On 5/20/19 8:38 AM, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed a -7.6% regression of netperf.Throughput_total_tps due to commit:
> > 
> > 
> > commit: f0996bc2978e02d2ea898101462b960f6119b18f ("ubsan: Fix nasty -Wbuiltin-declaration-mismatch GCC-9 warnings")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> 
> This can't be right. First of all the commit makes changes only lib/ubsan.c which is compiled only when CONFIG_UBSAN=y.
> In your config:
> # CONFIG_UBSAN is not set 
> 
> But even in the case of enabled UBSAN that commit doesn't change the generated machine code at all.

Hi,

Sorry for bringing you inconvenience. We retested the commit and
couldn't reproduce the regression, please ignore the invalid report.

Best Regards,
Rong Chen
