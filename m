Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C724C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 06:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A251218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 06:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553322802;
	bh=h4GOi6W9NlH/jO055LyAVrumrXCY+vgkg+KpAF8DfKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EPl0Aei9+SRv5CAv6IyuBddttCwoflGmOSeCuIMk3p0oG+cUQpTEXv47MshTTKxEL
	 358F6RkQ1TmBMgpu8DPtKdMM1h3Idhm7D1TYsoBmq5ad11ex2G2pBaLt3fduMqxQyp
	 6Jsoavo3WJZIZYBwZc11ACcI5TLG9/u67OZ6X0pM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfCWGdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 02:33:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfCWGdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 02:33:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84767218B0;
        Sat, 23 Mar 2019 06:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553322798;
        bh=h4GOi6W9NlH/jO055LyAVrumrXCY+vgkg+KpAF8DfKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vACviAQDl+M6M+7QhveZGl0qulXynfB1C7V1WdIDnm/ue8oVB4utAvaIQHkiOQIxQ
         UDgwARg0p8o+yooJXAkSxMDwy11ILGV3CmYh053Lk15w16wmwr9E+yT5NN3PmZ+W/y
         eaM8cYSS6zTbGeeasPMhMfYY9E91KY+5htspxuYs=
Date:   Sat, 23 Mar 2019 07:33:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "He, Bo" <bo.he@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Zhang, Jun" <jun.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Xiao, Jin" <jin.xiao@intel.com>,
        "Bai, Jie A" <jie.a.bai@intel.com>
Subject: Re: [PATCH 3.18 132/134] rcu: Do RCU GP kthread self-wakeup from
 softirq and interrupt
Message-ID: <20190323063315.GB31361@kroah.com>
References: <20190322111210.465931067@linuxfoundation.org>
 <20190322111220.102008032@linuxfoundation.org>
 <CD6925E8781EFD4D8E11882D20FC406D52A646D1@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CD6925E8781EFD4D8E11882D20FC406D52A646D1@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 04:00:17PM +0000, He, Bo wrote:
> Hi, Greg:
> 	Can you hold on the 3.18-stable branch, it seems there are some issue, please see the comments from Paul:
> 
> Comments from Paul:
> I subjected all of the others to light rcutorture testing, which they passed.  This v3.18 patch hung, however.  Trying it again with stock
> v3.18 got the same hang, so I believe we can exonerate the patch and give it a good firm "maybe" on 3.18.
> 
> Worth paying special attention to further test results from 3.18.x, though!

Ok, I've dropped this from the 3.18.y queue now, thanks.

greg k-h
