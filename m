Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CC2C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E48B22CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbfIDKsH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 06:48:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:56244 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725840AbfIDKsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 06:48:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BF4C4AD94;
        Wed,  4 Sep 2019 10:48:05 +0000 (UTC)
Date:   Wed, 4 Sep 2019 12:48:03 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, alsa-devel@alsa-project.org,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: slave: Fix unused function warning on !ACPI
Message-ID: <20190904124803.1700a65a@naga>
In-Reply-To: <20190904093052.GQ2672@vkoul-mobl>
References: <20190830185212.25144-1-msuchanek@suse.de>
        <f8c58d45-e641-5071-33bf-2927a61cb419@infradead.org>
        <20190904093052.GQ2672@vkoul-mobl>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2019 15:00:52 +0530
Vinod Koul <vkoul@kernel.org> wrote:

> On 30-08-19, 11:56, Randy Dunlap wrote:
> > On 8/30/19 11:52 AM, Michal Suchanek wrote:  
> > > Fixes the following warning on !ACPI systems:
> > > 
> > > drivers/soundwire/slave.c:16:12: warning: ‘sdw_slave_add’ defined but
> > > not used [-Wunused-function]
> > >  static int sdw_slave_add(struct sdw_bus *bus,
> > >             ^~~~~~~~~~~~~
> > > 
> > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>  
> > 
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > 
> > I was about to send the same patch.  
> 
> So I have applied Srini's patches which add DT support and they use
> sdw_slave_add(). So next tomorrow should not see this error as it is now
> used by DT parts as well.
> 
> So dropping this patch
> 

That should fix the issue for me. I wonder if !ACPI !DT platforms are
still a thing.

Thanks

Michal
