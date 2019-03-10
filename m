Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A462AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 10:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F79206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 10:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552213314;
	bh=9qRzJ5FkFJf5RSuMpVuuXwrJxhWbmsFIvFiaQp5+phg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ePhc/AgaeafGSKPGccGBJT4Z7whAxYRNQT7a3gbITwf1JfQlAzMTlbPCZaRQYW4+h
	 kpjLnDJMxUDV9nNpAjZy9gBvVz9NFrsK3BVR4dsgnTfC4IHGZPvOqONt4GbrmLi+o8
	 fMKzK6yYe2y8OxtFaCphN3bnbSsb48gjJR7C34/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfCJKVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 06:21:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfCJKVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 06:21:52 -0400
Received: from localhost (unknown [178.230.118.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B6FD206BA;
        Sun, 10 Mar 2019 10:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552213312;
        bh=9qRzJ5FkFJf5RSuMpVuuXwrJxhWbmsFIvFiaQp5+phg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FQLogIGZk17gPv0zObNNbeSXe9/j5wnShDnWkntBnPE5OXd8/4IqKj1vxYr+r5zAj
         lAW/rkozVByXT5U1nrOATdahhOk5P77nslrddIshVnsK6GnpNCx7bjVAgkPoZnanIp
         DsMlBjsJ41dO/66vBkVXGx0MSHauEYtBhexlc1Cg=
Date:   Sun, 10 Mar 2019 11:21:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [char-misc] mei: convert to SPDX license tags
Message-ID: <20190310102147.GA4603@kroah.com>
References: <20190310100323.6912-1-tomas.winkler@intel.com>
 <20190310094817.GA2987@kroah.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DAC7ED3@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9DAC7ED3@hasmsx108.ger.corp.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 10:14:03AM +0000, Winkler, Tomas wrote:
> > Please break this up into two (at the least) patches and resend as a series.
> 
> Can you be please,  more specific what split are you expecting. 

You are doing lots of different types of things in the same patch.
Break up the logical changes into different patches.  For example, one
patch that updates copyright years, one that removes boiler plate
license crud, and another that adds missing spdx lines.

greg k-h
