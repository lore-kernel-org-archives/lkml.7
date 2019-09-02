Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEAEC3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4824B21883
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567440057;
	bh=mJwEXeh9CSD/UGKpq5I8/EKKhuH0yp4LBIc3MRNKusI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hj8kx2CX2hJGUYgd3cLyIZJG8oGBP7gVD7q1OLHQ6U/yCmtEmgxD3vKwuZ3w0koqP
	 5uZlRnopr88RrKQO45GB4NwDVD74c+XlH/ow7ZmwJMoV0Qt/NYw68Vf9CFgbzmh3iB
	 R5jrDTCuYNebPXXNJG02B71Dx5MIoF0Q8p5om6Rk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfIBQA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 12:00:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbfIBQA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 12:00:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C89E921881;
        Mon,  2 Sep 2019 16:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567440055;
        bh=mJwEXeh9CSD/UGKpq5I8/EKKhuH0yp4LBIc3MRNKusI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IokDy13upxRjfjtUAgiANVVb5OnMLv/ypAQlXMRYwgf7PNYfawBES++kL3BndpSyq
         wmRXla5ruFdg/4tW1jDyC7volEhHr3UqY75gAI2gconNIjwmU+MH2nmHgpOo8zWGXa
         yjHRGES2Yuocvxc4Ka10XexzBKcrvhehbuY4UkEs=
Date:   Mon, 2 Sep 2019 18:00:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hui Peng <benquike@gmail.com>
Cc:     stable@vger.kernel.org,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Wenwen Wang <wang6495@umn.edu>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Fix a stack buffer overflow bug in check_input_term
Message-ID: <20190902160044.GC21884@kroah.com>
References: <20190830214730.27842-1-benquike@gmail.com>
 <CAKpmkkWv2cjrJCkVhGmEMnLG2_kCNxdbt29dZ8j-UM8Cf3quGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKpmkkWv2cjrJCkVhGmEMnLG2_kCNxdbt29dZ8j-UM8Cf3quGQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 05:51:17PM -0400, Hui Peng wrote:
> This is the backported patch for the following fix to v4.4.x and v4.14.x:
> 19bce474c45b ("ALSA: usb-audio: Fix a stack buffer overflow bug in
> check_input_term")

Now queued up, thanks.

greg k-h
