Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A52C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7755322DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567589522;
	bh=WgIUy8LE9J87OsA/15aWqvYEgaNDugjXyzgcT2llIIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kFRDDT2pO8raXe5aSCypdyjgTaA3+JLTLDeGZjAtwCbxZVQGbEnrPhZsSjH+EHctW
	 k+XikQegGHxXHiAYWBe0+YFllNh967WTzm2ccjT7WgDiZTBsQ1KA/qVgG4X5LMF0nK
	 kINr4XK/RM+G8wXNOcIOCZbovrWiQ1We4GMX3AVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfIDJcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 05:32:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfIDJcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:32:01 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A6FA21670;
        Wed,  4 Sep 2019 09:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567589520;
        bh=WgIUy8LE9J87OsA/15aWqvYEgaNDugjXyzgcT2llIIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GtGomH9v7txv+9qLZ9tZuCxIymaWrnwtZSsPvbYLctwoeAEUuyslKGLcUZ/PKqz7q
         aOsrl7gZPrpoqor59+m+aIqPC1tIM4lZfBHb36sjPuufs3+zaeru6XFkFV+QiG5/ts
         f0KpSkqiYCQL0QnrTdu5DYpv7uaKvXHC1C7MCldM=
Date:   Wed, 4 Sep 2019 15:00:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Michal Suchanek <msuchanek@suse.de>, alsa-devel@alsa-project.org,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: slave: Fix unused function warning on !ACPI
Message-ID: <20190904093052.GQ2672@vkoul-mobl>
References: <20190830185212.25144-1-msuchanek@suse.de>
 <f8c58d45-e641-5071-33bf-2927a61cb419@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8c58d45-e641-5071-33bf-2927a61cb419@infradead.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-08-19, 11:56, Randy Dunlap wrote:
> On 8/30/19 11:52 AM, Michal Suchanek wrote:
> > Fixes the following warning on !ACPI systems:
> > 
> > drivers/soundwire/slave.c:16:12: warning: ‘sdw_slave_add’ defined but
> > not used [-Wunused-function]
> >  static int sdw_slave_add(struct sdw_bus *bus,
> >             ^~~~~~~~~~~~~
> > 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> 
> I was about to send the same patch.

So I have applied Srini's patches which add DT support and they use
sdw_slave_add(). So next tomorrow should not see this error as it is now
used by DT parts as well.

So dropping this patch

-- 
~Vinod
