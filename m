Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31D1ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B501F20854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571136333;
	bh=77WBH2h9bRchd3kaucl/YpLXYB2oYx+m7W/9F0lJXvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y0B4HWcHG08cxFODMxa7yPMwg8zJyfqVq3QNNyjd1vOHl9pncdc93SLTT+UUZntAI
	 SbHQ09QzcQpA9jHJiKd2JhU/C7Ga2/sx5DhUnWZzqI328808WUbtMJqtc2fD8J26r8
	 yQ5wMNHL1qdl/KjtJ+BTpAN65ZSTtog6hqFUPX58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbfJOKpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 06:45:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbfJOKpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 06:45:32 -0400
Received: from localhost (unknown [171.76.96.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D741F2086A;
        Tue, 15 Oct 2019 10:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571136331;
        bh=77WBH2h9bRchd3kaucl/YpLXYB2oYx+m7W/9F0lJXvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PyUD/4NOrGSzWLXzapptVHYY7NBEA/f14KabnbZdQCl9yYXhRHHK5fNn6TQ+lYLco
         9UMGzrfIREaj2fHCHC1soEe6LP/nWEmlZczRND4gokDE9nCh9CH4xT4tAqati0PFls
         VGB5xQ5P4mYFXr3JVBie0/AXxoUNqMnz7fA9uHMo=
Date:   Tue, 15 Oct 2019 16:15:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     alsa-devel@alsa-project.org, Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] soundwire: depend on ACPI
Message-ID: <20191015104527.GX2654@vkoul-mobl>
References: <20191002081717.GA4015@kitsune.suse.cz>
 <bd685232ea511251eeb9554172f1524eabf9a46e.1570097621.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd685232ea511251eeb9554172f1524eabf9a46e.1570097621.git.msuchanek@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-10-19, 12:13, Michal Suchanek wrote:
> The device cannot be probed on !ACPI and gives this warning:
> 
> drivers/soundwire/slave.c:16:12: warning: ‘sdw_slave_add’ defined but
> not used [-Wunused-function]
>  static int sdw_slave_add(struct sdw_bus *bus,

Applied both, thanks
-- 
~Vinod
