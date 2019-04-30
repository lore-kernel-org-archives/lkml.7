Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADED3C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8C3217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556614637;
	bh=2BAjUOkeV2diCEDyebE/TAVgpUaOzNFKZGF/5eYK40s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=adqtfunT/oYUrukDeF7oV9ZTCxkt3B9tqb84nsDYpCxL8VvHVc6sQEno+WxuBdMbi
	 81aG68u2/2TbEcSyWMMPzZjFHl2r2BkH9EJkTu/wM64SD8LsgT4bUpuJV4S0xtfUJO
	 Z3ZxoR1kvyUX6PDDGAlyEYT/iC0Qg6XAe0b4rjpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfD3I5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 04:57:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfD3I5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 04:57:15 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ECE821670;
        Tue, 30 Apr 2019 08:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556614635;
        bh=2BAjUOkeV2diCEDyebE/TAVgpUaOzNFKZGF/5eYK40s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xCuWfKMeRms1wFCnCmz5hAdzhGJsrmYV5u8orcjtfHWWq9qrl1XiduiZGj1zP1s09
         m1cxKLEezealaJdpIkZ7JYntnVQn7SLdcZijX/Zy8dqeWAFoiJEJKzE5rnukRxXuHM
         mLf5ZVaUnyNQZheL1SvT8qsn4wYgHmp7lI/+yC8M=
Date:   Tue, 30 Apr 2019 14:27:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        liam.r.girdwood@linux.intel.com, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [PATCH v3 2/5] soundwire: fix style issues
Message-ID: <20190430085705.GT3845@vkoul-mobl.Dlink>
References: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
 <20190411031701.5926-3-pierre-louis.bossart@linux.intel.com>
 <20190414095839.GG28103@vkoul-mobl>
 <08ea1442-361a-ecfc-ca26-d3bd8a0ec37b@linux.intel.com>
 <37c5af39-a1e4-adc3-e8a9-bcada8e3b35b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37c5af39-a1e4-adc3-e8a9-bcada8e3b35b@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-04-19, 12:14, Pierre-Louis Bossart wrote:
> 
> > > >   enum sdw_command_response
> > > >   cdns_xfer_msg_defer(struct sdw_bus *bus,
> > > > -        struct sdw_msg *msg, struct sdw_defer *defer)
> > > > +            struct sdw_msg *msg, struct sdw_defer *defer)
> > > 
> > > this one too..
> > > 
> > > >   static int cdns_port_params(struct sdw_bus *bus,
> > > > -        struct sdw_port_params *p_params, unsigned int bank)
> > > > +                struct sdw_port_params *p_params, unsigned int bank)
> > > 
> > > here as well.. (and giving up on rest)
> > 
> > Please check for yourself that this is a diff illusion w/ tab space.
> 
> Vinod, can you please double-check, the alignment issues you reported don't
> exist, see e.g. below what the code looks like after merge.
> 
> 
> int sdw_transfer_defer(struct sdw_bus *bus, struct sdw_msg *msg,
>                        struct sdw_defer *defer)
> 
> int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
>                  u32 addr, size_t count, u16 dev_num, u8 flags, u8 *buf)

Sure, please split up as requested and I shall test apply and check
alignment before reporting...

-- 
~Vinod
