Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36EBC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 19:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9DEF2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 19:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570388863;
	bh=1+a1P86vDBZFDcgIKM5nCAuEzuynge9LZ7okl9r776E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZnvtXPF/Tqed/6lsj/Td8KGwbMgRqlRIvQjnccDzaNfPWyScxH8+B5QCJI4Hb4IbR
	 GNVo6iPiHoGFidVuRwP+H3T85LVNbpux83dUb9sVA5kXfcQ0mRQ9NBYXraQAmRKpQN
	 9zpH/zUndh1vP+jXJwhKm45q/vQ67IR2NMvTGJs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfJFTHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 15:07:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfJFTH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 15:07:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7BD02080F;
        Sun,  6 Oct 2019 19:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570388849;
        bh=1+a1P86vDBZFDcgIKM5nCAuEzuynge9LZ7okl9r776E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ed/zLDbhWVeyQY9RO4BBK/h/N8GZJEmTTwD0Y/+QDduhVITMdUtUHb8FISwMJVBPm
         dn7jFIX4hJ2s5jnourG5SrVVORfn41maPTfyGQNim695z0TRstmE/wTepZDvZfaCF5
         /ySNsv+pnLcJhEPFrJqPEQBiThOvR11qFg6YAlMw=
Date:   Sun, 6 Oct 2019 21:07:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, abbotti@mev.co.uk, olsonse@umich.edu
Subject: Re: [PATCH] staging: comedi: Capitalize macro name to fix camelcase
 checkpatch warning
Message-ID: <20191006190726.GB237538@kroah.com>
References: <20191006184903.12089-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006184903.12089-1-jbi.octave@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2019 at 07:49:03PM +0100, Jules Irenge wrote:
> Capitalize RANGE_mA to fix camelcase check warning.
> Issue reported by checkpatch.pl
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  drivers/staging/comedi/comedidev.h           | 2 +-
>  drivers/staging/comedi/drivers/adv_pci1724.c | 4 ++--
>  drivers/staging/comedi/drivers/dac02.c       | 2 +-
>  drivers/staging/comedi/range.c               | 6 +++---
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/comedi/comedidev.h b/drivers/staging/comedi/comedidev.h
> index 54c091866777..2fc536db203c 100644
> --- a/drivers/staging/comedi/comedidev.h
> +++ b/drivers/staging/comedi/comedidev.h
> @@ -603,7 +603,7 @@ int comedi_check_chanlist(struct comedi_subdevice *s,
>  
>  #define RANGE(a, b)		{(a) * 1e6, (b) * 1e6, 0}
>  #define RANGE_ext(a, b)		{(a) * 1e6, (b) * 1e6, RF_EXTERNAL}
> -#define RANGE_mA(a, b)		{(a) * 1e6, (b) * 1e6, UNIT_MA}
> +#define RANGE_MA(a, b)		{(a) * 1e6, (b) * 1e6, UNIT_MA}

Did you send this patch twice?

Anyway, this is the units "mA", which needs to be "mA" for obvious
reasons.  Sorry, checkpatch is wrong in thsi case.

thanks,

greg k-h
