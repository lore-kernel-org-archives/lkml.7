Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C91C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1FD2184D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564748104;
	bh=SL3n18pag6UgbTB7vpZp/1melFC8hev66163HGpiTr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=htQ8zEfvQXnZF6XCdVfHT8fkxlnvajawE4Dtmw5oA25AuZsRHigXuwvqYNAnq/BQO
	 A2hfPbVtpXKehqwfvbAPdIfMNe66Ls0kV8pC1PngVP77Ge5ukxb5cTsYwMgF398TGh
	 5PWJ7IuRqwPD1YYE8zmPMyb+XXQfcxbkOFudFw98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392592AbfHBMPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 08:15:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389277AbfHBMPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 08:15:02 -0400
Received: from localhost (unknown [122.167.106.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D932321842;
        Fri,  2 Aug 2019 12:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564748101;
        bh=SL3n18pag6UgbTB7vpZp/1melFC8hev66163HGpiTr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x4vcs0lcsJeK+bm/kJ7EovE4ykJAYZ5kZhuLRcF6awp1LkVTdRCUze0AUB/ke8Tyc
         bBgVc4Q92IBTCEKlOG1ntJcaFi5N2sfw7caEI8x7pOwjVIhhlkL7QOIF3fusL8YqLQ
         NKTevPpI9mtLrJIZtU061PXkueYkjCABFdrIBw9A=
Date:   Fri, 2 Aug 2019 17:43:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 14/40] soundwire: cadence_master: fix definitions for
 INTSTAT0/1
Message-ID: <20190802121348.GP12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-15-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-15-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
> Two off-by-one errors: INTSTAT0 missed BIT(31) and INTSTAT1 is only
> defined on first 16 bits.

Applied, thanks

-- 
~Vinod
