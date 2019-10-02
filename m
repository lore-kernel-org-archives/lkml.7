Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885FAC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5720A218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570005401;
	bh=VFLFSHajzI2XLLn4FHsTaAlDTg/W3cYVMp1YuwmvH+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dcon7HNJpDGV39IpcoimBW31Wtni0KAEN310vG6XZMfs1ZeQUf1nDAqzeX5EEosg0
	 v+6Ta3OnHJzc/lIl7i+LCqRXivhs7CovBrimfCPn2RswOmgMAhAlX9oUQ5wi3qFsqW
	 NQGA9NtitpMkaiw8s6z43G1gcdZ7kmJnn4A6HbwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfJBIgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 04:36:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfJBIgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 04:36:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 450E5206C0;
        Wed,  2 Oct 2019 08:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570005399;
        bh=VFLFSHajzI2XLLn4FHsTaAlDTg/W3cYVMp1YuwmvH+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NU1Ix/Kmiz0krydxGjDuB0292uZb9C/dOsf9acv0fu1756Hd3IBh+PhWnpmUalpe/
         XubQulKwgX/z9RyzfjUfu23qPcERhitR771kDKeWbaWB76ZsRM7P+tHa0JhMSpuGgn
         /VHIR1Hao1kR4zq3naP8EpA+dKkq2LXEuo+q7zJI=
Date:   Wed, 2 Oct 2019 10:36:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     alsa-devel@alsa-project.org, Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] soundwire: depend on ACPI
Message-ID: <20191002083637.GA1687317@kroah.com>
References: <20191002081717.GA4015@kitsune.suse.cz>
 <459d62805e8cb20e27667626e80d962569e7e83a.1570005196.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <459d62805e8cb20e27667626e80d962569e7e83a.1570005196.git.msuchanek@suse.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 10:33:29AM +0200, Michal Suchanek wrote:
> The device cannot be probed on !ACPI and gives this warning:
> 
> drivers/soundwire/slave.c:16:12: warning: ‘sdw_slave_add’ defined but
> not used [-Wunused-function]
>  static int sdw_slave_add(struct sdw_bus *bus,
>             ^~~~~~~~~~~~~
> 
> Fixes: 7c3cd189b86d ("soundwire: Add Master registration")
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  drivers/soundwire/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
