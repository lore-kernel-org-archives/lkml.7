Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9551C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E75821855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569931812;
	bh=a5cL3S+QFFnwNgeP+e6UL2x9GqPIxmpSZxRvdEhn33E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rdCA3t1s/PfEayXEk/dxn69V7ht2Pl/uMOE8/Xjmc0NQbolD/EHsUI5ar5vJyB+Y2
	 yz7X3C1yiAscDzeIjTzHwYBUjB0E9HrzBXTgpuKW0vjNYitYR9nKm0gqu5nevd05WG
	 /DF2re4ASJdtbvZ6KUNGW/dUdriOT8EYXJkISNnw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733236AbfJAMKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfJAMKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:10:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0512920700;
        Tue,  1 Oct 2019 12:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569931809;
        bh=a5cL3S+QFFnwNgeP+e6UL2x9GqPIxmpSZxRvdEhn33E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fGA6zBOglwztn3J7HoZxiFsu6z+On/Ji+uYH3LuG+vqPlG1MycYsIFjIPa2kgzmQD
         ww1LQBMhbt2SoYx0UFETp3V8Y7foXox6PvM9bKzuKCFSvZffGLT/IIkd/BSvjfYTfF
         d40zKqeRkACVnogc3Ch5vzimOkOFkUKHvz7/77FQ=
Date:   Tue, 1 Oct 2019 14:10:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-usb@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Lukas Wunner <lukas@wunner.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/22] thunderbolt: Introduce tb_switch_is_icm()
Message-ID: <20191001121005.GA2951658@kroah.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-2-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001113830.13028-2-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 02:38:09PM +0300, Mika Westerberg wrote:
> We currently differentiate between SW CM and ICM by looking directly at

You should spell out what "SW CM" and "ICM" means please :)

thanks,

greg k-h
