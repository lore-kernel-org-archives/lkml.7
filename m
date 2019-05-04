Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80667C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 13:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E682084A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 13:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556978028;
	bh=WfKrli9NxFZ1MyHT7ScwxhzlaXYXdP6xJdYBwmTaKHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FWLcUxXkHciTnjyxxTq0o6DgYO2cBfci61qJYsXTe94OjVNg2OQHzhJfB8hqGDs0X
	 mK3MuTbHwVsx1NR4wygszjiu/cEBrp6TzqvzeJUJ+5z9pZ96snPx+DbO1vQeu4eAML
	 Ka6za1XtKEv9BL3t/I/GhTMFS3f1rAgN9I0JZb90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfEDNxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 09:53:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbfEDNxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 09:53:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D034C20645;
        Sat,  4 May 2019 13:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556978026;
        bh=WfKrli9NxFZ1MyHT7ScwxhzlaXYXdP6xJdYBwmTaKHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MLPN1HgBXmWZzRUJSxnoK0EK4Gu1oetRXLt4z4sxLT84MJqoxl9Jvr5QVKQdNrthq
         om/VvGANopBbKUdWVAj3NF1vv0BJM42eX0nPF10R5OKXb2CoqYiTLGtsBDzg2R08t5
         Kk8OGHHqWmhe5t1dbBvn3g7MNCfpNGm8JhaOwRCo=
Date:   Sat, 4 May 2019 15:53:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/8] sysfs: Add sysfs_update_groups function
Message-ID: <20190504135344.GB6989@kroah.com>
References: <20190504125207.24662-1-jolsa@kernel.org>
 <20190504125207.24662-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190504125207.24662-2-jolsa@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2019 at 02:52:00PM +0200, Jiri Olsa wrote:
> Adding sysfs_update_groups function to update
> multiple groups.
> 
> TODO:
> 
> I'm not sure how to handle error path in here,
> currently it removes the whole updated group
> together with already existing (not updated)
> attributes.

I think that should be fine.  The chance of an error happening here is
really slim.

> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

